json.array! @moods do |mood|
  json.partial! 'moods/mood', mood: mood
end
