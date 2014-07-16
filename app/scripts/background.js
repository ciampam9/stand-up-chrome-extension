(function() {
  var Timer, options, timer;

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
          that.options.displayTimeOnBadge(that.secondsToString(that.seconds--));
        }
      }, 1000);
      return this.start();
    };

    Timer.prototype.onTimerEnd = function() {
      this.init();
      this.options.endOfInterval(this.current);
      return this.options.destroySessions(this.current);
    };

    Timer.prototype.secondsToString = function() {
      if (this.seconds >= 60) {
        return Math.round(this.seconds / 60) + "m";
      } else {
        return (this.seconds % 60) + "s";
      }
    };

    return Timer;

  })();

  options = function() {
    return {
      duration: {
        work: 1,
        "break": 600
      },
      endOfInterval: function(interval) {
        if (interval === 'break') {
          chrome.notifications.create("", {
            type: "basic",
            title: "Greetings!!",
            message: "Stand up you lazy bum!",
            iconUrl: "http://placekitten.com/200/200"
          }, function(id) {
            return console.error(chrome.runtime.lastError);
          });
          chrome.browserAction.setBadgeBackgroundColor({
            color: [255, 0, 0, 255]
          });
          chrome.browserAction.setBadgeText({
            text: 'stand up'
          });
          return;
        } else {
          chrome.browserAction.setBadgeBackgroundColor({
            color: [0, 0, 0, 0]
          });
        }
      },
      displayTimeOnBadge: function(time) {
        return chrome.browserAction.setBadgeText({
          text: time
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
                chrome.tabs.executeScript(tab.id, {
                  file: that.executeScript(interval)
                });
              }
            });
          });
        });
      },
      displayWarningMessage: function(interval) {
        var error;
        if (interval === 'break') {
          return chrome.notifications.create('', {
            type: "basic",
            title: "Warning",
            message: "Your browser activities will be blocked within the next minute.  Please be prepared.",
            iconUrl: "http://placekitten.com/300/300"
          }, (function() {
            try {
              return function(id) {
                return console.error(chrome.runtime.lastError);
              };
            } catch (_error) {
              error = _error;
              return console.error(error);
            }
          })());
        }
      },
      executeScript: function(interval) {
        if (interval === 'break') {
          return 'scripts/destroySession.js';
        } else {
          return 'scripts/enableSession.js';
        }
      }
    };
  };

  timer = new Timer(options());

  timer.init();

}).call(this);
