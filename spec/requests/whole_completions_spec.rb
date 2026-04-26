require 'rails_helper'

RSpec.describe 'WholeCompletions', type: :request do
  let!(:uncompleted_tasks) { create_list(:task, 3) }
  let!(:completed_tasks) { create_list(:task, 3, completed: 'true') }

  describe 'POST tasks/whole_completion' do
    it 'すべてのタスクが完了状態になる' do
      expect{
        post whole_completion_path
       }.to change{ Task.completed.size }.from(3).to(6)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE tasks/whole_completion' do
    it 'すべてのタスクが未完了状態になる' do
      expect{
        delete whole_completion_path
       }.to change{ Task.uncompleted.size }.from(3).to(6)

      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
    end
  end
end
