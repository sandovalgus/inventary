import $ from 'jquery';
import Rails from 'rails-ujs';


function validateProduct(){
  
  $('#valid-product-number').hide()
  $('#invalid-product-number').hide()


    $("#product_product_number").keyup(function(event){
        console.log('keyup');
        if ($('#product_product_number').val().length >1){
     

            $.ajax({
                type: "GET", 
                url: "/products/products/product_number_validator/" + $('#product_product_number').val(),
                data: 'json',
                success: function(data, textStatus, jqXHR){
                    if(data.valid == true){
                        $('#invalid-product-number').hide()
                        $('#valid-product-number').show()
                        
                    }else if (data.valid == false){
                        
                        $('#invalid-product-number').show()
                        $('#invalid-product-number').html('El producto con número '+ $('#product_product_number').val() + ' ya existe.')
                        $('#valid-product-number').hide()
                    }
                },
                error: function(jqXHR, textStatus, errorThrown){}
            })
        }else{
            $('#invalid-product-number').hide()
        }

    } )
}

document.addEventListener('products:new:load', validateProduct); 
document.addEventListener('products:edit:load', validateProduct); 