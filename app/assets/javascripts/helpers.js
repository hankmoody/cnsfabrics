window.setTimeout(function() {
  var flash = 'div.alert';
  var alertIsSerious = $(flash).hasClass('alert-danger') || $(flash).hasClass('alert-warning')
  if (!alertIsSerious) {
    $(flash).fadeTo(500, 0).slideUp(500, function(){
      $(this).remove();
    });
  }
}, 2000);
