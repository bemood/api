class MusicController < ApplicationController

  def search
    params = JSON.parse(request.body.read)
    tracks = RSpotify::Track.search("track: #{params['track']}")
    result = tracks.map do |track|
      {
        id: track.id,
        name: track.name,
        artist: track.artists[0].name,
        album: track.album.name,
        image: track.album.images[0]['url']
      }
    end
    render json: { results: result }
  end

  def music
    track = RSpotify::Track.find(params['music_id'].to_s)
    render json: {
      id: track.id,
      name: track.name,
      artist: track.artists[0].name,
      album: track.album.name,
      image: track.album.images[0]['url'],
      preview_url: track.preview_url
    }
  end

end
