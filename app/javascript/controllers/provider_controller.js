import Rails from 'rails-ujs';
import $ from 'jquery';
import { Controller } from 'stimulus'
 
export default class extends Controller {

	static targets = [ "fields", "form", "link", "contact_name", "withholdingstatus", "retenciones" ]
	

	addContact(event) {

		console.log(event.target);
		var time = new Date().getTime()
		var regexp = new RegExp($(event.target).data('id'), 'g')
		console.log(regexp);
		$(event.target).before($(event.target).data('fields').replace(regexp, time))

		event.preventDefault()
	  }

	deleteContact(event){
		
		$(event.target).prev('input[type=hidden]').val('1')
		$(event.target).closest('fieldset').hide()
		event.preventDefault()
	}

	retencion(e){
		console.log('into');
		console.log(e);
		console.log(e.target.checked);

		if(e.target.checked == true){
			this.retencionesTarget.setAttribute("style", "display: block;");
		}else{
			this.retencionesTarget.setAttribute("style", "display: none;");
		}
	}


}   