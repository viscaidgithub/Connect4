module ApplicationHelper
  def get_winner(winner)
    case winner
    when "R"
      "Red"
    when "Y"
      "Yellow"
    else
      ""
    end
  end
end
