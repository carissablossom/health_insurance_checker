# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $loading = $('#loadingDiv').hide();
  console.log('ready!');
  $(".insurance_form").submit (event)->
    $loading.show();
    event.preventDefault()
    $.ajax 'user/results',
      type: 'POST',
      dataType: 'JSON',
      data: {
            first_name: $('input#first_name').val(),
            last_name: $('input#last_name').val(),
            birthday: $('input#birthday_born_on').val(),
            insurance_provider: $('input#insurance_provider').val(),
            member_id: $('input#insurance_member_id').val()
          }
      error: (jqXHR, textStatus, errorThrown) ->
        $loading.hide();
        $('#verification-result').html jqXHR.responseText
        console.log(jqXHR.responseText);
      success: (data, textStatus, jqXHR) ->
        $loading.hide();
        $('#verification-result').html data.responseText
