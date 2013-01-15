#!/usr/bin/env coffee

{Airport} = require '..'

airport = new Airport

# Getting DisconnectOnLogout value
airport.prefs 'DisconnectOnLogout', (err, value) ->
  console.log err, value

# Setting DisconnectOnLogout to NO
airport.prefs 'DisconnectOnLogout', 'NO', (err, value) ->
  console.log err, value
