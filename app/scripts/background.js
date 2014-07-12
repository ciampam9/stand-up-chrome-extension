(function() {
  var Timer, timer;

  Timer = (function() {
    function Timer(options) {
      this.options = options;
      this.current = 'break';
      this.next = 'work';
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
      this.options.destroySessions(this.current);
      return console.log("test");
    };

    return Timer;

  })();

  timer = new Timer({
    duration: {
      work: 2,
      "break": 2
    },
    endOfInterval: function() {
      chrome.notifications.create("", {
        type: "basic",
        title: "Greetings!!",
        message: "Stand the up you lazy bum!",
        iconUrl: "http://placekitten.com/200/200"
      }, function(id) {
        return console.error(chrome.runtime.lastError);
      });
    },
    destroySessions: function(interval) {
      var that;
      that = this;
      chrome.windows.getAll({
        populate: true
      }, function(windows) {
        windows.forEach(function(window) {
          window.tabs.forEach(function(tab) {
            if (tab.url.indexOf("chrome://") === -1 && tab.url.indexOf("chrome-devtools://") === -1) {
              return chrome.tabs.executeScript(tab.id, {
                file: that.executeScript(interval)
              });
            }
          });
        });
      });
    },
    executeScript: function(interval) {
      if (interval === 'break') {
        return 'scripts/destroySession.js';
      } else {
        return 'scripts/enableSession.js';
      }
    }
  });

  timer.init();

}).call(this);
