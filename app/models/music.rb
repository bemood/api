class Music < ApplicationRecord
  has_many :posts

  def render
    track = RSpotify::Track.find(self.spotify_id)

    return {
      id: self.id,
      spotify_id: self.spotify_id,
      music: {
        id: track.id,
        name: track.name,
        artist: track.artists[0].name,
        album: track.album.name,
        image: track.album.images[0]['url'],
        preview_url: track.preview_url
      }
    }
  end

  def get_spotify_song
    MusicService.new.retrieve_music(self.spotify_id)
  end
end
