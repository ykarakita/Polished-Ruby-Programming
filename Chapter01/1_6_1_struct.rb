
A = Struct.new(:a, :b)

a = A.new(1, 2)
# p a.a
# => 1

# ミュータブル
a.a = 3
# p a.a
# => 3

# ----------------------------------------------------

# イミュータブルな構造体を作成する

A = Struct.new(:a, :b) do
  def initialize(...)
    super
    freeze
  end
end

a = A.new(1, 2)
p a.a
# => 1

a.a = 3
# => FrozenError (can't modify frozen A)
