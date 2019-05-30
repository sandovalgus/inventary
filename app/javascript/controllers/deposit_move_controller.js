import Rails from 'rails-ujs';
import $ from 'jquery';
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input'];

  add() {
    var productsArray = [];
    $(".catchProducts:checked").each(function() {
      productsArray.push($(this).val());
    });

    const [moveId, siteToId] = this.getValueRadioBtn().split("&");
    const url = '/elements/deposits/move_detail';

    Rails.ajax({
      type: 'POST',
      dataType: 'json',
      data: `q=${productsArray}&move_id=${moveId}&site_to_id=${siteToId}`,
      url,
      success: () => {
        $('#select-deposit-move-modal').modal('hide');
        $('#inventories-table-container').location.reload();
      },
    }) 
  }

  select() {
    const url = '/elements/deposits/select';

    Rails.ajax({
      type: 'GET',
      dataType: 'json',
      url,
      success: () => {
        $('#select-deposit-move-modal').modal('show');
      },
    })
  }

  move() {
    var productsArray = [];
    $(".catchProducts:checked").each(function() {
      productsArray.push($(this).val());
    });

    console.log(productsArray.length)

    const url = '/elements/deposits/move';

    Rails.ajax({
      type: 'GET',
      dataType: 'json',
      data: "q=" + productsArray,
      url,
      success: () => {
        $('#select-deposit-move-modal').modal('hide');
        $('#deposit-move-modal').modal('show');
        $('#inventories-table-container').location.reload();
      },
    }); 
  }

  enableBtn() {
    document.getElementById("btnCargarDetalle").disabled = false;
  }

  getValueRadioBtn() {
    var radios = document.getElementsByName('selectMove');
    for (var i = 0, length = radios.length; i < length; i++) {
      if (radios[i].checked) {
        return radios[i].value;
      }
    }
  }

}