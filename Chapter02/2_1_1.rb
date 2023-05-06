
class SymbolStack
  def initialize
    @stack = []
  end

  def push(sym)
    raise TypeError unless sym.is_a?(Symbol)
    @stack.push([sym, clock_time])
  end

  def pop
    sym, pushed_at = @stack.pop
    [sym, clock_time - pushed_at]
  end

  private def clock_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end
end

symbol_stack = SymbolStack.new
symbol_stack.push(:a)
symbol_stack.push(:b)
symbol_stack.push(:c)
p symbol_stack.pop
# => [:c, 1.0000000000000009e-06]

symbol_stack.push("d")
# => TypeError