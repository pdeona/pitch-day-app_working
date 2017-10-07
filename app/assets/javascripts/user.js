$(document).on('turbolinks:load', function() {

  console.log('beer?');
  window.Trello.authorize();
  let response = window.Trello.get('members/me', (response) => {console.log(response)});

});
