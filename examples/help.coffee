#!/usr/bin/env coffee

{Airport} = require '..'

airport = new Airport

airport.help (err, help) ->
  console.log help
