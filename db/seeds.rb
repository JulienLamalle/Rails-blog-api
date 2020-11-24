require 'faker'

Faker::Config.locale = 'fr'

Article.destroy_all
Article.reset_pk_sequence
User.destroy_all
User.reset_pk_sequence

i = 0
j= 0

10.times do
  j+= 1
  user = User.create(
    email: Faker::Internet.email,
    password: 'Azerty'
  )
  puts "Nous avons pu créer l'user numéro #{j}"
end

30.times do 
  i+= 1
  article = Article.create(
    title: Faker::Sports::Football.team,
    content: Faker::TvShows::Simpsons.quote,
    user_id: rand(1..10)
  )
  puts "Nous avons pu créer l'article numéro #{i}"
end
