require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:task) { create(:task, project: project) }

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
        expect(response).to be_success
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'valid attributes' do
      it 'assigns task to @project' do
        patch :update, id: task, project_id: project, task: attributes_for(:task), format: :json
        expect(assigns(:task)).to eq task
        expect(task.project_id).to eq project.id
      end

      it 'changes the task' do
        patch :update, id: task, project_id: project, task: { name: 'new name' }, format: :json
        task.reload
        expect(task.name).to eq 'new name'
      end
    end

    context 'invalid attributes' do
      before { patch :update, id: task, project_id: project, task: { name: nil }, format: :json }

      it 'does not change attributes' do
        task.reload
        expect(task.name).to eq task.name
      end

      it 'renders #index' do
        expect(response.status).to eq(204)
      end
    end
  end

  describe 'DELETE #destroy' do

    before { task }
    before { sign_in(user) }

      it 'deletes task' do
        expect { delete :destroy, project_id: project, id: task, format: :js }.to change(Task, :count).by(-1)
      end

      it 'redirects to root_path' do
        delete :destroy, project_id: project, id: task, format: :js
        expect(response).to render_template("tasks/destroy")
    end
  end
end
