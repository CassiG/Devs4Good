require 'rails_helper'

RSpec.describe ProposalsController, type: :controller do

  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:developer) }
    let!(:new_organization) { FactoryGirl.create(:organization) }
    let!(:test_project) { FactoryGirl.create(:project) }
    before(:each) do
      @user = user
      login_user(user)
    end

    it 'returns a status code of 302' do
      post :create, params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal) }
      expect(response.status).to eq 302
    end

    context 'with valid attributes' do
      it 'creates a new proposal' do
        expect {
          post :create, params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal)
        } }.to change{Proposal.all.count}.by 1
      end

      it 'returns a status code of 302' do
        post :create,  params: { project_id: test_project.id, proposal: FactoryGirl.attributes_for(:proposal) }
        expect(response).to have_http_status 302
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new proposal' do
        expect{ post :create, params: { project_id: test_project.id, proposal: { description: nil, user_id: 2 } } }.not_to change{ Proposal.all.count }
      end

      it 'renders the new proposal view' do
        post :create, params: { project_id: test_project.id, proposal: { description: nil, user_id: 2 } }
        expect(response).to render_template(:new)
      end
    end


    describe 'GET#show' do
      let(:test_project) { FactoryGirl.create(:project) }
      let(:new_proposal) { FactoryGirl.create(:proposal) }

      it "returns a status of 200" do
        get :show, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to have_http_status 200
      end

      it "renders a show page" do
        get :show, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to render_template :show
      end
    end

    describe 'Delete #destroy' do
      let!(:test_project) { FactoryGirl.create(:project) }
      let!(:new_proposal) { FactoryGirl.create(:proposal) }

      it 'responds with a status code 302' do
        delete :destroy, params: { project_id: test_project.id, id: new_proposal.id}
        expect(response).to have_http_status 302
      end

      it 'destroyed the requested proposal' do
        expect{ delete :destroy, params: { project_id: test_project.id, id: new_proposal.id } }.to change(Proposal, :count).by (-1)
      end

      it 'redirects back to the organization show page' do
        delete :destroy, params: { project_id: test_project.id, id: new_proposal.id }
        expect(response).to redirect_to organization_project_path( new_proposal.project.organization_id, new_proposal.project_id)
      end
    end

  end
end
