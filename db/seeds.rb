require "csv"

filepath = "db/questions.csv"

puts "Création des catégories..."
CATEGORIES = %w[Geography Entertainment History Art\ &\ Literature Sciences Sport]
categories = CATEGORIES.map { |name| Category.create!(name: name, image_url:"categories/#{name}.avif") }

CSV.foreach(filepath, headers: true) do |row|
  category = Category.find_by(name: row["Category"])
  if category
    question = Question.create!(
      content: row["Question"],
      category: category,
      question_type: "text",
      media_url: ""
    )
    Answer.create!(content: row["Answer"], is_correct: true, question: question)
    [row["Wrong Answer 1"], row["Wrong Answer 2"], row["Wrong Answer 3"]].each do |wrong_answer|
      Answer.create!(content: wrong_answer, is_correct: false, question: question)
    end
  end
end

puts "Les questions ont été ajoutées à la base de données !"

puts "Creation de l'avatar"
avatar = Avatar.new(avatar_url:"https://ca.slack-edge.com/T02NE0241-U01BRUL3UTY-1471cb9cc95e-512")
avatar.save

puts "Creation du user Bob Dylan le king"
user = User.new(username: "Hercule", first_name:"Bob", last_name:"Dylan", email:"bob.dylan@gmail.com", password: "123456")
user.avatar = avatar
user.save

puts "Creation du bot de combat"
user = User.new(username: "Gaia", first_name:"Bot", last_name:"Combat", email:"bot.combat@gmail.com", password: "123456")
user.avatar = avatar
user.save



# puts "Création des questions et des réponses..."
# questions_data = [
#   {
#     content: "Quelle est la capitale de la France ?",
#     category: categories[0], # Géographie
#     correct_answer: "Paris",
#     wrong_answers: ["Lyon", "Marseille", "Nice"]
#   },
#   {
#     content: "Qui a réalisé le film *Inception* ?",
#     category: categories[1], # Divertissement
#     correct_answer: "Christopher Nolan",
#     wrong_answers: ["Steven Spielberg", "Quentin Tarantino", "James Cameron"]
#   },
#   {
#     content: "En quelle année a eu lieu la Révolution française ?",
#     category: categories[2], # Histoire
#     correct_answer: "1789",
#     wrong_answers: ["1776", "1804", "1848"]
#   },
#   {
#     content: "Quel peintre est célèbre pour *La Nuit étoilée* ?",
#     category: categories[3], # Art & Littérature
#     correct_answer: "Vincent Van Gogh",
#     wrong_answers: ["Claude Monet", "Pablo Picasso", "Salvador Dalí"]
#   },
#   {
#     content: "Quelle planète est la plus proche du Soleil ?",
#     category: categories[4], # Littérature Sciences Sport
#     correct_answer: "Mercure",
#     wrong_answers: ["Vénus", "Mars", "Jupiter"]
#   }
# ]

# questions_data.each do |data|
#   question = Question.create!(
#     content: data[:content],
#     question_type: "text",
#     media_url: "",
#     category: data[:category]
#   )

#   Answer.create!(content: data[:correct_answer], is_correct: true, question: question)

#   data[:wrong_answers].each do |wrong_answer|
#     Answer.create!(content: wrong_answer, is_correct: false, question: question)
#   end
# end


# 9.times do |i|
#   Spell.create!(name: Faker::Games::Pokemon.move,
#               image_url: "img_#{i+1}.jpg",
#               description: Faker::Lorem.paragraph(sentence_count: 2))
# end
#
#
Spell.create!(name: "fifty-fifty",
image_url:"spells/fifty-fifty.webp",
description: "The system removes two incorrect answers, leaving one correct and one incorrect option.")

Spell.create!(name: "plus10sec",
image_url:"spells/plus10sec.webp",
description: "The player gains an additional 10 seconds to answer.")

Spell.create!(name: "minus10sec",
image_url:"spells/minus10sec.webp",
description: "The opponent’s response time is significantly shortened. (minus 10 sec)")

Spell.create!(name: "hidden-answer",
image_url:"spells/hidden-answer.webp",
description: "The opponent’s answers are masked, requiring them to hover over each one to reveal it.")

Spell.create!(name: "double-answer",
image_url:"spells/double-answer.webp",
description: "The player can select two answers instead of one to increase their chances.")

Spell.create!(name: "blury-answer",
image_url:"spells/blury-answer.webp",
description: "The opponent’s screen is partially blurred or glitched for a few seconds.")

Game.create!

puts "Création des relations questions-jeux..."
game = Game.first
questions = Question.all


questions.sample(5).each do |question| # Associe 5 questions aléatoires à chaque jeu
  question_pool = QuestionsPool.new
  question_pool.game = game
  question_pool.question = question
  question_pool.save
end


puts "Données créées avec succès !"

user_game = UserGame.new
user_game.game = Game.first
user_game.user = User.find(1)
user_game.spell = Spell.find(1)
user_game.category = Category.find(1)
user_game.save

user_game = UserGame.new
user_game.game = Game.first
user_game.user = User.find(2)
user_game.spell = Spell.find(2)
user_game.category = Category.find(2)
user_game.save
