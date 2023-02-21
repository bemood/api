class MoodController < ApplicationController

  def all_moods
    moods = Mood.all.map { |mood| {id: mood.id, definition: mood.definition, emojie: mood.emojie }}
    render json: moods
  end

end
