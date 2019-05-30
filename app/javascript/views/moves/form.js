import $ from 'jquery';

function statusChange() {
  $('#move_status').change(function(event){
    if ($(this).val() == 'eliminado' || $(this).val() == 'recibido') {
      document.getElementById('statusHelp').style.display = 'block';
    } else {
      document.getElementById('statusHelp').style.display = 'none';
    }
  })
}

document.addEventListener('moves:edit:load', statusChange);
