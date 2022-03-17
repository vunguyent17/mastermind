# frozen_string_literal: true

require_relative 'player'
# Class ComputerPlayer to create player who automatically makke code and guess code
class ComputerPlayer < Player
  def initialize
    super
    @name = 'Computer'
  end

  def choose_colors
    chosen_colors = Array.new(4)
    (0..3).each do |num|
      chosen_colors[num] = COLORS[rand(4)]
    end
    chosen_colors
  end

  def choose_colors_from(set_data)
    chosen_colors = Array.new(4)
    count = 0
    loop do
      (0..3).each do |num|
        chosen_colors[num] = COLORS[rand(4)]
      end
      break if (chosen_colors & set_data.shift(2)).any? || (count += 1) > 100
    end
    chosen_colors
  end

  def guess_colors(board)
    if board.trials.empty?
      choose_colors
    else
      choose_colors_from(board.top_color_list)
    end
  end
end
