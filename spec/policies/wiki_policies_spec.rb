require 'rails_helper'

RSpec.describe WikiPolicy do
  subject { described_class }

  context 'for a visitor' do
    let(:user) { nil }
    let(:wiki) { Wiki.create!(title: 'New Wiki Title', body: 'New Wiki Body', private: false) }

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it "doesn't grant access for non logged in users" do
        expect(subject).not_to permit(user, wiki)
      end
    end
  end

  context 'for a standard user' do
    let(:user) { User.create!(email: 'test@mail.com', password: 'pass123') }
    let(:wiki) { Wiki.create!(title: 'New Wiki Title', body: 'New Wiki Body', private: false) }

    permissions :index?, :show?, :new?, :edit?, :create?, :update? do
      it 'allows standard users to do everything but destroy wikis' do
        expect(subject).to permit(user, wiki)
      end
    end

    permissions :destroy? do
      it "doesn't allow standard users to delete wikis that don't belong to them" do
        expect(subject).not_to permit(user, wiki)
      end
    end
  end

  context 'for an admin user' do
    let(:user) { User.create!(email: 'test@mail.com', password: 'pass123') }
    let(:wiki) { Wiki.create!(title: 'New Wiki Title', body: 'New Wiki Body', private: false) }

    before do
      user.admin!
    end

    permissions :index?, :show?, :new?, :edit?, :create?, :update?, :destroy? do
      it 'allows admin users to do everything' do
        expect(subject).to permit(user, wiki)
      end
    end
  end
end
