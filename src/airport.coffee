{spawn, exec} =  require 'child_process'
{EventEmitter} = require 'events'
plist =          require 'plist'

class Airport extends EventEmitter
  constructor: (@options = {}) ->
    @options.airport_bin ?= '/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'

  _exec: (args, fn) =>
    args = [args] if 'string' is typeof args
    command = "#{@options.airport_bin} #{args.join ' '}"
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

module.exports =
  Airport: Airport

