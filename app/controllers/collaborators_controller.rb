class CollaboratorsController < ApplicationController
  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = WikiCollaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:email])
    @collaborator = WikiCollaborator.new(wiki: @wiki, user: @user)
    # @collaborator = @user.collaborators.build({ wiki: @wiki })

    if @collaborator.save
      flash[:notice] = 'Collaborator was added to this wiki.'
      redirect_to @wiki
    else
      flash[:error] = 'Collaborator was not added. Please try again.'
      render :show
    end
   end

  def destroy
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = 'Collaborator was removed from this wiki.'
      redirect_to @wiki
    else
      flash[:error] = 'Collaborator was not removed. Please try again.'
      render :show
    end
   end

  private

  def collaboration_params
    params.require(:collaborator).permit(:user_id)
  end
end
