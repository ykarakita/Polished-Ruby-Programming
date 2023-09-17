# Proxy パターン

# 一部のメソッドだけをラップしたい場合
require "forwardable"

class Proxy
  extend Forwardable

  def initialize(value)
    @value = value
  end

  def_delegator :@value, :to_s
end

pp Proxy.new(1).to_s


# すべてのメソッドをラップしたい場合
require "delegate"

class Proxy2 < SimpleDelegator
  def add_3
    self + 3
  end
end

proxy2_instance = Proxy2.new(1)
proxy2_instance.add_3
pp proxy2_instance.to_s


# 特定の種類のオブジェクトだけをラップしたい場合
class HashProxy < DelegateClass(Hash)
  def size_squared
    size ** 2
  end
end

pp HashProxy.new(a: 1, b: 2, c: 3).size_squared
