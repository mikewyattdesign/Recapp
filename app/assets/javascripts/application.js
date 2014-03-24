// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks

// Load moment for bootstrap datetimepicker
//= require moment/moment


// Load all Bootstrap javascripts
//= require bootstrap
//= require bootstrap3-datetimepicker/build/js/bootstrap-datetimepicker.min

// Load jquery token input for tags
//= require jquery-tokeninput/src/jquery.tokeninput

//= require_tree .

// var RECAPP, REPLACE;

// REPLACE = (function() {
//     var init;
//     init = function() {
//         if($(window).width() <= 480){
//             $( ".event-header a button" ).replaceWith( '<button type="button" class="pull-right new-event-btn btn btn-primary">+</button>' );
//         }
//     };
//         return {
//         init: init
//     };
// })();

// RECAPP = {
//     init: function () {
//         REPLACE.init();
//     }
// };

// $(document).on('ready', RECAPP.init);