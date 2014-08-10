(function() {
  var Timer, options, timer;

  Timer = (function() {
    function Timer(options) {
      this.options = options;
      this.current = 1;
      this.running = false;
      this.seconds = this.options.duration[this.current];
    }

    Timer.prototype.getDuration = function() {
      return this.seconds;
    };

    Timer.prototype.getInterval = function() {
      return this.current;
    };

    Timer.prototype.setTimer = function() {
      this.current = this.current === 0 ? 1 : 0;
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
          if (that.seconds === 60) {
            that.options.minuteWarning(that.seconds);
          } else if (that.seconds === 10) {
            that.options.minuteWarning(that.seconds);
          }
          console.log(that.seconds);
          that.options.displayTimeOnBadge(that.secondsToString(that.seconds--));
        }
      }, 1000);
      return this.setTimer();
    };

    Timer.prototype.onTimerEnd = function() {
      this.init();
      this.options.endOfInterval(this.current);
      return this.options.destroySessions(this.current);
    };

    Timer.prototype.secondsToString = function() {
      if (this.seconds >= 60) {
        return parseInt(this.seconds / 60) + "m";
      } else {
        return (this.seconds % 60) + "s";
      }
    };

    return Timer;

  })();

  options = function() {
    return {
      duration: [1, 60],
      endOfInterval: function(interval) {
        if (interval === 1) {
          chrome.notifications.create("", {
            type: "basic",
            title: "Stand Up Extension",
            message: "STAND UP !",
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
      notification: function(title, message, iconUrl) {
        return chrome.notifications.create("", {
          type: "basic",
          title: "Stand Up Extension",
          message: message,
          iconUrl: "http://placekitten.com/200/200"
        }, function(id) {
          return console.error(chrome.runtime.lastError);
        });
      },
      minuteWarning: function(interval) {
        if (interval === 1) {
          return this.notification("Stand Up Extension", "60 seconds until Stand Up!");
        }
      },
      tenSecondWarning: function(interval) {
        if (interval === 1) {
          return this.notification("Stand Up Extension", "get ready to stand up in 10 seconds...");
        }
      },
      displayWarningMessage: function(interval) {
        var error;
        if (interval === 1) {
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
        if (interval === 1) {
          return 'scripts/createLanding.js';
        } else {
          return 'scripts/destroyLanding.js';
        }
      }
    };
  };

  timer = new Timer(options());

  chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
    if (timer.getInterval()) {
      return chrome.tabs.executeScript(tab.id, {
        file: 'scripts/createLanding.js'
      });
    }
  });

  timer.init();

}).call(this);
