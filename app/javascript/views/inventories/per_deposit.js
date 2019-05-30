import $ from 'jquery';
import Rails from 'rails-ujs';


function clearFilters(){

    $( ".reset-filter" ).click(function() {
        console.log('reset button press');
        $('#q_product_product_number_cont').val("")
        $('#q_product_name_cont').val("")

    });
} 

function search(){
    console.log('into function search');

        $("#q_product_product_number_cont, #q_product_name_cont").keyup(function(event){
            console.log('into keyUp');

            const valor =  { 
                'product_product_number_cont':  $('#q_product_product_number_cont').val(),
                'product_name_cont':  $('#q_product_name_cont').val()
        
          }
        //   if (($('#q_product_product_number_cont').val().length >1) || ($('#q_product_name_cont').val().length >1)){
            console.log('into condition');
            setTimeout(function(){

                $.ajax({
                    type: "GET", 
                    url: "/inventories/per_deposit/",
                    dataType: 'script',
                    data: {"q": valor} ,
                    success: function(data, textStatus, jqXHR){
                        
                    },
                    error: function(jqXHR, textStatus, errorThrown){}
                })
            },1000);
        // }

        })

    }


  document.addEventListener('inventories:per_deposit:load', search); 
  document.addEventListener('inventories:per_deposit:load', clearFilters); 



