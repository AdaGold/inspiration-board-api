class Board < ApplicationRecord

  has_many :cards, dependent: :destroy

  validates :name, presence: true, allow_blank: false
  validates :name, uniqueness: true

  def self.create_new_board name
    board = Board.new name: name

    template = Board.first

    Board.transaction do

      template.cards.each do |card|
        board.cards << (Card.create text: card.text, emoji: card.emoji)
      end

      board.save

    end

    return board
  end

end
