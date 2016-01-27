// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//= require_self


$(function() {
  $('#my-menu').mmenu({
    extensions  : [ 'effect-slide-menu', "border-full", "pageshadow" ],
    counters  : true,
    navbar    : {
      title : null,
      content : ['next', 'previous', 'title']
    }
  });
});


$(document).ready(function() {

  // flash notice ----------------------------------------
  $("div.clickhide").click(function(){
    $(this).hide();
  });

  // ---------------------------- schedule submit buttons ---------------------

  $('#confirm').on('click', function() { $('#scheduleForm').submit(); });
  $('#resend').on('click', function() { $('#scheduleForm').submit(); });


// -------------------------------- datepicker ------------------------------

  if ($("form").hasClass("skehdule-form")) {
    var $inputDate = $('#input_date').pickadate(),
        picker1 = $inputDate.pickadate('picker'),
        $inputText = $('#input_text').on({
          change: function() {
            var parsedDate = Date.parse( this.value )
            if ( parsedDate ) {
              picker1.set( 'select', [parsedDate.getFullYear(), parsedDate.getMonth(), parsedDate.getDate()] )
            }
            else {
              alert( 'Invalid date' )
            }
          },
          focus: function() {
            picker1.open(false)
          },
          blur: function() {
            picker1.close()
          }
        })

    picker1.on('set', function() {
      $inputText.val(this.get('value'))
    })  
  }

// ---------------------------- footer ----------------------------------

  var docHeight = $(window).height();
  var footerHeight = $('#footer').height();
  var footerTop = $('#footer').position().top + footerHeight;
  if (footerTop < docHeight) {
  $('#footer').css('margin-top', 10+ (docHeight - footerTop) + 'px');
  }

// ------------------- book form buttons -------------------------------

  var inputs;

  inputs = document.querySelectorAll('.form-file');

  Array.prototype.forEach.call(inputs, function(input) {
    var label, labelVal;
    label = input.nextElementSibling;
    labelVal = label.innerHTML;
    return input.addEventListener('change', function(e) {
      var fileName;
      fileName = e.target.value.split('\\').pop();
      if (fileName) {
        return label.querySelector('span').innerHTML = fileName;
      } else {
        return label.innerHTML = labelVal;
      }
    });
  });

  input.addEventListener('focus', function() {
    return input.classList.add('has-focus');
  });

  input.addEventListener('blur', function() {
    return input.classList.remove('has-focus');
  });


});









