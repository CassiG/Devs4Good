require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do

  context 'GET#index' do
    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    it 'assigns projects to @projects' do
      project = FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end

    it 'renders an index view' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do

    it 'returns a status code of 200' do
      expect(response.status).to eq 200
    end

    context 'with valid attributes' do
      it 'creates a new project' do
        expect {
          post :create, params: { project: FactoryGirl.attributes_for(:project)
        } }.to change(Project, :count).by 1
      end

      it 'redirects to the new project' do
        post :create,  params: { project: FactoryGirl.attributes_for(:project) }
        expect(response).to have_http_status 302
      end
    end

    context 'with invalid attributes' do
      it 'does not a new project' do
        expect {
          post :create, params: { project: { description: nil } } }.not_to change{ Project.all.count }
      end

      it 'rerenders the new method' do
        post :create, params: { project: { description: nil } }
        expect(response).to render_template(:new)
      end
    end

  end

  describe 'DELETE#destroy' do
    let!(:test_project) { FactoryGirl.create(:project) }

    it 'responds with status code 302' do
      delete :destroy, params: { id: test_project.id }
      expect(response).to have_http_status 302
    end

    it 'destroys the requested project' do
      expect{ delete :destroy, params: { id: test_project.id } }.to change(Project, :count).by(-1)
    end

    it 'redirects to the projects list' do
      delete :destroy, params: { id: test_project.id }
      expect(response).to redirect_to projects_path
    end
  end

end
