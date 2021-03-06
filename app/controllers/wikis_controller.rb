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
    @wiki = current_user.wikis.build
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = true
    if @wiki.save
      flash[:notice] = 'Wiki was saved.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the post. Please try again.'
      render :new
    end
  end

  def show
    @wiki = Wiki.find(params[:id])
    @collaboration = @wiki.collaborators.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
    @collaborator = WikiCollaborator.new
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.title = params[:wiki][:title]
    @wiki.body = params[:wiki][:body]
    @wiki.public = params[:wiki][:public]
    @wiki.collaborators.destroy_all

    # Create collaborator
    params[:wiki][:user_id].each do |id|
      # Create WikiCollborator record
      next if id == ''
      id.to_i

      @collaborator = WikiCollaborator.find_or_create_by(wiki: @wiki, user_id: id)
    end

    if @wiki.save
      flash[:notice] = 'Wiki was updated.'
      redirect_to @wiki
    else
      flash.now[:alert] = 'There was an error saving the wiki. Please try again.'
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    if @wiki.destroy
      flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash.now[:alert] = 'There was an error deleting the wiki.'
      render :show
    end
  end

  def authorize_user
    @wiki = Wiki.find(params[:id])
    unless current_user.admin?
      flash[:alert] = 'You must be an admin to do that.'
      redirect_to @wiki
    end
  end

  def user_admin_or_premium?
    (current_user.admin? || current_user.premium?)
  end
end
