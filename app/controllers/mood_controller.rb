class MoodController < ApplicationController

  def all_moods
    @moods = Mood.all
    render 'moods/index'
  end
end
