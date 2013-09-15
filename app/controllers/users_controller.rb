class UsersController < ApplicationController
  before_filter :authenticate_user!
  def search_new
    render :action => 'search'
  end

  def search
    @user = User.find_by_email(params[:email])
    if @user
      redirect_to @user
    else
      render :action => 'search', :notice => 'User not found with email' 
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

end