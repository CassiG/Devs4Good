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
  end


    describe 'GET#show' do
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:test_project) { FactoryGirl.create(:project) }
      let!(:new_proposal) { FactoryGirl.create(:proposal) }

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
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:developer) { FactoryGirl.create(:developer) }
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
        expect(response).to redirect_to organization_project_path( new_proposal.project_id, new_proposal.project.organization_id)
      end
    end

    describe 'PATCH#update' do

    context 'Editing proposal' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { description: 'New awesome description'} }
      end

      it 'returns 302' do
        expect(response).to have_http_status 302
      end

      it 'changes description of proposal' do
        expect(Proposal.find(proposal.id).description).to eq 'New awesome description'
      end

      it 'assigns the proposal to @proposal' do
        expect(assigns[:proposal]).to eq proposal
      end
    end

    context 'Editing proposal with invalid params' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { description: ''} }
      end

      it 'does not change proposal description' do
        expect(Proposal.find(proposal.id).description).not_to eq('')
      end
    end

    context 'selecting proposal' do
      let!(:developer) { FactoryGirl.create(:developer) }
      let!(:organization) { FactoryGirl.create(:organization) }
      let!(:project) { FactoryGirl.create(:project) }
      let!(:proposal) { FactoryGirl.create(:proposal, project_id: project.id, user_id: developer.id) }
      before(:each) do
        patch :update, params: { project_id: project.id, id: proposal.id, proposal: { selected: true } }
      end

      it 'returns 302' do
        expect(response).to have_http_status 302
      end

      it 'changes proposal selected to true' do
        expect(Proposal.find(proposal.id).selected).to eq true
      end

      it 'assigns the proposal to @proposal' do
        expect(assigns[:proposal]).to eq proposal
      end
    end
    end
end
