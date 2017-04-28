class WikiPolicy < ApplicationPolicy

	class Scope < Scope
		def resolve 
			if user.admin? || user.premimum?
				scope.all
			else
				scope.where(:publik => true)
			end
		end
	end

	def index?
		@user
	end

	def show?
		@user
	end

	def new?
		@user
	end

	def create?
		@user
	end

	def edit?
		@user
	end

	def update?
		@user
	end

	def destroy?
		@user && @user.admin?
	end

end