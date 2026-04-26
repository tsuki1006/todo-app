require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'バリデーション' do

    it '必須項目が正常に入力されているとき保存できる' do
      expect(build(:task)).to be_valid
    end

    context 'titleがないとき' do
      let(:task) { build(:task, title: '') }

      before do
        task.valid?
      end

      it '無効であること' do
        expect(task.errors.of_kind?(:title, :blank)).to be true
      end
    end

    context 'titleが100文字を超えているとき' do
      let(:task) { build(:task, title: Faker::Lorem.characters(number: 101)) }

      before do
        task.valid?
      end

      it '無効であること' do
        expect(task.errors.of_kind?(:title, :too_long)).to be true
      end
    end

    context 'タスク完了時' do
      let(:task) { create(:task, completed: true) }

      before do
        task.title = Faker::Lorem.characters(number: 30)
        task.valid?
      end

      it '更新できない' do
        expect(task.errors.messages[:base][0]).to eq('完了したタスクは編集できません')
      end
    end
  end

  describe 'デフォルト値' do

    context '新規作成時' do
      let(:task) { create(:task) }

      it 'completed のデフォルト値が false である' do
        expect(task.completed).to be false
      end
    end
  end

  describe 'スコープ' do

    let!(:uncompleted_task) { create(:task) }
    let!(:completed_task) { create(:task, completed: true) }

    it '未完了状態のタスクのみを返す' do
      expect(Task.uncompleted).to include(uncompleted_task)
      expect(Task.uncompleted).not_to include(completed_task)
    end

    it '完了状態のタスクのみを返す' do
      expect(Task.completed).to include(completed_task)
      expect(Task.completed).not_to include(uncompleted_task)
    end
  end
end
