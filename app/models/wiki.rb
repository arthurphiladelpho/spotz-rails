class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :wiki_collaborators
  has_many :collaborators, through: :wiki_collaborators, source: :user


  def self.public
  	where(public: true)
  end	
end
