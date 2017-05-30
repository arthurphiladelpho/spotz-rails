class WikiPolicy

	attr_reader :user, :wiki

	def initialize(user, wiki)
	  @user = user
	  @wiki = wiki
	end

	class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin? || user.premium?
        wikis = scope.all # if the user is an admin, show them all the wikis
      else # this is the lowly standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.public? || wiki.collaborators.include?(user)
            wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end

	def index?
		@user.admin? || @user.premium?
	end

	def show?
		@user.admin? || @user.premium?
	end

	def destroy?
		@user.admin?
	end

end