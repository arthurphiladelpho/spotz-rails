require 'rails_helper'

RSpec.describe User, type: :model do
  
	describe "after creation" do
	  it "sends a confirmation email" do
		  user = FactoryGirl.build :user

		  expect { user.save }.to change(
		  	Devise.mailer.deliveries, :count
		  ).by(1)
		end
	end
end