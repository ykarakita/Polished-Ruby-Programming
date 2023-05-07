
# class MultiplyProf
#   def initialize(vals)
#     @i1, @i2 = vals.map(&:to_i)
#     @f1, @f2 = vals.map(&:to_f)
#     @r1, @r2 = vals.map(&:to_r)
#   end
#
#   def integer
#     @i1 * @i2
#   end
#
#   def float
#     @f1 * @f2
#   end
#
#   def rational
#     @r1 * @r2
#   end
# end

# class MultiplyProf
#   def initialize(vals)
#     v1, v2 = vals
#     @i1, @i2 = v1.to_i, v2.to_i
#     @f1, @f2 = v1.to_f, v2.to_f
#     @r1, @r2 = v1.to_r, v2.to_r
#   end
#
#   def integer
#     @i1 * @i2
#   end
#
#   def float
#     @f1 * @f2
#   end
#
#   def rational
#     @r1 * @r2
#   end
# end

class MultiplyProf
  def initialize(vals)
    @vals = vals
  end

  def integer
    @vals[0].to_i * @vals[1].to_i
  end

  def float
    @vals[0].to_f * @vals[1].to_f
  end

  def rational
    @vals[0].to_r * @vals[1].to_r
  end
end

mp = MultiplyProf.new([2.4r, 4.2r])
mp.integer
# => 8

mp.float
# => 10.08

mp.rational
# => (252/25)

require "ruby-prof"

result = RubyProf.profile do
  i = 0
  while i < 1000
    mp = MultiplyProf.new([2.4r, 4.2r])
    mp.integer
    mp.float
    mp.rational
    i += 1
  end
end

printer = RubyProf::FlatPrinter.new(result)
printer.print(STDOUT, {})
#  %self      total      self      wait     child     calls  name
#  24.27      0.001     0.001     0.000     0.000     3000   Array#map
#  15.61      0.003     0.000     0.000     0.002        1   Integer#times
#  14.44      0.001     0.000     0.000     0.001     1000   MultiplyProf#initialize
#   6.46      0.000     0.000     0.000     0.000     1000   MultiplyProf#rational
#   6.22      0.000     0.000     0.000     0.000     1000   MultiplyProf#integer
#   5.77      0.002     0.000     0.000     0.001     1000   Class#new
#   5.61      0.000     0.000     0.000     0.000     1000   MultiplyProf#float
#   5.47      0.000     0.000     0.000     0.000     2000   Rational#to_f
#   4.36      0.000     0.000     0.000     0.000     2000   Rational#to_r
#   4.30      0.000     0.000     0.000     0.000     2000   Rational#to_i
#   3.13      0.000     0.000     0.000     0.000     1000   Rational#*
#   2.22      0.000     0.000     0.000     0.000     1000   Integer#*
#   2.04      0.000     0.000     0.000     0.000     1000   Float#*
#   0.11      0.003     0.000     0.000     0.003        1   [global]#

require "benchmark"

result = Benchmark.realtime do
  2000000.times do
    mp = MultiplyProf.new([2.4r, 4.2r])
    mp.integer
    mp.float
    mp.rational
  end
end

p result
# => 1.1265730001032352
