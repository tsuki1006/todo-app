# frozen_string_literal: true

module TaskDecorator
  def display_deadline
    return unless deadline

    case deadline
    when Date.today
      '今日'
    when Date.tomorrow
      '明日'
    when Date.yesterday
      '昨日'
    else
      I18n.l(self.deadline, format: :long_mda)
    end
  end
end
