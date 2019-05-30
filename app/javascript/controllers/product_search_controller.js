import Rails from 'rails-ujs';
import $ from 'jquery';
import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['input', 'button'];

  // Evento cuando se hace click en Buscar producto
  show() {
    const url = this.data.get('url');
    Rails.ajax({
      type: 'GET',
      dataType: 'script',
      url,
      success: () => {
        $('#product-search-modal').modal('show');
      },
    });
  }

  // Evento cuando cambia el input de búsqueda
  change() {
    this.buttonTarget.disabled = this.inputTarget.value.length < 3
  }

  // Evento cuando se selecciona un producto de la tabla
  select() {
    const id = this.data.get('id');
    const label = this.data.get('label');

    const idInput = document.getElementById('product-search-id-target').value;
    const labelInput = document.getElementById('product-search-label-target').value;

    document.getElementById(idInput).value = id;
    document.getElementById(labelInput).value = label;
    $('#product-search-modal').modal('hide');
  }
}
