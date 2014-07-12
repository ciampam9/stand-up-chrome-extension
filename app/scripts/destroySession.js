(function() {
  'use strict';
  var destroy;

  destroy = {
    init: function() {
      var node;
      if (!document.getElementById('standup-overlay')) {
        node = document.createElement('div');
        node.id = "standup-overlay";
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
