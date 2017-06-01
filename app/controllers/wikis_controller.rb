class WikisController < ApplicationController

  before_action :authorize_user, only: [:destroy]

  def index
    @wikis = policy_scope(Wiki)
  end

  def new
    @user = current_user
    @wiki = Wiki.new
  end

  def create
    @user = current_user
    @wiki = Wiki.new
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = params[:wiki][:public]
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      #redirect_to @wiki
      # call the collaborators controller create action
      # create the collaborator here
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaboration = @wiki.collaborators.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborator = Collaborator.new
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting the wiki."
      render :show
    end
  end

  def authorize_user
    @wiki = Wiki.find(params[:id])
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to @wiki
    end
  end

  private

  def user_admin_or_premium?
    (current_user.admin? || current_user.premium?)
  end 

end