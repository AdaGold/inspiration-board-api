class BoardsController < ApplicationController

  def homepage
    render json: {
      message: 'Welcome to Ada\'s inspiration board',
      routes: [
        {
          method: 'get',
          path: '/boards'
        },
        {
          method: 'get',
          path: '/boards/:board_name'
        },
        {
          method: 'post',
          path: '/boards'
        },
        {
          method: 'patch',
          path: '/boards/:board_name'
        },
        {
          method: 'delete',
          path: '/boards/:board_name'
        },
        {
          method: 'get',
          path: '/boards/:board_name/cards'
        },
        {
          method: 'get',
          path: '/boards/:board_name/cards/:id'
        },
        {
          method: 'post',
          path: '/boards/:board_name/cards'
        },
        {
          method: 'patch',
          path: '/boards/:board_name/cards/:id'
        },
        {
          method: 'delete',
          path: '/boards/:board_name/cards/:id'
        }
      ]
    }
  end

  def index
    @boards = Board.order(:name)
  end

  def show
    @board = Board.find_by(name: params[:name])
    if @board.nil? && params[:name].present?
      @board = Board.create_new_board(params[:name])
    end

    render json: {ok: false, cause: :bad_request}, status: :bad_request if @board.nil?
  end

  def destroy
    @board = Board.find_by(name: params[:name])

    if @board
      @board.destroy_board
    else
      render json: {ok: false, cause: :not_found}, status: :not_found if @board.nil?
    end
  end

  def create
    @board = Board.create_new_board(board_params[:name])

    if !@board.valid?
      render json: {ok: false, cause: "validation errors", errors: @board.errors}, status: :bad_request
    end
  end

  private
    def board_params
      return params.permit(:name)
    end
end
