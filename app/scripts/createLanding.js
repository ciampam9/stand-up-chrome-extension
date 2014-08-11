(function() {
  'use strict';
  var destroy, radialTimer;

  radialTimer = (function() {
    function radialTimer(shadow) {
      var self, timerHTML;
      self = this;
      this.seconds = 0;
      this.count = 0;
      this.degrees = 0;
      this.interval = null;
      this.timerHTML = timerHTML = "";
      this.timerContainer = null;
      this.number = null;
      this.slice = null;
      this.pie = null;
      this.pieRight = null;
      this.pieLeft = null;
      this.quarter = null;
      this.init = function(s) {
        self.timerContainer = shadow.querySelector("#spinner");
        self.number = shadow.querySelector(".n");
        self.slice = shadow.querySelector(".slice");
        self.pie = shadow.querySelector(".pie");
        self.pieRight = shadow.querySelector(".pie.r");
        self.pieLeft = shadow.querySelector(".pie.l");
        self.quarter = shadow.querySelector(".q");
        return self.start(s, shadow);
      };
      this.start = function(s, shadow) {
        self.seconds = s;
        return self.interval = window.setInterval(function() {
          var className;
          self.number.innerHTML = self.seconds - self.count;
          self.count++;
          if (self.count > (self.seconds - 1)) {
            clearInterval(self.interval);
          }
          self.degrees = self.degrees + (360 / self.seconds);
          console.log(self.degrees);
          if (self.count >= (self.seconds / 2)) {
            className = "nc";
            console.log(self.slice.classList);
            if (self.slice.classList) {
              self.slice.classList.add(className);
            } else {
              self.slice.className += ' ' + className;
            }
            if (!self.slice.classList.contains("mth")) {
              self.pieRight.style.transform = "rotate(180deg)";
            }
            self.pieLeft.style.transform = "rotate(" + self.degrees + "deg)";
            self.slice.classList.add("mth");
            if (self.count >= (self.seconds * 0.75)) {
              return self.quarter.parentNode.removeChild(self.quarter);
            }
          } else {
            return self.pie.style.transform = "rotate(" + self.degrees + "deg)";
          }
        }, 1000);
      };
    }

    return radialTimer;

  })();

  destroy = {
    content: "<div class='container'>					<div class='img-container'>						<div class='radialtimer'>							<div id='spinner'>								<div class='n'></div>								<div class='slice'>									<div class='q'></div>									<div class='pie r'></div>									<div class='pie l'></div>								</div>							</div>						</div>					</div>					<h1>Stand Up!</h1>				</div>",
    setShadowDom: function() {
      var container, node, shadow, that;
      that = this;
      if (!document.getElementById('standup-overlay')) {
        node = document.createElement('div');
        node.id = 'standup-overlay';
        document.body.appendChild(node);
        return this.setShadowDom();
      } else {
        container = document.querySelector('#standup-overlay');
        shadow = container.createShadowRoot();
        shadow.innerHTML = that.content;
        return shadow;
      }
    },
    init: function() {
      var shadow, timer;
      shadow = this.setShadowDom();
      timer = new radialTimer(shadow);
      return timer.init(30);
    }
  };

  if (typeof documet === 'undefined') {
    window.addEventListener('DOMContentLoaded', destroy.init());
  } else {
    destroy.init();
  }

}).call(this);
