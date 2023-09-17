# Visitorパターン

class ArbitraryVisitor
  def visit(obj)
    case obj
    when Integer
      visit_integer(obj)
    when String
      visit_string(obj)
    when Array
      visit_array(obj)
    else
      raise ArgumentError, "unsupported object visited"
    end
  end

  private

  def visit_integer(obj)
    obj ** obj
  end

  def visit_string(obj)
    obj + obj.reverse
  end

  def visit_array(obj)
    obj.size
  end
end

av = ArbitraryVisitor.new
pp av.visit(4)
pp av.visit("palindrome")
pp av.visit([:a, :b, :c])

class HashedArbitraryVisitor < ArbitraryVisitor
  DISPATCH = {
    Integer => :visit_integer,
    String => :visit_string,
    Array => :visit_array,
  }.freeze

  def visit(obj)
    klass = obj.class
    if meth = DISPATCH[klass]
      send(meth, obj)
    else
      while klass = klass.superclass
        if meth = DISPATCH[klass]
          return send(meth, obj)
        end
      end
      raise ArgumentError, "unsupported object visited"
    end
  end
end

hav = HashedArbitraryVisitor.new
pp hav.visit([:a, :b, :c])
pp hav.visit(Class.new(Array)[:a, :b, :c])
