require "test_helper"

describe Card do
  # Arrange
  let(:card) { cards(:one) }

  it "must have a valid fixture" do

    # Assert
    expect(card).must_be :valid?
  end

  it "is invalid without text or emoji" do
    # Act
    card.text = nil
    card.emoji = nil

    # Assert
    expect(card.valid?).must_equal false
    expect(card.errors.keys).must_include :text
    expect(card.errors[:text]).must_include "invalid text or missing emoji"
  end

  it "is valid with an emoji alone" do
    card.text = nil
    VALID_EMOJIS = Card.valid_emojis

    VALID_EMOJIS.each do |emoji|
      card.emoji = emoji
      expect(card.valid?).must_equal true
    end
  end

  describe "relationships" do

    it "is not valid without a board" do
      # Act
      card.board = nil

      # Assert
      expect(card.valid?).must_equal false
    end

    it "can get the parent board" do
      # Assert
      expect(card.board).must_equal boards(:adas)
    end
  end
end
