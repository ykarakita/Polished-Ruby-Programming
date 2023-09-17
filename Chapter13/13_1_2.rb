# クラスベースのオブジェクトシステム
foo_class = Class.new
foo_class.define_method(:bar) do
  2
end
foo_instance = foo_class.new
pp foo_instance.bar

# Prototypeパターン
foo_proto = Object.new
foo_proto.define_singleton_method(:bar) do
  2
end
foo_clone = foo_proto.clone
pp foo_clone.bar

# mixed
foo_class = Class.new
foo_class.define_method(:bar) do
  2
end
foo_class_clone = foo_class.clone
foo_class_clone_instance = foo_class_clone.new
foo_class_clone_clone = foo_class_clone_instance.clone
pp foo_class_clone_clone.bar
