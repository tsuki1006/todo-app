require 'rails_helper'

RSpec.describe 'CompletedAlls', type: :request do
  let!(:completed_tasks) { create_list(:task, 3, completed: 'true') }

  describe 'DELETE /tasks/completed_all' do
    it 'すべての完了データが削除される' do
      expect{
        delete completed_all_path
      }.to change{ Task.completed.size }.from(3).to(0)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
