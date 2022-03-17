# frozen_string_literal: true

require_relative 'player'
# Class HumanPlayer to create player who manually choose color
class HumanPlayer < Player
  def initialize
    super
    print 'Your name is: '
    @name = gets.chomp
  end

  def choose_colors
    chosen_colors = Array.new(4)
    puts "Player #{@name} will choose 4 colors"
    print_all_colors
    (0..3).each do |num|
      print 'Input a number (0 -> 5) to choose color: '
      chosen_colors[num] = COLORS[gets.chomp.to_i]
    end
    chosen_colors
  end

  def guess_colors(_board)
    choose_colors
  end
end
