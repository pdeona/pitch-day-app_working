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

$(document).on('page:change', () => {
  $('.container')[0].addClass('animate slideInRight');
});


$(document).on('page:fetch', () => {
  $('.container')[0].addClass('animate slideOutLeft');
});
