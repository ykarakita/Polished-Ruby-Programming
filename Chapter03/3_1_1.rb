
class TimeFilter
  attr_reader :start, :finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def to_proc
    start = self.start
    finish = self.finish

    if start && finish
      proc { |value| value >= start && value <= finish }
    elsif start
      proc { |value| value >= start }
    elsif finish
      proc { |value| value <= finish }
    else
      proc { |_| true }
    end
  end
end

time_filter = TimeFilter.new(Time.new(2016, 1, 1), Time.new(2016, 12, 31))
pp time_filter.to_proc.call(Time.new(2016, 1, 1))
# q: select(&time_filter) とは何か？
# a: selectメソッドの引数にブロックを渡すことで、ブロックの戻り値が真になる要素を集めた配列を返す。
[Time.new(2016, 1, 1), Time.new(2016, 12, 31), Time.new(2017, 6, 15)].select(&time_filter)
# => [2016-01-01 00:00:00 +0900, 2016-12-31 00:00:00 +0900]


# ----------------------------------------

num_arrays = 0
large_array.each do |value|
  if value.is_a?(Array)
    num_arrays += 1
  end
end

num_arrays = 0
# ローカル変数に代入することで実行性能が少し向上する
array_class = Array
large_array.each do |value|
  if value.is_a?(array_class)
    num_arrays += 1
  end
end

# ----------------------------------------

large_array.reject! do |value|
  value / 2.0 >= ARGV[0].to_f
end

max = ARGV[0].to_f
large_array.reject! do |value|
  value / 2.0 >= max
end

max = ARGV[0].to_f
large_array.reject! do |value|
  value >= max * 2
end

max = ARGV[0].to_f * 2
large_array.reject! do |value|
  value >= max
end

# ----------------------------------------
