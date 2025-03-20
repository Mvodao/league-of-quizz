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
