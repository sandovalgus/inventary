import Rails from 'rails-ujs';
import $ from 'jquery';
import { Controller } from 'stimulus';

export default class extends Controller {
  initialize() {
    document.getElementById('inventories-deposit-table-container').style.display = 'block';
    document.getElementById('inventories-table-container').style.display = 'none';
    document.getElementById('filtro-deposito').style.display = 'block';
    document.getElementById('filtro-producto').style.display = 'none';
  }
}