# frozen_string_literal: true

# Class Board to display and monitor games
class Board
  attr_reader :answer, :trials

  def initialize(answer)
    @answer = answer
    @trials = []
  end

  def print_trials
    @trials.each_with_index do |trial, index|
      print "Attempt #{index + 1}/12:   [   "
      trial[:colors].each do |color|
        print "#{color}   "
      end
      new_mark = index == @trials.size - 1 ? '<NEW>' : ''
      puts "]   Correct: #{trial[:correct]}   Wrong position: #{trial[:wrong_position]}   #{new_mark}"
    end
    puts 'Press any key to continue...'
    gets.chomp
  end

  def evaluate(trial)
    result = { correct: 0, wrong_position: 0 }
    count_trial = Hash.new(0)
    trial.each_with_index do |color, index|
      count_trial[color] += 1
      if @answer[index] == color
        result[:correct] += 1
      elsif @answer.include?(color) && count_trial[color] <= @answer.count(color)
        result[:wrong_position] += 1
      end
    end
    result
  end

  def top_color_list
    sorted_trials = @trials.sort_by { |trial| trial[:correct] + trial[:wrong_position] }
    colors_score = Hash.new(0)
    sorted_trials.each_with_index do |trial, score|
      trial[:colors].each do |color|
        colors_score[color] += (score + 1)
      end
    end
    colors_score.sort_by(&:last).reverse.map { |value| value[0].to_s }
  end

  def print_answer
    print 'CODE: ['
    @answer.each do |color|
      print "   #{color}   "
    end
    puts ']'
  end

  def check_exist(new_trial)
    @trials.each do |trial|
      is_repeated = true
      trial[:colors].each_with_index do |color, index|
        if color != new_trial[index]
          is_repeated = false
          break
        end
      end
      return true if is_repeated == true
    end
    false
  end

  def add_trial(new_trial)
    evaluated_trial = { colors: new_trial }.merge(evaluate(new_trial))
    @trials.push(evaluated_trial)
  end

  def success?
    result = @trials[-1]
    return true if result[:correct] == 4

    false
  end
end
