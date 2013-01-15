#!/usr/bin/env coffee

{Airport} = require '..'

airport = new Airport 'en0'

airport.scan (err, results) ->
  console.log 'scan is performed'
  console.log err, results
