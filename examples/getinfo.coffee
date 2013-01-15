#!/usr/bin/env coffee

{Airport} = require '..'

airport = new Airport

airport.getinfo (err, info) ->
  console.log err, info

