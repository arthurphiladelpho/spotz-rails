require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(email: 'test@mail.com', password: 'pass123') }

  describe 'attributes' do
    it 'should have name and email attributes' do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end
    it 'responds to role' do
      expect(user).to respond_to(:role)
    end
    it 'responds to admin?' do
      expect(user).to respond_to(:admin?)
    end
    it 'responds to standard?' do
      expect(user).to respond_to(:standard?)
    end
    it 'responds to premium?' do
      expect(user).to respond_to(:premium?)
    end
  end # end of describe "attributes"

  describe 'roles' do
    it 'is standard by default' do
      expect(user.role).to eql('standard')
    end

    context 'standard user' do
      it 'returns true for #standard?' do
        expect(user.standard?).to be_truthy
      end
      it 'returns false for #admin?' do
        expect(user.admin?).to be_falsey
      end
      it 'returns false for #premium?' do
        expect(user.premium?).to be_falsey
      end
    end

    context 'admin user' do
      before do
        user.admin!
      end
      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end
      it 'returns true for #admin?' do
        expect(user.admin?).to be_truthy
      end
      it 'returns false for #premium?' do
        expect(user.premium?).to be_falsey
      end
    end

    context 'premium user' do
      before do
        user.premium!
      end
      it 'returns false for #standard?' do
        expect(user.standard?).to be_falsey
      end
      it 'returns false for #admin?' do
        expect(user.admin?).to be_falsey
      end
      it 'returns true for #premium?' do
        expect(user.premium?).to be_truthy
      end
    end
  end
end # end of RSpec.describe
