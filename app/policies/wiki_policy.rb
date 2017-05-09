class WikiPolicy
	attr_reader :wiki, :user

	def initialize(user, wiki)
		@user = user
		@wiki = wiki
	end	

	def index?
		user.admin?
	end

	def show?
		user.admin?
	end

	def update?
		user.admin?
	end

	def destroy?
		user.admin?
	end
end