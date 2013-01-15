#!/usr/bin/env coffee

{Airport} = require '..'

airport = new Airport 'en0'

airport.getinfo (err, info) ->
  console.log err, info

