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
        if user.admin? || user.premium?
          scope.all
        else
          scope.where(user: user)
        end
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