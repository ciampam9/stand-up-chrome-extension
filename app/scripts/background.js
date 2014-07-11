(function() {
  var Nuke, Timer, timer;

  Timer = (function() {
    function Timer(options) {
      this.options = options;
      this.current = 'work';
      this.next = 'break';
      this.seconds = this.options.duration[this.current];
      this.running = false;
    }

    Timer.prototype.getDuration = function() {
      return this.seconds;
    };

    Timer.prototype.start = function() {
      var previous;
      previous = this.current;
      this.current = this.next;
      this.next = previous;
      this.seconds = this.options.duration[this.current];
    };

    Timer.prototype.init = function() {
      var that, timerInterval;
      that = this;
      timerInterval = setInterval(function() {
        if (that.seconds === 0) {
          clearInterval(timerInterval);
          that.onTimerEnd();
        } else {
          console.log(that.seconds);
          that.seconds--;
        }
      }, 1000);
      return this.start();
    };

    Timer.prototype.onTimerEnd = function() {
      this.init();
      this.options.endOfInterval();
      this.options.onCreate(this.current);
      return console.log("test");
    };

    return Timer;

  })();

  timer = new Timer({
    duration: {
      work: 5,
      "break": 2
    },
    endOfInterval: function() {
      return chrome.notifications.create("", {
        type: "basic",
        title: "Greetings!!",
        message: "Stand the fuck up you lazy bum!",
        iconUrl: "http://placekitten.com/200/200"
      }, function(id) {
        return console.error(chrome.runtime.lastError);
      });
    },
    onCreate: function(interval) {
      var bomb;
      bomb = new Nuke();
      bomb.detonate();
    }
  });

  Nuke = (function() {
    function Nuke() {}

    Nuke.prototype.detonate = function() {
      var windows;
      return windows = chrome.windows.getAll({
        populate: true
      }, function(windows) {
        var tab, tabs, win, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = windows.length; _i < _len; _i++) {
          win = windows[_i];
          tabs = windows[win].tabs;
          _results.push((function() {
            var _j, _len1, _results1;
            _results1 = [];
            for (_j = 0, _len1 = tabs.length; _j < _len1; _j++) {
              tab = tabs[_j];
              _results1.push(this.bomb(action, tabs[tab]));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      });
    };

    Nuke.prototype.bomb = function(action, tab) {
      if (typeof document === 'undefined') {
        return window.addEventListener('DOMContentLoaded', this.createOverlay);
      } else {
        return this.createOverlay;
      }
    };

    Nuke.prototype.createOverlay = function() {
      var x;
      x = document.createElement("div");
      document.x.style.position = "absolute";
      document.x.style.top = 0;
      document.x.style.left = 0;
      document.x.style.right = 0;
      document.x.style.bottom = 0;
      document.x.style.zIndex = 0;
      document.x.style.backgroundColor = "white";
      return document.body.appendChild(x);
    };

    return Nuke;

  })();

  timer.init();

}).call(this);
