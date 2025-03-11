# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creation de l'avatar"
avatar = Avatar.new(avatar_url:"https://ca.slack-edge.com/T02NE0241-U01BRUL3UTY-1471cb9cc95e-512")
avatar.save

puts "Creation du user Bob Dylan le king"
user = User.new(username: "BobD", first_name:"Bob", last_name:"Dylan", email:"bob.dylan@gmail.com", password: "123456")
user.avatar = avatar
user.save


QUESTION_TYPE = %w(image sound text)
CATEGORIES = %w(Geographic Entertainment History Art&Litterature Science&Nature Sports&Hobbies)

puts "Creation des categories"

CATEGORIES.each do |cat|
  Category.create!(name: cat)
end

puts "Creation des questions"
20.times do |_|
  q = Question.new(content: Faker::Lorem.paragraph(sentence_count: 1),
                   question_type: QUESTION_TYPE.sample,
                   media_url: ""
                  )
  q.category = Category.all.sample
  q.save
end

puts "Creation des answers"
questions_id = []
20.times do |_|
  answers = []
  answers << Answer.new(content: Faker::Drone.name, is_correct: true)
  3.times do |_|
    answers << Answer.new(content: Faker::Drone.name, is_correct: false)
  end
  question = Question.where.not(id: questions_id).sample
  questions_id << question.id
  answers.each do |answer|
    answer.question = question
    answer.save
  end
end

puts "Creation des spells"

6.times do
  Spell.create!(name: Faker::Games::Pokemon.move,
              image_url:'',
              description: Faker::Lorem.paragraph(sentence_count: 2))
end
