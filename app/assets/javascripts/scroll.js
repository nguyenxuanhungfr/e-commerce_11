$(document).ready(function(){
  $("#submit_scroll").click(function(){
    $(".user_comment").animate({
     scrollTop: $('.user_comment')[ 0].scrollHeight
   }, 'slow');
  });
});
$(window).on('turbolinks:load', function() {
    $(".user_comment").animate({
     scrollTop: $('.user_comment')[ 0].scrollHeight
   }, 'slow');
});
