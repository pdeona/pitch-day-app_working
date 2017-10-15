// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// $(document).on('turbolinks:load', () => {

$(document).on('turbolinks:load', () => {
  $('#projects-btn').on('click', (evt) => {
    evt.preventDefault();
    $('.btn-secondary').toggle('slideDown');
  });
});

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
      '<span class="img">',
        '<img src="' + item.image + '" />',
      '</span>',
      '<span class="trello_id">' + item.trello_id + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  }
};
