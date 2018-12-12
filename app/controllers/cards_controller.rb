class CardsController < ApplicationController
  before_action :require_board, only: [:index, :create]

  def index
    @cards = @board.cards
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
    @card = @board.cards.new(card_params)

    unless @card.save
      render json: {ok: false, cause: "validation errors", errors: @card.errors}, status: :bad_request
    end
  end

  def update
    @card = Card.find_by(id: params[:id])
    @card.update(card_params)

    if !@card.valid?
      render json: {ok: false, cause: "validation errors", errors: @card.errors}, status: :bad_request
    end
  end

  private
  def card_params
    return params.permit(:text, :emoji)
  end

  def require_board
    puts "in require board"
    @board = Board.find_by(name: params[:board_name])
    unless @board
      puts "board not found"
      render json: {ok: false, cause: "board #{params[:board_name]} does not exist"}, status: :not_found
    end
  end
end
