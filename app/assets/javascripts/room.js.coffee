# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  PrivatePub.subscribe "/users/list", (data, channel) ->
    $("#userlist ul").html("")
    console.log(data)
    for user in data.list
      
      $("<a/>", {
                href: '/conversations/' + user._id.$oid,
                text: user.name,
                'data-remote': true,
              }).wrap('<li></li>')
                .parent()
                .appendTo("#userlist ul")