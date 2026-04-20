class ChangeDatatypeDeadlineOfTasks < ActiveRecord::Migration[7.2]
  def change
    change_column :tasks, :deadline, :date
  end
end
