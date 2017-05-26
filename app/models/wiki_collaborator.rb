class WikiCollaborator < ActiveRecord::Base
	belongs_to :user
	belongs_to :wiki

	@user_options = User.all.map { |user| [user.email, user.id]}

end
