import $ from 'jquery';
import Rails from 'rails-ujs';


function clearFilters(){

    $( ".reset-filter" ).click(function() {
        console.log('reset button press');
        $('#q_identification_number_cont').val("")
        $('#q_tax_category_number_cont').val("")
        $('#q_name_cont').val("")

    });
}

function search(){
    console.log('into function search');

        $("#q_name_cont, #q_tax_category_number_cont, #q_identification_number_cont").keyup(function(event){
            console.log('into keyUp');
            console.log(this);
            const valor =  { 
                'name_cont':  $('#q_name_cont').val(),
                'tax_category_number_cont': $('#q_tax_category_number_cont').val(),
                'identification_number_cont': $('#q_identification_number_cont').val()
        }

            $.ajax({
                type: "GET", 
                url: "/elements/providers",
                dataType: 'script',
                data: {"q": valor} ,
                success: function(data, textStatus, jqXHR){
                    
                },
                error: function(jqXHR, textStatus, errorThrown){}
            })
        })


    }


 
  document.addEventListener('providers:index:load', clearFilters); 
  document.addEventListener('providers:index:load', search); 