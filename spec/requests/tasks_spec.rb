require 'rails_helper'

RSpec.describe 'Tasks', type: :request do

  describe 'GET /tasks' do
    it '200ステータス' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /tasks' do
    context 'パラメータが正常値の場合' do
      it 'タスクが作成される' do
        task_params = attributes_for(:task)

        expect {
          post tasks_path, params: { task: task_params }
        }.to change(Task, :count).by(1)

        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_path)

        expect(Task.last.title).to eq(task_params[:title])
        expect(Task.last.deadline).to eq(task_params[:deadline])
        expect(Task.last.content).to eq(task_params[:content])
        expect(Task.last.completed).to be_falsey
      end
    end

    context 'パラメータが異常値の場合' do
      it '422エラーが返る' do
        task_params = attributes_for(:task, title: '')

        expect {
          post tasks_path, params: { task: task_params }
        }.not_to change(Task, :count)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /tasks/:id' do
    let(:task) { create(:task) }

    context 'パラメータが正常値の場合' do
      it 'タスクが更新される' do
        task_params = attributes_for(:task)
        put task_path(task), params: { task: task_params }, headers: { Accept: 'text/vnd.turbo-stream.html, text/html' }

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq 'text/vnd.turbo-stream.html; charset=utf-8'

        task.reload
        expect(task.title).to eq(task_params[:title])
        expect(task.deadline).to eq(task_params[:deadline])
        expect(task.content).to eq(task_params[:content])
      end
    end

    context 'パラメータが異常値の場合' do
      it '422エラーが返る' do
        task_params = attributes_for(:task, title: '')
        original_title = task.title
        original_content = task.content
        original_deadline = task.deadline
        put task_path(task), params: { task: task_params }, headers: { Accept: 'text/vnd.turbo-stream.html, text/html' }

        expect(response).to have_http_status(422)
        task.reload
        expect(task.title).to eq(original_title)
        expect(task.deadline).to eq(original_deadline)
        expect(task.content).to eq(original_content)
      end
    end
  end

  describe 'DELETE /tasks/:id' do
    let!(:task) { create(:task) }

    it 'タスクが削除される' do
      expect {
        delete task_path(task), headers: { Accept: 'text/vnd.turbo-stream.html, text/html' }
      }.to change(Task, :count).by(-1)

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq 'text/vnd.turbo-stream.html; charset=utf-8'
    end
  end
end
