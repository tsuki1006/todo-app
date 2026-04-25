module TasksHelper
  def add_alert_class(task)
    if task.completed == false
      '-alert' if task.deadline && task.deadline < Date.current
    end
  end
end
