# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'
require_relative 'game_turn'

# Class MastermindGame to create game from start to the end
class MastermindGame
  def initialize
    puts 'Create player 1:'
    @player1 = create_player
    puts 'Create player 2:'
    @player2 = create_player
    @game_log = []
  end

  def create_player
    print 'Choose 0_Human or 1_Computer: '
    choice = gets.chomp.to_i
    case choice
    when 0
      HumanPlayer.new
    when 1
      ComputerPlayer.new
    end
  end

  def run_mode(codemaker, codebreaker)
    puts "Player #{codemaker.name} is codemaker. Player #{codebreaker.name} is codebreaker"
    info = { codemaker: codemaker.name, codebreaker: codebreaker.name }
    info[:succeed] = GameTurn.new(codemaker, codebreaker).play_a_game
    @game_log.push(info)
    print_score
  end

  def choose_mode
    print "Player #{@player1.name} is 0_codemaker or 1_codebreaker? (0/1): "
    choice = gets.chomp.to_i
    case choice
    when 0
      run_mode(@player1, @player2)
    when 1
      run_mode(@player2, @player1)
    end
  end

  def print_score
    puts "Player #{@player1.name} : #{@player1.score} - #{@player2.score} : #{@player2.name}"
  end

  def print_game_stat
    print_score
    @game_log.each_with_index do |info, index|
      print "Match #{index + 1}:\t"
      puts info
    end
  end

  def run_game
    loop do
      choose_mode
      print 'Do you want to continue? (y/n): '
      choice = gets.chomp
      break if choice == 'n'
    end
    puts "\n=== FINAL SCORE ==="
    print_game_stat
    puts '=== Thank you for playing :D ==='
  end
end
