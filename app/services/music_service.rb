require 'redis'

class MusicService
  def initialize
    @redis = Redis.new(url: ENV['REDIS_URL'])
  end

  def retrieve_music(spotify_id)
    data = @redis.get(spotify_id)

    if data
      JSON.parse(data)
    else
      music = RSpotify::Track.find(spotify_id)

      self.save_music(music)

      JSON.parse(music.to_json)
    end
  end

  def save_music(music)
    puts music.class
    @redis.set(music.id, music.to_json)
  end
end
