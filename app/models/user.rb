class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :wikis, dependent: :destroy
  has_many :wiki_collaborators
  has_many :collaborators, through: :wiki_collaborators

  after_initialize { self.role ||= :standard }

  enum role: %i[standard admin premium]
end
