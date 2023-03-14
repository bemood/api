json.id music.id
json.spotify_id music.spotify_id
json.music do
  track = music.get_spotify_song
  json.id track.id
  json.name track.name
  json.artist track.artists[0].name
  json.album track.album.name
  json.image track.album.images[0]['url']
  json.preview_url track.preview_url
end
