class Wiki < ActiveRecord::Base
  belongs_to :user

  def self.public
  	where(public: true)
  end	
end
