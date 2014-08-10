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
    content: "<div class='container'>					<h1>Stand up!</h1>					<h3>your chair is killing you!</h3>					<div class='img-container'>						<div class='radialtimer'>							<div id='spinner'>								<div class='n'></div>								<div class='slice'>									<div class='q'></div>									<div class='pie r'></div>									<div class='pie l'></div>								</div>							</div>						</div>					</div>					<p class='quote'>Do you sit in an office chair for more than six hours a day ? <br>						<strong>Risk of heart disease is increased by up to 64%</strong>					</p>					<div class='email-form'>						<div id='mc_embed_signup'>							<form action='//geneguru.us8.list-manage.com/subscribe/post?u=c83b70b914e7d75d6b2187323&amp;id=2b8f19f75d' method='post' id='mc-embedded-subscribe-form' name='mc-embedded-subscribe-form' class='validate' target='_blank' novalidate>								<h3>Get more free apps and resources to lead a happier and healthier life</h3>								<div class='mc-field-group'>									<input type='email' value='' name='EMAIL' class='required email' id='mce-EMAIL' placeholder='email address'>								</div>								<div id='mce-responses' class='clear'>									<div class='response' id='mce-error-response' style='display:none'></div>									<div class='response' id='mce-success-response' style='display:none'></div>								</div>								<div style='position: absolute; left: -5000px;'><input type='text' name='b_c83b70b914e7d75d6b2187323_2b8f19f75d' tabindex='-1' value=''></div>								<div class='clear'><input type='submit' value='Let&#039;s do this!' name='subscribe' id='mc-embedded-subscribe' class='button'></div>							</form>						</div>					</div>				</div>",
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
      return timer.init(60);
    }
  };

  if (typeof documet === 'undefined') {
    window.addEventListener('DOMContentLoaded', destroy.init());
  } else {
    destroy.init();
  }

}).call(this);
