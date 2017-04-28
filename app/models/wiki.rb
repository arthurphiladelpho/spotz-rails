class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize {self.role ||= :public}

  enum role [:public, :premium]
end
