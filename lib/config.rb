# frozen_string_literal: true

# Module Config to set up game color
module Config
  COLORS = %w[0_red 1_blue 2_yellow 3_green 4_orange 5_purple].freeze

  def print_all_colors
    COLORS.each do |color|
      print "#{color}    "
    end
    print "\n"
  end
end
