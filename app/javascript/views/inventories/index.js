import $ from 'jquery';
import Rails from 'rails-ujs';


function clearFilters(){

    $( ".reset-filter" ).click(function() {
        console.log('reset button press');
        $('#q_product_name_or_product_product_number_cont').val("")
        $('#q_product_family_id_eq').val("")
        $('#q_product_producer_id_eq').val("")
        $('#q_deposit_type_id_eq').val("")
        $('#q_name_cont').val("")

    });
} 



function search(){
    console.log('into function search');

        $("#q_product_name_or_product_product_number_cont").keyup(function(event){
            console.log('into keyUp');
            console.log(this);
            const valor =  { 
                'product_name_or_product_product_number_cont':  $('#q_product_name_or_product_product_number_cont').val(),
                'product_family_id_eq':  $('#q_product_family_id_eq').val(),
                'product_producer_id_eq': $('#q_product_producer_id_eq').val()
            }

            $.ajax({
                type: "GET", 
                url: "/inventories",
                dataType: 'script',
                data: {"q": valor} ,
                success: function(data, textStatus, jqXHR){
                    
                },
                error: function(jqXHR, textStatus, errorThrown){}
            })
        })

        $("#q_product_family_id_eq, #q_product_producer_id_eq").change(function(event){
            console.log('into change');
            console.log(this); 
            const valor =  { 
                'product_name_or_product_product_number_cont':  $('#q_product_name_or_product_product_number_cont').val(),
                'product_family_id_eq':  $('#q_product_family_id_eq').val(),
                'product_producer_id_eq': $('#q_product_producer_id_eq').val()
        }
            $.ajax({
                type: "GET", 
                url: "/inventories",
                dataType: 'script',
                data: {"q": valor} ,
                success: function(data, textStatus, jqXHR){
                    
                },
                error: function(jqXHR, textStatus, errorThrown){}
            })
        })




        $("#q_deposit_type_id_eq, #q_id_eq").change(function(event){
            console.log('into change');
            console.log(this); 
            const valor =  { 
                'deposit_type_id_eq':  $('#q_deposit_type_id_eq').val(),
                'id_eq':  $('#q_id_eq').val()
              
                  }
            $.ajax({
                type: "GET", 
                url: "/inventories",
                dataType: 'script',
                data: {"p": valor} ,
                success: function(data, textStatus, jqXHR){
                    
                },
                error: function(jqXHR, textStatus, errorThrown){}
            })
        })

        // $("#q_name_cont").keyup(function(event){
        //     console.log('into keyUp');
        //     console.log(this);
        //     const valor =  { 
        //         'name_cont':  $('#q_name_cont').val()
              
        //                    }

        //     $.ajax({
        //         type: "GET", 
        //         url: "/inventories",
        //         dataType: 'script',
        //         data: {"p": valor} ,
        //         success: function(data, textStatus, jqXHR){
                    
        //         },
        //         error: function(jqXHR, textStatus, errorThrown){}
        //     })
        // })
    }


    function inventoryPerDeposit(){
        console.log('intro');
        $("#change-inventory-deposito, #change-inventory-producto").change(function(event){
            if (document.getElementById('change-inventory-producto').checked == true) {
                document.getElementById('inventories-deposit-table-container').style.display = 'none';
                document.getElementById('inventories-table-container').style.display = 'block';
                document.getElementById('filtro-deposito').style.display = 'none';
                document.getElementById('filtro-producto').style.display = 'block';
            } else {
                document.getElementById('inventories-deposit-table-container').style.display = 'block';
                document.getElementById('inventories-table-container').style.display = 'none';
                document.getElementById('filtro-deposito').style.display = 'block';
                document.getElementById('filtro-producto').style.display = 'none';
            }

        })

    }




  document.addEventListener('inventories:index:load', clearFilters); 
  document.addEventListener('inventories:index:load', search); 
  document.addEventListener('inventories:index:load', inventoryPerDeposit); 


