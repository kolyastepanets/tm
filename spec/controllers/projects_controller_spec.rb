require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  # let(:user) { create(:user) }
  let(:project) { create(:project) }

  describe 'GET #index' do
    # sign_in_user
    before { get :index }
    let(:projects) { create_list(:project, 2) }
    # let(:project2) { create(:project) }
    it 'has array of projects that belongs to user' do
    #   pry  
      expect(assigns(:projects)).to match_array(projects)
    end

    it 'render index' do
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    # sign_in_user
    before { get :new }

    it "creates new project" do
      expect(assigns(:project)).to be_a_new(Project)
    end

    it "renders new view" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    # sign_in_user

    before { get :edit, id: project}

    it 'assigns project to @project' do
      expect(assigns(:project)).to eq project
    end

    it 'renders #edit' do
      expect(response).to render_template :edit  
    end
  end

  describe 'POST #create' do
    # sign_in_user

    context 'with valid atrributes' do
      it 'saves new project' do
        expect { post :create, project: attributes_for(:project) }.to change(Project, :count).by(1)
      end

      # it 'assigns project to user_id' do
      #   post :create, user_id: user, project: attributes_for(:project)
      #   expect(project.user_id).to eq user.id
      # end

      it 'redirects to main page' do
        post :create, project: attributes_for(:project)
        expect(response).to redirect_to root_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save project' do
        expect { post :create, project: attributes_for(:project, :invalid) }.to_not change(Project, :count)       
      end

      it 'renders root_path' do
        post :create, project: attributes_for(:project, :invalid)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'PATCH #update' do
    # sign_in_user
    
    context 'valid attributes' do
      it 'assigns project to @project' do
        patch :update, id: project, project: attributes_for(:project)
        expect(assigns(:project)).to eq project
        # expect(project.user_id).to eq user.id
      end

      it 'changes the question' do
        patch :update, id: project, project: { name: 'new name' }
        project.reload
        expect(project.name).to eq 'new name'
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: project, project: { name: nil } }

      it 'does not change attributes' do
        project.reload
        expect(project.name).to eq project.name
      end

      it 'renders #edit' do
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    # sign_in_user

    before { project }

    it 'deletes question' do
      expect { delete :destroy, id: project }.to change(Project, :count).by(-1)
    end

    it 'redirect to #index' do
      delete :destroy, id: project
      expect(response).to redirect_to projects_path
    end
  end
end