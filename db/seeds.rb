UserGame.destroy_all
Spell.destroy_all

puts "Creation de l'avatar"
avatar = Avatar.new(avatar_url:"https://ca.slack-edge.com/T02NE0241-U01BRUL3UTY-1471cb9cc95e-512")
avatar.save

puts "Creation du user Bob Dylan le king"
user = User.new(username: "BobD", first_name:"Bob", last_name:"Dylan", email:"bob.dylan@gmail.com", password: "123456")
user.avatar = avatar
user.save

puts "Creation du bot de combat"
user = User.new(username: "BotC", first_name:"Bot", last_name:"Combat", email:"bot.combat@gmail.com", password: "123456")
user.avatar = avatar
user.save

puts "Création des catégories..."
CATEGORIES = %w[Géographie Divertissement Histoire Art\ &\ Littérature Sciences Sport]
categories = CATEGORIES.map { |name| Category.create!(name: name) }


puts "Création des questions et des réponses..."
questions_data = [
  {
    content: "Quelle est la capitale de la France ?",
    category: categories[0], # Géographie
    correct_answer: "Paris",
    wrong_answers: ["Lyon", "Marseille", "Nice"]
  },
  {
    content: "Qui a réalisé le film *Inception* ?",
    category: categories[1], # Divertissement
    correct_answer: "Christopher Nolan",
    wrong_answers: ["Steven Spielberg", "Quentin Tarantino", "James Cameron"]
  },
  {
    content: "En quelle année a eu lieu la Révolution française ?",
    category: categories[2], # Histoire
    correct_answer: "1789",
    wrong_answers: ["1776", "1804", "1848"]
  },
  {
    content: "Quel peintre est célèbre pour *La Nuit étoilée* ?",
    category: categories[3], # Art & Littérature
    correct_answer: "Vincent Van Gogh",
    wrong_answers: ["Claude Monet", "Pablo Picasso", "Salvador Dalí"]
  },
  {
    content: "Quelle planète est la plus proche du Soleil ?",
    category: categories[4], # Littérature Sciences Sport
    correct_answer: "Mercure",
    wrong_answers: ["Vénus", "Mars", "Jupiter"]
  }
]

questions_data.each do |data|
  question = Question.create!(
    content: data[:content],
    question_type: "text",
    media_url: "",
    category: data[:category]
  )

  # Ajouter la réponse correcte
  Answer.create!(content: data[:correct_answer], is_correct: true, question: question)

  # Ajouter les réponses incorrectes
  data[:wrong_answers].each do |wrong_answer|
    Answer.create!(content: wrong_answer, is_correct: false, question: question)
  end
end


9.times do |i|
  Spell.create!(name: Faker::Games::Pokemon.move,
              image_url: "img_#{i+1}.jpg",
              description: Faker::Lorem.paragraph(sentence_count: 2))
end

Game.create!

puts "Création des relations questions-jeux..."
games = Game.all
questions = Question.all

games.each do |game|
  questions.sample(5).each do |question| # Associe 5 questions aléatoires à chaque jeu
    question_pool = QuestionsPool.new
    question_pool.game = game
    question_pool.question = question
    question_pool.save
  end
end

puts "Données créées avec succès !"

user_game = UserGame.new
user_game.game = Game.first
user_game.user = User.first
user_game.spell = Spell.first
user_game.category = Category.first
user_game.save

user_game = UserGame.new
user_game.game = Game.first
user_game.user = User.second
user_game.spell = Spell.second
user_game.category = Category.second
user_game.save
