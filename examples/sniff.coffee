#!/usr/bin/env coffee

{Airport} = require '..'
airport = new Airport 'en0'

# sniff on all channels
do airport.sniff

# sniff on channel 3
#airport.sniff 3

