# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Board.create(name: 'Ada-Lovelace')

5.times do
  board = Board.new name: Faker::Hobbit.location
  board.save
end

cards = [
  {
    text: '100'
  },
  {
    text: 'BE EXCELLENT TO EACHOTHER'
  },
  {
    text: 'BREATHE'
  },
  {
    text: 'Look for the helpers'
  },
  {
    text: "Growth isn't linear"
  },
  {
    text: "This is just the beginning"
  },
  {
    text: "DON'T ISOLATE"
  },
  {
    text: "TAKE A NAP"
  },
  {
    text: "Make time for exercise!"
  },
  {
    text: "Be good to people for no reason"
  },
  {
    text: "It's ok to be in it for the money!  $$$"
  },
  {
    text: "you are enough"
  },
  {
    text: "We believe in you!"
  },
  {
    text: "You can do it!"
  },
  {
    emoji: Card.valid_emojis.sample
  },
  {
    emoji: Card.valid_emojis.sample
  },
  {
    emoji: Card.valid_emojis.sample
  }
]

cards.each do |card_hash|
  card = Card.new
  card_hash.keys.each do |key|
    card[key] = card_hash[key]
  end
  card.board = Board.all.sample
  card.save
end
