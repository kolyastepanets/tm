require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }

  describe 'POST #create' do
    sign_in_user

    context 'with valid atrributes' do
      it 'saves new task' do
        expect { post :create, project_id: project, task: attributes_for(:task), format: :js }.to change(Task, :count).by(1)
      end

      it 'assigns task to project_id' do
        post :create, project_id: project, task: attributes_for(:task), format: :js
        task = assigns(:task)
        expect(task.project_id).to eq project.id
      end

      it 'redirects to main page' do
        post :create, project_id: project, task: attributes_for(:task), format: :js
        expect(response.status).to eq(200)
      end
    end

    context 'with invalid attributes' do
      it 'does not save task' do
        expect { post :create, project_id: project, task: attributes_for(:task, :invalid), format: :js }.to_not change(Task, :count)       
      end

      it 'renders root_path' do
        post :create, project_id: project, task: attributes_for(:task, :invalid), format: :js
        expect(response).to redirect_to root_path
      end
    end
  end
end
