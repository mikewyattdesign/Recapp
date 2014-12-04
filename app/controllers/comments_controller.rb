class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  before_filter :load_commentable, only: [:index, :show, :new, :create, :update]

  # GET /comments
  # GET /comments.json
  def index
    if @commentable
      @comments = @commentable.comments
    else
      @comments = Comment.all
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @commentable = @comment.commentable_type.singularize.classify.constantize.find(@comment.commentable_id)
  end

  # GET /comments/new
  def new
    @comment = Comment.new(commentable_id: @commentable.id)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to [@commentable, :comments], notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to [@commentable, :comments], notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @commentable = @comment.commentable_type.singularize.classify.constantize.find(@comment.commentable_id)
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to [@commentable, :comments] }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type, :is_testimonial)
    end

    # Determines which class the comment is associated with
    def load_commentable
        klass = [Event, Photo].detect { |c| params["#{c.name.underscore}_id"] }
        @commentable = klass.find_by_id(params["#{klass.name.underscore}_id"]) if klass
    end
end
