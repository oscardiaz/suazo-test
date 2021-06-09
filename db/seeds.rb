# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times { User.create(email: Faker::Internet.email, password: 'Password123', password_confirmation: 'Password123') }

User.all.each do |user|
  groups = []
  2.times do
    group = Group.new(title: Faker::Lorem.word)
    group.tasks << [Task.new(title: Faker::Lorem.word, description: Faker::Lorem.sentence(word_count: 6)), Task.new(title: Faker::Lorem.word, description: Faker::Lorem.sentence(word_count: 6))]
    groups.push(group)
  end
  user.groups << groups
end
