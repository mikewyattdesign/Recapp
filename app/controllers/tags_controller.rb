class TagsController < ApplicationController
	def index
		@tags = ActsAsTaggableOn::Tag.all
		if params[:q]
			@tags = @tags.where("name like ?", "%#{params[:q]}%")
		end
		respond_to do |format|
			format.html
			format.json { render json: @tags}
		end
	end
end
