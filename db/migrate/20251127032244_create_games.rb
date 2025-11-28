class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.text :board, default: ('[""]' * 42).gsub('""', '""') # set default properly in model to avoid DB literal quirks
      t.string :current_player, default: "R"   # R = Red, Y = Yellow
      t.string :status, default: "playing"     # "playing", "draw", "won"
      t.string :winner

      t.timestamps
    end
  end
end
