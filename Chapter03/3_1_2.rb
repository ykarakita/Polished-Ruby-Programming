
hash = some_value.to_hash
large_array.each do |value|
  hash[value] = true unless hash[:a]
end

hash = some_value.to_hash
a_value = hash[:a]
large_array.each do |value|
  hash[value] = true unless a_value
end
