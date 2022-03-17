# frozen_string_literal: true

require_relative 'board'

# Class GameTurn to create a game  between codemaker and codebreaker
class GameTurn
  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
    puts "\nPlayer #{@codemaker.name} will make code:"
    @board = Board.new(@codemaker.choose_colors)
    puts "\nCode creates successfully" unless @board.answer.nil?
  end

  def guess_code
    loop do
      guess = @codebreaker.guess_colors(@board)
      return guess unless @board.check_exist(guess)

      puts 'This color combination has already existed. Please try again'
    end
  end

  def win_this_turn?
    12.times do
      puts "\n=== ATTEMPT #{@board.trials.size + 1}/12 ==="
      guess = guess_code
      @board.add_trial(guess)
      puts "\n**CURRENT BOARD:\n"
      @board.print_trials
      return true if @board.success?
    end
    false
  end

  def play_a_game
    puts "\nPlayer #{@codebreaker.name} will start guessing. You have 12 attempts. Let's start."
    if win_this_turn?
      @codebreaker.score += 1
      puts "== PLAYER #{@codebreaker.name.upcase} has SUCCEEDED cracking the code."
      true
    else
      @board.print_answer
      puts "==PLAYER #{@codebreaker.name.upcase} has FAILED to crack the code."
      false
    end
  end
end
