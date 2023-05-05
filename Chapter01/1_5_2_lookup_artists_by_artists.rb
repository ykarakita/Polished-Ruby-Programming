
album_infos = [
  ["Album 1", 1, "Queen"],
  ["Album 1", 1, "Beatles"],
  ["Album 1", 2, "Queen"],
  ["Album 1", 3, "Oasis"],
  ["Album 2", 1, "David Bowie"],
  ["Album 2", 2, "David Bowie"],
  ["Album 2", 3, "Beatles"],
]

# Using Array
album_artists = album_infos.flat_map(&:last)
album_artists.uniq!

# pp album_artists
# => ["Queen", "Beatles", "Oasis", "David Bowie"]

lookup = ->(artists) do
  album_artists & artists
end

# pp lookup.call(["Queen", "Beatles"])
# => ["Queen", "Beatles"]

# pp lookup.call(["Queen", "Beatles", "Carpenters"])
# => ["Queen", "Beatles"]

# ----------------------------------------------------

# Using Hash
album_artists = {}
album_infos.each do |_, _, artist|
  album_artists[artist] ||= true
end

# pp album_artists
# => {"Queen"=>true, "Beatles"=>true, "Oasis"=>true, "David Bowie"=>true}

lookup = ->(artists) do
  artists.select do |artist|
    album_artists[artist]
  end
end

# pp lookup.call(["Queen", "Beatles"])
# => ["Queen", "Beatles"]

# pp lookup.call(["Queen", "Beatles", "Carpenters"])
# => ["Queen", "Beatles"]


# ----------------------------------------------------

# Using Set
#
# Ruby3.2からSetクラスが標準ライブラリになったので不要
# require "set"

album_artists = Set.new(album_infos.flat_map(&:last))

# pp album_artists
# => #<Set: {"Queen", "Beatles", "Oasis", "David Bowie"}>

lookup = ->(artists) do
  album_artists & artists
end

# pp lookup.call(["Queen", "Beatles"])
# => #<Set: {"Queen", "Beatles"}>

# pp lookup.call(["Queen", "Beatles", "Carpenters"])
# => #<Set: {"Queen", "Beatles"}>

# ----------------------------------------------------
# Array, Hash, Set の中で、Hash が一番実行速度が速い
# Set は Array より速いが、内部で Hash を使っているので Hash よりは遅くなる
# 性能が求められる場合は Hash を使う
