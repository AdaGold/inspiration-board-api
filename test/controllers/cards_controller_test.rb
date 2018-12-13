require "test_helper"

describe CardsController do
  def check_not_found_response
    must_respond_with :not_found

    expect(response.header['Content-Type']).must_include 'json'
    body = JSON.parse(response.body)

    expect(body["ok"]).must_equal false
    expect(body).must_include "cause"
  end

  let (:board) {boards(:adas)}

  describe "index" do
    it "should get index" do
      # Act
      get board_cards_path(board.name)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'

    end

    it "responds with not_found if the board DNE" do
      board_name = "board_does_not_exist"
      expect(Board.find_by(name: board_name)).must_be_nil

      # Act
      get board_cards_path(board_name)

      # Assert
      check_not_found_response
    end
  end

  describe "show" do
    it "should get show" do
      # Arrange
      card = board.cards.first

      # Act
      get card_path(card.id)

      # Assert
      expect(response).must_be :successful?
    end

    it "will report when it can't find a card" do
      # Arrange
      card = board.cards.first
      card.destroy

      # Act
      get card_path(card.id)
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :not_found?
      expect(body["ok"]).must_equal false
      expect(body["cause"]).must_equal "not_found"
    end
  end

  describe "destroy" do
    it "can destroy a card" do
      # Arrange
      card = board.cards.first


      # Act
      delete card_path(card.id)
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "card"
      ["id", "text", "emoji"].each do |field|
        expect(body["card"].keys).must_include field
      end

    end

    it "will alert the user if the card to be deleted does not exist" do
      # Arrange
      card = board.cards.first
      card.destroy

      # Act
      delete card_path(card.id)
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :not_found?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "cause"
      expect(body["cause"]).must_equal "not_found"
    end

  end

  describe "create" do

    it "should get create" do
      # Arrange
      card = {
        text: "You are totally awesome",
        board_name: board.name
      }

      # Act
      post board_cards_path(board.name), params: card
      body = JSON.parse(response.body)

      value(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "card"
      ["id", "text", "emoji"].each do |field|
        expect(body["card"].keys).must_include field
        if (!card[field].nil?)
          expect(body["card"][field]).must_equal card[field.to_sym] if field != "id"
        end
      end
    end

    it "will respond with errors for invalid cards" do
      # Arrange
      card = {
      }
      expect(Card.new(card)).wont_be :valid?

      # Act
      post board_cards_path(board.name), params: card
      body = JSON.parse(response.body)

      value(response).must_be :bad_request?
      expect(response.header['Content-Type']).must_include 'json'
      ["ok", "cause", "errors"].each do |key|
        expect(body.keys).must_include key
      end

      expect(body["ok"]).must_equal false
      expect(body["cause"]).must_equal "validation errors"
      expect(body["errors"].keys).must_include "text"
      expect(body["errors"]["text"]).must_include "invalid text or missing emoji"
    end

    it "responds with not_found if the board DNE" do
      board_name = "board_does_not_exist"
      expect(Board.find_by(name: board_name)).must_be_nil

      card = {
        text: "You are totally awesome"
      }

      # Act
      post board_cards_path(board_name), params: card

      # Assert
      check_not_found_response
    end
  end

  describe "update" do

    it "can update a card" do
      # Arrange
      card = boards(:adas).cards.first
      card.text = "testing!"
      card_hash = card.as_json

      # Act
      patch card_path(card.id), params: card_hash
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "card"
      expect(body["card"].keys).must_include "id"
      expect(body["card"]["text"]).must_equal card.text
    end

    it "will report errors if it can't update a card" do
      # Arrange
      card = boards(:adas).cards.first
      card.text = ""
      card_hash = card.as_json

      # Act
      patch card_path(card.id), params: card_hash
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :bad_request?
      expect(response.header['Content-Type']).must_include 'json'
      ["ok", "cause", "errors"].each do |key|
        expect(body.keys).must_include key
      end

      expect(body["ok"]).must_equal false
      expect(body["cause"]).must_equal "validation errors"
      expect(body["errors"].keys).must_include "text"
      expect(body["errors"]["text"]).must_include "invalid text or missing emoji"
    end
  end

end
