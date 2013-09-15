class CommentsController < ApplicationController
  before_filter :authenticate_user!, :load_commentable
  before_filter :load_comment, :only => [:show, :edit, :update, :destroy]
  respond_to :js, :json, :html, :xml
  # GET /comments
  # GET /comments.json
  def index
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = @commentable.comments.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
    else
      flash[:error] = @comment.errors
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment.user = current_user

    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
    else
      flash[:error] = @comment.errors
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    flash[:notice] = "Comment deleted"
  end

  private

  def load_comment
  	@comment = @commentable.comments.find(params[:id])
  end

  def load_commentable
  	@commentable = find_commentable	
  	logger.info "Found commentable"
  end

	def find_commentable
	  params.each do |name, value|
	    if name =~ /(.+)_id$/
	      return $1.classify.constantize.find(value)
	    end
	  end
	  nil
	end

end