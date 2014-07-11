(function() {
  'use strict';
  var Timer, timer;

  Timer = (function() {
    var that;

    Timer.seconds = Timer.seconds;

    that = Timer;

    function Timer(interval) {
      this.seconds = interval;
    }

    Timer.start = function() {
      return setInterval(function() {
        if (that.seconds === 0) {
          return clearInterval(that.intervalID);
        } else {
          console.log(that.seconds);
          return that.seconds--;
        }
      }, 1000);
    };

    Timer.tick = function() {};

    return Timer;

  })();

  timer = new Timer(200);

  timer.start();

}).call(this);
