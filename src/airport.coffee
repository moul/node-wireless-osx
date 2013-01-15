{spawn, exec} =  require 'child_process'
{EventEmitter} = require 'events'
plist =          require 'plist'

class Airport extends EventEmitter
  constructor: (@options = {}) ->
    @options = iface: @options if 'string' is typeof @options
    @options.airport_bin ?= '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
    @options.iface ?=       'en0'
    @options.verbose ?=     false

  _system: (args) =>
    spawn @options.airport_bin, args, stdio: "inherit"

  _exec: (args, fn) =>
    args = [args] if 'string' is typeof args
    command = "#{@options.airport_bin} #{args.join ' '}"
    console.info command if @options.verbose
    exec command, fn

  _parse: (buffer, fn) =>
    try
      return fn false, plist.parseStringSync buffer
    catch e
      return fn true, e

  _execAndParse: (args, fn) =>
    @_exec args, (err, stdout, stderr) =>
      return fn err, {stdout: stdout, stderr: stderr} if err
      @_parse stdout, fn

  scan: (arg = '', fn = null) =>
    if 'function' is typeof arg
      fn = arg
      arg = ''
    @_execAndParse ["--scan#{arg}", "--xml"], fn

  getinfo: (fn) =>
    @_execAndParse ["--getinfo", "--xml"], fn

  disassociate: (fn) =>
    @_exec '--disassociate'

  # channel
  # disassociate
  # psk

  help: (fn) =>
    @_exec '--help', fn

  prefs: (name, value = null, fn = null) =>
    if 'function' is typeof name
      [name, value, fn] = [null, null, name]
    else if 'function' is typeof value
      [name, value, fn] = [name, null, value]
    args = [@options.iface, 'prefs']
    if value
      args.push "#{name}=#{value}"
    else if name
      args.push "#{name}"
    @_exec args, fn

  sniff: (channel = null) =>
    args = [@options.iface, 'sniff']
    args.push channel if channel
    @_system args

  logger: =>
    @_system [@options.iface, 'logger']

module.exports =
  Airport: Airport

