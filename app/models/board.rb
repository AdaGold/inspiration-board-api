class Board < ApplicationRecord

  CARDS = [
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

  has_many :cards, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :name, uniqueness: true

  def self.create_new_board name
    board = Board.new name: name

    Board.transaction do
      cards = CARDS.each do |card_fields|
        board.cards << Card.create(card_fields)
      end

      board.save
    end

    return board
  end

end
