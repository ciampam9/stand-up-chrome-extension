(function() {
  'use strict';
  var destroy;

  destroy = {
    init: function() {
      var node;
      if (!document.getElementById('standup-overlay')) {
        node = document.createElement('div');
        node.id = "standup-overlay";
        node.style.position = "fixed";
        node.style.zIndex = 99999;
        node.style.top = 0;
        node.style.left = 0;
        node.style.right = 0;
        node.style.bottom = 0;
        node.style.background = "white";
        return document.body.appendChild(node);
      }
    }
  };

  if (typeof documet === 'undefined') {
    window.addEventListener('DOMContentLoaded', destroy.init());
  } else {
    destroy.init();
  }

}).call(this);
