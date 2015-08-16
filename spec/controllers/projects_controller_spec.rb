require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  describe 'GET #index' do
    sign_in_user
    before { get :index }

    context "for index" do

      # let(:projects) { create_list(:project, 2, user: user) }
      # # let(:project1) { create(:project, user: user) }
      # # let(:project2) { create(:project, user: user) }
      # it 'has array of projects that belongs to user' do
      #   # pry
      #   expect(assigns(:projects)).to match_array(projects)
      # end

      it 'render index' do
        expect(response).to render_template :index
      end
    end

    context "for new project" do
      it "creates new project" do
        expect(assigns(:project)).to be_a_new(Project)
      end

      it "renders new view" do
        expect(response).to render_template :index
      end
    end
  end

  describe 'POST #create' do
    sign_in_user

    context 'with valid atrributes' do
      it 'saves new project' do
        expect { post :create, project: attributes_for(:project), format: :js }.to change(Project, :count).by(1)
      end

      it 'assigns project to user_id' do
        post :create, user_id: user, project: attributes_for(:project), format: :js
        expect(project.user_id).to eq user.id
      end

      it 'redirects to main page' do
        post :create, project: attributes_for(:project), format: :js
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid attributes' do
      it 'does not save project' do
        expect { post :create, project: attributes_for(:project, :invalid), format: :js }.to_not change(Project, :count)
      end

      it 'renders root_path' do
        post :create, project: attributes_for(:project, :invalid), format: :js
        expect(response).to be_success
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'valid attributes' do
      it 'assigns project to @project' do
        patch :update, id: project, project: attributes_for(:project), format: :json
        expect(assigns(:project)).to eq project
        expect(project.user_id).to eq user.id
      end

      it 'changes the project' do
        patch :update, id: project, project: { name: 'new name' }, format: :json
        project.reload
        expect(project.name).to eq 'new name'
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: project, project: { name: nil }, format: :json }

      it 'does not change attributes' do
        project.reload
        expect(project.name).to eq project.name
      end

      it 'renders #index' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    before { project }

    it 'deletes project' do
      expect { delete :destroy, id: project, format: :js }.to change(Project, :count).by(-1)
    end

    it 'redirect to #index' do
      delete :destroy, id: project, format: :js
      expect(response).to render_template("projects/destroy")
    end
  end
end
