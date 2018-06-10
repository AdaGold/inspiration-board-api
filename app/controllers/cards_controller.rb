class CardsController < ApplicationController
  def index
    board = Board.find_by(name: params[:board_name])
    if board.nil?
      board = Board.create_new_board(params[:board_name])
    end

    if board
      @cards = board.cards
    else
      render json: {ok: false, cause: :not_found}, status: :not_found
    end
  end

  def show
    @card = Card.find_by(id: params[:id])
    render json: {ok: false, cause: :not_found}, status: :not_found if !@card

  end

  def destroy
    @card = Card.find_by(id: params[:id])

    if @card
      @card.destroy
    else
      render json: {ok: false, cause: :not_found}, status: :not_found if @board.nil?
    end
  end

  def create
    @card = Card.new(card_params)

    @card.board = Board.find_by(name: params[:board_name])
    if @card.board.nil?
      @card.board = Board.create_new_board params[:board_name]
    end

    @card.save

    if !@card.valid?
      render json: {ok: false, cause: "validation errors", errors: @card.errors}, status: :bad_request
    end
  end

  def update
    @card = Card.find_by(id: params[:id])
    @card.board = Board.find_by(name: params[:board_name])
    @card.update(card_params)

    if !@card.valid?
      render json: {ok: false, cause: "validation errors", errors: @card.errors}, status: :bad_request
    end
  end

  private
    def card_params
      return params.permit(:text, :emoji)
    end
end
