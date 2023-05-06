
class CurrentDay
  def initialize
    @date = Date.today
    @schedule = MonthlySchedule.new(@date.year, @date.month)
  end

  def work_hours
    @schedule.work_hours_for(@date)
  end

  def workday?
    !@schedule.holidays.include?(@date)
  end
end

# CurrentDay のテストが難しい
# 今日が稼働日か非稼働日かによってテストの結果が変わる
# テスト実行時に Date.today を上書きすれば回避できる

before do
  Date.singleton_class.class_eval do
    alias_method :_today, :today
    define_method(:today) { Date.new(2021, 1, 1) }
  end
end

after do
  Date.singleton_class.class_eval do
    alias_method :today, :_today
    remove_method :_today
  end
end

class CurrentDay
  def initialize(date: Date.today)
    @date = date
    @schedule = MonthlySchedule.new(@date.year, @date.month)
  end
end


class CurrentDay
  def initialize(date: Date.today, schedule: MonthlySchedule.new(date.year, date.month))
    @date = date
    @schedule = schedule
  end
end


class CurrentDay
  def initialize(date: Date.today, schedule_class: MonthlySchedule)
    @date = date
    @schedule = schedule_class.new(date.year, date.month)
  end
end
