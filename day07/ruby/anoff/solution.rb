#!/usr/bin/ruby
require "open3"
DEBUG = false

def call_program(phase_setting, input, program_str)
  stdout, stderr, status = Open3.capture3("ruby computer.rb", :stdin_data=>"%s\nEOP\n%i\n%i" % [program_str, phase_setting, input])
  if DEBUG
    puts stdout
    puts stderr
  end
  output = stdout.split("\n")
    .select{|line| line.include?("Output:")}[-1] # last element
    .split(": ")[1].to_i
end
# phase_settings = Array 0..4
def test_phase_combination(phase_settings, program_str)
  output = 0
  for phase_setting in phase_settings
    output = call_program(phase_setting, output, program_str)
    if DEBUG
      puts "Intermediate output for phase setting: %d= %d" % [phase_setting, output]
    end
  end
  return output # integer
end
def is_unique_setting(phase_setting) # as array of ints
  str = phase_setting.map(&:to_s).join("")
  str.include?("4") && str.include?("3") && str.include?("2") && str.include?("1") && str.include?("0")
end
def part1(program_str)
  max_output = 0
  max_output_setting = nil
  for phase_setting in 0..43210
    # make sure that the array is zero-padded to 5 digits
    phase_setting_padded = phase_setting.to_s
    while phase_setting_padded.length < 5
      phase_setting_padded = "0" + phase_setting_padded
    end
    phase_setting = phase_setting_padded.split("").map(&:to_i)
    if is_unique_setting(phase_setting)
      output = test_phase_combination(phase_setting, program_str)
      puts "Output for setting %s = %d" % [phase_setting.to_s, output]
      if output > max_output
        max_output = output
        max_output_setting = phase_setting
      end
    end
  end
  # puts "Output: %s" % call_program(4, 0)
  max_output
end
if caller.length == 0
  input = File.read("./input.txt")
  puts "Solution for part1: %d" % part1(input)
end