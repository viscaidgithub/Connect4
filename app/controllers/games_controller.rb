class GamesController < ApplicationController
  before_action :set_game, only: [:show, :move, :reset]

  def index
    @games = Game.order(created_at: :desc).limit(20)
  end

  def create
    @game = Game.create
    redirect_to game_path(@game)
  end

  def show
  end

  # POST /games/:id/move (params[:col])
  def move
    col = params[:col].to_i
    if @game.drop_piece(col)
      flash[:notice] = "Piece dropped in column #{col + 1}."
    else
      flash[:alert] = "Invalid move (column full or game over)."
    end
    redirect_to game_path(@game)
  end

  def reset
    @game.reset!
    redirect_to game_path(@game)
  end

  def clear
    Game.delete_all
    redirect_to root_path, notice: 'History cleared.'
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
