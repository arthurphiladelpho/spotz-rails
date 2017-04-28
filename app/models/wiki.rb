class Wiki < ActiveRecord::Base
  belongs_to :user
  after_initialize {self.role ||= :publik}

  enum role: [:publik, :premium]
end
