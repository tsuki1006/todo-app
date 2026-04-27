# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  completed  :boolean          default(FALSE), not null
#  content    :text
#  deadline   :date
#  title      :string(100)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Task < ApplicationRecord
  # バリデーション
  validates :title, presence: true, length: { maximum: 100 }
  validates :completed, inclusion: { in: [true, false] }

  validate :cannot_edit_completed_task, on: :update

  # 完了状態で編集できない
  def cannot_edit_completed_task
    if self.completed? && Task.find(self.id).completed?
      errors.add(:base, '完了したタスクは編集できません')
    end
  end

  # スコープ
  scope :completed, -> { where(completed: true) }
  scope :uncompleted, -> { where(completed: false) }

  # メソッド

  # 完了状態の一括切り替え
  def self.change_whole_completion_to(status)
    target_tasks = status ? uncompleted : completed
    target_tasks.update_all(completed: status)
  end
end
