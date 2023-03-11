# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "Seeding database..."
puts "Creating mood categories..."

Mood.create(definition: "Happy", emojie: "😀").save
Mood.create(definition: "Sad", emojie: "😢").save
Mood.create(definition: "Angry", emojie: "😡").save
Mood.create(definition: "Excited", emojie: "😃").save
Mood.create(definition: "Bored", emojie: "😴").save
Mood.create(definition: "Nostalgic", emojie: "😌").save

puts "Finished creating mood categories."

puts "Creating users..."

10.times do
  user = User.create(
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    name: Faker::Internet.username
  ).save
end

puts "Finished creating users."

puts "Creating posts..."

User.all.each do |user|
  10.times do
    user.posts.create(
      mood_id: Mood.all.sample.id,
      music_id: Music.all.sample.id
    ).save
  end
end

puts "Finished creating posts."

puts "Creating friendships..."

User.all.each do |user|
  5.times do
    user.followees << User.all.sample
  end
end

puts "Finished creating friendships."

puts "Finished seeding database."
