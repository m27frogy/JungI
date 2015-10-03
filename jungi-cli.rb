=begin
    JungI - A simple program for taking open source personality tests.
    Copyright (C) 2015  Mfrogy Starmade

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
=end

require "optparse"

$Randomize = false
require_relative "./classes"
require_relative "./oejts"
require_relative "./bigfive"

value = `tput cols`.chomp
if value.to_i then
	WIDTH = value.to_i
	if WIDTH < 80 then
		STDERR.puts "Shell is too small!  Shell minimum width must be 80 characters!"
		exit
	end
else
	WIDTH = 80
end

start = (" |1|2|3|4|5| ".center WIDTH)
Part1, Center, Part2 = start.partition(" |1|2|3|4|5| ")

def AskScale(str)
	list1,list2 = str.split("|")
	if list2 then
		partt1,partt2 = Part1.dup, Part2.dup
		partt1[Part1.length-(list1.length),Part1.length-1] = list1
		partt2[0,Part1.length-1] = list2
		puts partt1 + Center + partt2
	else
		puts((list1 + " |1|2|3|4|5| ").center WIDTH)
	end
	
	if not $Randomize then
		result = nil
		while not Question::Answer.scale? result do
			print "> "
			result = gets.chomp.to_i
		end
		return result
	else
		int = rand(1..5)
		puts "> #{int}"
		return int
	end
end

def PadDoc(doc)
	doc = doc.split("\n")
	out = []
	doc.length.times do |int|
		out[int] = doc[int].center WIDTH
	end
	return out
end

def DisplayDoc(doc)
	PadDoc(doc).each do |line|
		puts line
	end
end

def Line()
	WIDTH.times { print "-" }; print "\n"
end

def Clr()
	system "clear" or system "cls"
end

options = {}
ARGV.options do |opts|
	opts.banner = "Usage: jungi-cli [options]"
	
	opts.separator ""
	opts.separator "Tests:"
	opts.on("-j","Use OEJTS 1.2 test") do |v|
		options[:oejts] = true
	end
	opts.on("-b","Use IPIP Big Five Broad 50 test") do |v|
		options[:bigfivebroad50] = true
	end
	opts.on("-B","Use IPIP Big Five Broad 100 test") do |v|
		options[:bigfivebroad100] = true
	end
	opts.separator ""
	opts.separator "Modifiers:"
	opts.on("-r","--randomize","Automatically fills in random answers") do |v|
		$Randomize = true
	end
	opts.separator ""
	opts.separator "Common options:"
	opts.on_tail("-h","--help", "Display this help and exit")
	
	options[:helper] = opts.help
	
	opts.parse!
end

if options[:oejts] then
	currentTest = OEJTSTest.new
	Clr()
	DisplayDoc(OEJTSTest::DOC)
	Line()
	
	32.times do |int|
		puts "Question #{int+1}".center WIDTH
		currentTest.set_answer int,AskScale(currentTest.question int)
	end
	desig, iev, snv, ftv, jpv = currentTest.result

	puts("Test Complete".center WIDTH)
	puts("Designation".center WIDTH,"-")
	puts(desig.center WIDTH)
	Line()
	DisplayDoc(OEJTSTest.parse_variants(desig,iev,snv,ftv,jpv))
	Line()
elsif options[:bigfivebroad50] then
	currentTest = BigFiveBroad50Test.new
	Clr()
	DisplayDoc(BigFiveBroad50Test::DOC)
	Line()
	
	50.times do  |int|
		puts "Question #{int+1}".center WIDTH
		currentTest.set_answer int,AskScale(currentTest.question int)
	end
	extraversion, agreeableness, conscientiousness, emotional_stability, intellect = currentTest.result
	puts("Test Complete".center WIDTH)
	Line()
	DisplayDoc("Extraversion: #{extraversion} Agreeableness: #{agreeableness}\n" +
		"Conscientiousness: #{conscientiousness} Emotional Stability: #{emotional_stability}\n" +
		"Intellect: #{intellect}")
	Line()
elsif options[:bigfivebroad100] then
	currentTest = BigFiveBroad100Test.new
	Clr()
	DisplayDoc(BigFiveBroad100Test::DOC)
	Line()
	
	100.times do  |int|
		puts "Question #{int+1}".center WIDTH
		currentTest.set_answer int,AskScale(currentTest.question int)
	end
	extraversion, agreeableness, conscientiousness, emotional_stability, intellect = currentTest.result
	puts("Test Complete".center WIDTH)
	Line()
	DisplayDoc("Extraversion: #{extraversion} Agreeableness: #{agreeableness}\n" +
		"Conscientiousness: #{conscientiousness} Emotional Stability: #{emotional_stability}\n" +
		"Intellect: #{intellect}")
	Line()
else
	puts options[:helper]
end
