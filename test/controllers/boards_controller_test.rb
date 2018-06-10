require "test_helper"

describe BoardsController do

  describe "index" do
    before do
      # Act
      get boards_path
    end
    it "should get index" do
      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
    end

    it "should return all the boards lexicographical in order" do
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_kind_of Array
      expect(body.length).must_equal 2

      previous = nil

      body.each do |board|
        if previous
          expect(previous[:name] <=> board[:name]).must_be :<=, 0
        end
        previous = board
      end
    end
  end

  describe "show" do
    it "can retrieve a valid board" do
      # Act
      get board_path(boards(:adas).name)

      # Assert
      expect(response).must_be :successful?
    end

    it "responds by creating a board if the board name isn't in the DB" do
      # Act
      get board_path('new-board')
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(Board.find_by(name: 'new-board')).wont_be_nil
    end
  end

  describe "create" do
    it "Can create a valid board" do
      # Arrange
      board = {name: "Billy Joe Bobs"}

      # Act
      post boards_path params: board
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "board"
      expect(body["board"].keys).must_include "id"
    end

    it "will give an error message when given an invalid board" do
      # Arrange
      board = {}

      # Act
      post boards_path params: board
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :bad_request?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "cause"
      expect(body["cause"]).must_equal "validation errors"
      expect(body["errors"].keys).must_include "name"
      expect(body["errors"]["name"]).must_include "can't be blank"
    end

    it "will give an error message when given an duplicate board name" do
      # Arrange
      board = {name: "Babbage's Mechanical Wonder!"}

      # Act
      post boards_path params: board
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :bad_request?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "cause"
      expect(body["cause"]).must_equal "validation errors"
      expect(body["errors"].keys).must_include "name"
      expect(body["errors"]["name"]).must_include "has already been taken"
    end
  end

  describe "destroy" do
    it "will delete an existing board" do
      # Arrange
      adas = boards(:adas)

      # Act
      delete board_path(adas.name)
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :successful?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys).must_include "board"
      expect(body["board"].keys).must_include "id"

      expect(Board.find_by(id: adas.id)).must_be_nil
    end

    it "will inform us if the board to be deleted doesn't exist" do
      # Arrange
      adas = boards(:adas)
      adas.destroy_board

      # Act
      delete board_path(adas)
      body = JSON.parse(response.body)

      # Assert
      expect(response).must_be :not_found?
      expect(response.header['Content-Type']).must_include 'json'
      expect(body["ok"]).must_equal false
      expect(body["cause"]).must_equal "not_found"
    end
  end

end
