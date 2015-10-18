#     JungI - A simple program for taking open source personality tests.
#     Copyright (C) 2015  Mfrogy Starmade
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'optparse'

$Randomize = false
require_relative './lib/classes'
require_relative './lib/tests/oejts'
require_relative './lib/tests/bigfive'
require_relative './lib/tests/paulhus'

value = `tput cols`.chomp
if value.to_i
  WIDTH = value.to_i
else
  WIDTH = 80
end

start = (' |1|2|3|4|5| '.center WIDTH)
PART1, CENTER, PART2 = start.partition(' |1|2|3|4|5| ')

def ask_scale(str)
  list1, list2 = str.split('|')
  if list2
    partt1 = PART1.dup
    partt2 = PART2.dup
    partt1[PART1.length - (list1.length), PART1.length - 1] = list1
    partt2[0, PART1.length - 1] = list2
    puts partt1 + CENTER + partt2
  else
    puts((list1 + ' |1|2|3|4|5| ').center WIDTH)
  end

  if !$Randomize
    result = nil
    until Question::Answer.scale? result
      print '> '
      result = gets.chomp.to_i
    end
    return result
  else
    int = rand(1..5)
    puts "> #{int}"
    return int
  end
end

def pad_doc(doc)
  doc = doc.split("\n")
  out = []
  doc.length.times do |int|
    out[int] = doc[int].center WIDTH
  end
  out
end

def display_doc(doc)
  pad_doc(doc).each do |line|
    puts line
  end
end

def line
  puts '-' * WIDTH
end

def clr
  system('clear') || system('cls')
end

options = {}
ARGV.options do |opts|
  opts.banner = 'Usage: jungi-cli [options]'

  opts.separator ''
  opts.separator 'Tests:'
  opts.on('-b', 'Use IPIP Big Five Broad 50 test') do |_v|
    options[:bigfivebroad50] = true
  end
  opts.on('-B', 'Use IPIP Big Five Broad 100 test') do |_v|
    options[:bigfivebroad100] = true
  end
  opts.on('-j', 'Use OEJTS 1.2 test') do |_v|
    options[:oejts] = true
  end
  opts.on('-s', "Use Delroy L. Paulhus' SD3") do |_v|
    options[:sd3test] = true
  end

  opts.separator ''
  opts.separator 'Modifiers:'
  opts.on('-r', '--randomize', 'Automatically fills in random answers') do |_v|
    $Randomize = true
  end
  opts.on('-S', '--shoes', 'Use the green_shoes gem to provide a GUI') do |_v|
    $Shoes = true
  end
  opts.separator ''
  opts.separator 'Common options:'
  opts.on_tail('-h', '--help', 'Display this help and exit')

  options[:helper] = opts.help

  opts.parse!
end
if $Shoes
  shoes_available = begin
    Gem::Specification.find_by_name('green_shoes')
  rescue Gem::LoadError
    false
  rescue
    Gem.available?('green_shoes')
  end

  if shoes_available
    require 'green_shoes'
  else
    STDERR.puts options[:helper] + "\n"
    STDERR.puts 'The -s/--shoes option requires the green_shoes gem'
    exit
  end
end
if WIDTH < 80
  STDERR.puts options[:helper] + "\n"
  STDERR.puts 'Minimum shell width is 80 characters'
  exit
end
tests = 0
tests += 1 if options[:bigfivebroad50]
tests += 1 if options[:bigfivebroad100]
tests += 1 if options[:oejts]
tests += 1 if options[:sd3test]

if tests > 1
  STDERR.puts options[:helper] + "\n"
  STDERR.puts 'Only use one test argument at a time'
  exit
end

if options[:oejts]
  current_test = OEJTSTest.new
  clr
  display_doc(OEJTSTest::DOC)
  line

  32.times do |int|
    puts "Question #{int + 1}".center WIDTH
    current_test.set_answer int, ask_scale(current_test.question int)
  end
  desig, iev, snv, ftv, jpv = current_test.result

  puts('Test Complete'.center WIDTH)
  puts('Designation'.center WIDTH, '-')
  puts(desig.center WIDTH)
  line
  display_doc(OEJTSTest.parse_result(desig, iev, snv, ftv, jpv))
  line
elsif options[:bigfivebroad50]
  current_test = BigFiveBroad50Test.new
  clr
  display_doc(BigFiveBroad50Test::DOC)
  line

  50.times do |count|
    puts "Question #{count + 1}".center WIDTH
    current_test.set_answer count, ask_scale(current_test.question count)
  end
  ex, agr, cons, emo, int = current_test.result
  puts('Test Complete'.center WIDTH)
  line
  display_doc("Extraversion: #{ex} Agreeableness: #{agr}\n" \
    "Conscientiousness: #{cons} Emotional Stability: #{emo}\n" \
    "Intellect: #{int}")
  line
elsif options[:bigfivebroad100]
  current_test = BigFiveBroad100Test.new
  clr
  display_doc(BigFiveBroad100Test::DOC)
  line

  100.times do |num|
    puts "Question #{num + 1}".center WIDTH
    current_test.set_answer num, ask_scale(current_test.question num)
  end
  ex, agr, cons, emo, int = current_test.result
  puts('Test Complete'.center WIDTH)
  line
  display_doc("Extraversion: #{ex} Agreeableness: #{agr}\n" \
    "Conscientiousness: #{cons} Emotional Stability: #{emo}\n" \
    "Intellect: #{int}")
  line
elsif options[:sd3test]
  current_test = SD3Test.new
  clr
  display_doc(SD3Test::DOC)
  line

  27.times do |count|
    puts "Question #{count + 1}".center WIDTH
    current_test.set_answer count, ask_scale(current_test.question count)
  end
  mach, narc, psycho = current_test.result
  puts('Test Complete'.center WIDTH)
  line
  display_doc(SD3Test.parse_result(mach, narc, psycho))
  line
else
  STDERR.puts options[:helper] + "\n"
  STDERR.puts 'You must specify a test type'
end
