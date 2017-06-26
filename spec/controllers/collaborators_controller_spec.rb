require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  describe 'POST #create' do
    it 'creates a WikiCollaborator record' do
      # Setup - create data
      user = FactoryGirl.create(:user)
      wiki = FactoryGirl.create(:wiki)
      # Action - make a request
      post :create, wiki_id: wiki.id, email: user.email
      # Assertion - did it work?
      # post.should eq(WikiCollaborator.count == 1)
      expect(WikiCollaborator.count).to eq(1)
    end
  end
end
