module AddressHelper
	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
	end

	def link_to_add_fields(name, f, association,**args)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |document|
			render(association.to_s.singularize + "_fields", f: document)
		end
	link_to(name, '', class: "add_fields btn btn-success", data: { id: id, fields: fields.gsub("\n", "")})
end
end  