# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding database..."
puts "Creating mood categories..."

Mood.create(definition: "Happy", emojie: "😀").save
Mood.create(definition: "Sad", emojie: "😢").save
Mood.create(definition: "Angry", emojie: "😡").save
Mood.create(definition: "Excited", emojie: "😃").save
Mood.create(definition: "Bored", emojie: "😴").save
Mood.create(definition: "Nostalgic", emojie: "😌").save

puts "Finished creating mood categories."
