$(document).ready(function() {

  border_on_mouse_over()
  btn_success_on_mouse_over();

})


function border_on_mouse_over() {
  $('div.card').hover(
    function() {

      $(this).addClass('border-mouse-over');
    },
    function() {
      $(this).removeClass('border-mouse-over');
    }
  );
}

function btn_success_on_mouse_over() {
  $('a.btn-hover-green').hover(
    function() {
      $(this).addClass('btn-success');
    },
    function () {
      $(this).removeClass('btn-success');
    }
  )
}
