require 'rails_helper'

RSpec.describe 'Completions', type: :request do
  let!(:task) { create(:task) }

  describe 'PUT tasks/:task_id/completion' do
    it 'タスクの完了状態が切り替わる' do
      put task_completion_path(task), params: { task: { completed: true } }

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
      expect{ task.reload }.to change{ task.completed }.from(false).to(true)
    end
  end
end
