class Wiki < ActiveRecord::Base
  belongs_to :user
  
  def self.public?
  	where(private: false)
  end	
end
