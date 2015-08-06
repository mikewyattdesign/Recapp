module ApplicationHelper
	def link_to_add_fields(name, f, association)
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	    	render(association.to_s.singularize + '_fields', f: builder)
	    end
	    link_to(name, '#', class: 'add_fields btn btn-default clearfix', data: {id: id, fields: fields.gsub("\n", "")})
    end

    def number_to_abbreviated(number)
      if number == 0
        "N/A"
      else
    	   number_to_human(number, units: {thousand: "k", million: "MM", billion: "B"})
      end
    end

    def self.asset_data_base64(path)
      asset = Rails.application.assets.find_asset(path)
      throw "Could not find asset '#{path}'" if asset.nil?
      base64 = Base64.encode64(asset.to_s).gsub(/\s+/, "")
      "data:font/truetype;charset=utf-8;base64,#{Rack::Utils.escape(base64)}"
    end

end
