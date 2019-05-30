import $ from 'jquery';
import Rails from 'rails-ujs';
import { MaskElementByClass, MakeDateRangePicker } from '../util';

function maskSearchFormElements() {
  MakeDateRangePicker('.input-group.input-daterange');
  MaskElementByClass('mask-date', 'date');
  MaskElementByClass('mask-numeric', 'integer');
}

function clearFilters(){

  $( ".reset-filter" ).click(function() {
      console.log('reset button press');
      $('#q_move_date_gteq').val("")
      $('#q_move_date_lteq').val("")
      $('#q_voucher_type_id_eq').val("")
      $('#q_user_register_id_eq').val("")
      $('#q_user_take_id_eq').val("")
      $('#q_move_details_site_to_id_eq').val("")
      $('#q_voucher_number_cont').val("")

  });
}

function search(){
  console.log('into function search');

      $("#q_voucher_number_cont").keyup(function(event){
          console.log('into keyUp');
          console.log(this);

          $.ajax({
              type: "GET", 
              url: "/moves",
              dataType: 'script',
              data: $(this).serialize(),
              success: function(data, textStatus, jqXHR){
                  
              },
              error: function(jqXHR, textStatus, errorThrown){}
          })
      })

      $("#q_move_date_gteq, #q_move_date_lteq, #q_voucher_type_id_eq, #q_user_register_id_eq, #q_user_take_id_eq, #q_move_details_site_to_id_eq").change(function(event){
          console.log('into change');
          console.log(this); 
          const valor =  { 
              'move_date_gteq':  $('#q_move_date_gteq').val(),
              'move_date_lteq': $('#q_move_date_lteq').val(),
              'voucher_type_id_eq': $('#q_voucher_type_id_eq').val(),
              'user_register_id_eq': $('#q_user_register_id_eq').val(),
              'user_take_id_eq': $('#q_user_take_id_eq').val(),
              'move_details_site_to_id_eq': $('#q_move_details_site_to_id_eq').val()
      }
          $.ajax({
              type: "GET", 
              url: "/moves",
              dataType: 'script',
              data: {"q": valor} ,
              success: function(data, textStatus, jqXHR){
                  
              },
              error: function(jqXHR, textStatus, errorThrown){}
          })
      })
  }

document.addEventListener('moves:index:load', maskSearchFormElements);
document.addEventListener('moves:index:load', clearFilters);
document.addEventListener('moves:index:load', search);

 