class Music < ApplicationRecord
  has_many :posts

  def render
    return {
      id: self.id,
      spotify_id: self.spotify_id,
      music: spotify_music
    }
  end

  def spotify_music
    track = RSpotify::Track.find(self.spotify_id.to_s)
    {
      id: track.id,
      name: track.name,
      artist: track.artists[0].name,
      album: track.album.name,
      image: track.album.images[0]['url'],
      preview_url: track.preview_url
    }
  end
end
