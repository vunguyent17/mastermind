# frozen_string_literal: true

require_relative 'config'

# Class Player to create new player
class Player
  include Config
  attr_accessor :score
  attr_reader :name

  def initialize
    @name = ''
    @score = 0
  end
end
