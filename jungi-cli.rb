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
require_relative './lib/classes'
require_relative './lib/tests/oejts'
require_relative './lib/tests/bigfive'
require_relative './lib/tests/paulhus'
require_relative './lib/cli.rb'

WIDTH = JungiCli.width

options = {}
ARGV.options do |opts|
  opts.banner = 'Usage: jungi-cli [options]'
  opts.separator 'This test has Mad Cow Powers' if Process.uid == 0
  opts.separator ''
  opts.separator 'Tests:'
  opts.on('-b', '--big', 'Use IPIP Big Five Broad 50 test') do |_v|
    options[:bigfivebroad50] = true
  end
  opts.on('-B', '--bigger', 'Use IPIP Big Five Broad 100 test') do |_v|
    options[:bigfivebroad100] = true
  end
  opts.on('-j', '--jungian', 'Use OEJTS 1.2 test') do |_v|
    options[:oejts] = true
  end
  opts.on('-t', '--triad', "Use Delroy L. Paulhus' SD3") do |_v|
    options[:sd3test] = true
  end

  opts.separator ''
  opts.separator 'Modifiers:'
  opts.on('-r', '--randomize', 'Automatically fills in random answers') do |_v|
    options[:randomize] = true
  end
  opts.on('-s', '--shoes', 'Use the green_shoes gem to provide a GUI') do |_v|
    options[:shoes] = true
  end
  opts.separator ''
  opts.separator 'Common options:'
  opts.on_tail('-h', '--help', 'Display this help and exit')

  options[:helper] = opts.help

  opts.parse!
end
if options[:shoes]
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
  STDERR.puts "Minimum shell width is 80 characters (#{WIDTH})"
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
  JungiCli.clr
  JungiCli.display_doc(OEJTSTest::DOC)
  JungiCli.line

  32.times do |int|
    puts "Question #{int + 1}".center WIDTH
    s = JungiCli.ask_scale((current_test.question int), options[:randomize])
    current_test.set_answer int, s
  end
  desig, iev, snv, ftv, jpv = current_test.result

  puts('Test Complete'.center WIDTH)
  puts('Designation'.center WIDTH, '-')
  puts(desig.center WIDTH)
  JungiCli.line
  JungiCli.display_doc(OEJTSTest.parse_result(desig, iev, snv, ftv, jpv))
  JungiCli.line
elsif options[:bigfivebroad50]
  current_test = BigFiveBroad50Test.new
  JungiCli.clr
  JungiCli.display_doc(BigFiveBroad50Test::DOC)
  JungiCli.line

  50.times do |c|
    puts "Question #{c + 1}".center WIDTH
    s = JungiCli.ask_scale((current_test.question c), options[:randomize])
    current_test.set_answer c, s
  end
  ex, agr, cons, emo, int = current_test.result
  puts('Test Complete'.center WIDTH)
  JungiCli.line
  JungiCli.display_doc("Extraversion: #{ex} Agreeableness: #{agr}\n" \
    "Conscientiousness: #{cons} Emotional Stability: #{emo}\n" \
    "Intellect: #{int}")
  JungiCli.line
elsif options[:bigfivebroad100]
  current_test = BigFiveBroad100Test.new
  JungiCli.clr
  JungiCli.display_doc(BigFiveBroad100Test::DOC)
  JungiCli.line

  100.times do |num|
    puts "Question #{num + 1}".center WIDTH
    s = JungiCli.ask_scale((current_test.question num), options[:randomize])
    current_test.set_answer num, s
  end
  ex, agr, cons, emo, int = current_test.result
  puts('Test Complete'.center WIDTH)
  JungiCli.line
  JungiCli.display_doc("Extraversion: #{ex} Agreeableness: #{agr}\n" \
    "Conscientiousness: #{cons} Emotional Stability: #{emo}\n" \
    "Intellect: #{int}")
  JungiCli.line
elsif options[:sd3test]
  current_test = SD3Test.new
  JungiCli.clr
  JungiCli.display_doc(SD3Test::DOC)
  JungiCli.line

  27.times do |c|
    puts "Question #{c + 1}".center WIDTH
    s = JungiCli.ask_scale((current_test.question c), options[:randomize])
    current_test.set_answer c, s
  end
  mach, narc, psycho = current_test.result
  puts('Test Complete'.center WIDTH)
  JungiCli.line
  JungiCli.display_doc(SD3Test.parse_result(mach, narc, psycho))
  JungiCli.line
else
  STDERR.puts options[:helper] + "\n"
  STDERR.puts 'You must specify a test type'
end
