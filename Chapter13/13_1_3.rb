# private class data パターン

class Foo
  @par = 1
end

class FooPrivate
  BAR = 3
  def self.bar
    2
  end

  private_class_method :bar
  private_constant :BAR
end
