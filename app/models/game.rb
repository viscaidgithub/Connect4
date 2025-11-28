class Game < ApplicationRecord
  include Connect4::GameEngine

  attribute :board, :json, default: {}

  before_validation :ensure_board_and_defaults, on: :create

  validates :board, length: { is: Connect4::GameEngine::SIZE }
  validates :current_player, inclusion: { in: %w[R Y] }
  validates :status, inclusion: { in: %w[playing draw won] }
end