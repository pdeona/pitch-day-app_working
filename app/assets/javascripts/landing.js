// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// $(document).on('turbolinks:load', () => {

//   let authenticationSuccess = function() {
//     console.log('Successful authentication');
//   },
//   authenticationFailure = function() {
//     console.log('Failed authentication');
//   };

//   $('#trello-btn').on('click', (evt) => {
//     evt.preventDefault();
//     window.Trello.authorize({
//       type: 'modal',
//       name: 'Getting Started Application',
//       scope: {
//         read: 'true',
//         write: 'true' },
//       expiration: 'never',
//       success: authenticationSuccess,
//       error: authenticationFailure
//     });
//   });
// });

$(document).on('turbolinks:load', () => {
  $('#projects-btn').on('click', (evt) => {
    evt.preventDefault();
    $('.btn-secondary').toggle();
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
      '<span class="trello_id">' + item.trello_id + '</span>'
    ];
    return $('<li style="decoration:none">')
      .append(markup.join(''))
      .appendTo(ul);
  }
};
