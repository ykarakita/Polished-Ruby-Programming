
album_infos = [
  ["Album 1", 1, "Queen"],
  ["Album 1", 1, "Beatles"],
  ["Album 1", 2, "Queen"],
  ["Album 1", 3, "Oasis"],
  ["Album 2", 1, "David Bowie"],
  ["Album 2", 2, "David Bowie"],
  ["Album 2", 3, "Beatles"],
]

# album_infos = 100.times.flat_map do |i|
#   10.times.map do |j|
#     ["Album #{i}", j, "Artist #{i}"]
#   end
# end

# アルバム名をキーにした Hash と、アルバム名とトラック番号の配列をキーにした Hash を作成する
album_artists = {}
album_track_artists = {}
album_infos.each do |album, track, artist|
  (album_artists[album] ||= []) << artist
  (album_track_artists[[album, track]] ||= []) << artist
end

album_artists.each_value(&:uniq!)
# pp album_track_artists
# => {["Album 1", 1]=>["Queen", "Beatles"], ["Album 1", 2]=>["Queen"], ["Album 1", 3]=>["Oasis"], ["Album 2", 1]=>["David Bowie"], ["Album 2", 2]=>["David Bowie"], ["Album 2", 3]=>["Beatles"]}

# pp album_artists
# => {"Album 1"=>["Queen", "Beatles", "Oasis"], "Album 2"=>["David Bowie", "Beatles"]}

lookup = ->(album, track=nil) do
  if track
    album_track_artists[[album, track]]
  else
    album_artists[album]
  end
end

# pp lookup.call("Album 1", 1)
# => ["Queen", "Beatles"]
# pp lookup.call("Album 1")
# => ["Queen", "Beatles", "Oasis"]

# ----------------------------------------------------

# アルバムごとに、トラック番号をキー、アーティスト名の配列を値に格納した Hash を作成する
albums = {}
album_infos.each do |album, track, artist|
  ((albums[album] ||= {})[track] ||= []) << artist
end
# pp albums
# => {"Album 1"=>{1=>["Queen", "Beatles"], 2=>["Queen"], 3=>["Beatles"]}, "Album 2"=>{1=>["David Bowie"], 2=>["David Bowie"], 3=>["Beatles"]}}

lookup = ->(album, track=nil) do
  if track
    albums.dig(album, track)
  else
    a = albums[album].each_value.to_a
    a.flatten!
    a.uniq!
    a
  end
end

# pp lookup.call("Album 1")
# => ["Queen", "Beatles", "Oasis"]

# pp lookup.call("Album 1", 1)
# => ["Queen", "Beatles"]

# ----------------------------------------------------

# アルバムをキーにした Hash を作成し、その値には、アーティストの配列の配列を作成する
# 配列の0番目には、アルバムに参加したアーティストの配列を格納する
# 配列の1番目以降には、n番目のトラックに参加したアーティストの配列を格納する

# { "Album 1" => [["Queen", "Beatles", "Oasis"], ["Queen", "Beatles"], ["Queen"], ["Oasis"]] }
albums = {}
album_infos.each do |album, track, artist|
  album_array = albums[album] ||= [[]]
  album_array[0] << artist
  (album_array[track] ||= []) << artist
end

albums.each_value do |array|
  array[0].uniq!
end
# pp albums
# => {"Album 1"=>[["Queen", "Beatles", "Oasis"], ["Queen", "Beatles"], ["Queen"], ["Oasis"]], "Album 2"=>[["David Bowie", "Beatles"], ["David Bowie"], ["Beatles"]]}

lookup = ->(album, track=0) do
  albums.dig(album, track)
end

# pp lookup.call("Album 1")
# => ["Queen", "Beatles", "Oasis"]

# pp lookup.call("Album 1", 1)
# => ["Queen", "Beatles"]
