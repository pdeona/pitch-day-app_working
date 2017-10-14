// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .


var app = window.app = {};

app.Users = function() {
  this._input = $('#users-search-txt');
  this._initAutocomplete();
};

app.Users.prototype = {
  _initAutocomplete: function() {
  this._input
    .autocomplete({
      source: '/user/search',
      appendTo: '#users-search-results',
      select: $.proxy(this._select, this)
    })
    .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.trello_id);
    return false;
  },

  _render: function(ul, item) {
    var markup = [
      '<span class="trello_id">' + item.trello_id + '</span>'
    ];
    return $('<li style="decoration:none">')
      .append(markup.join(''))
      .appendTo(ul);
  }
};
