// Generated by CoffeeScript 1.4.0
(function() {
  var Airport, airport;

  Airport = require('..').Airport;

  airport = new Airport('en0');

  airport.scan(function(err, results) {
    console.log('scan is performed');
    return console.log(err, results);
  });

}).call(this);
