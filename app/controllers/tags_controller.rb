class TagsController < ApplicationController
	def index
		@tags = ActsAsTaggableOn::Tag.all
		if params[:q]
			@tags = @tags.where("lower(name) like ?", "%#{params[:q].downcase}%")
		end
		respond_to do |format|
			format.html
			format.json { render json: @tags}
		end
	end
end
