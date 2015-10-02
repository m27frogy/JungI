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
require_relative "./classes"
require_relative "./oejts"
value = `tput cols`.chomp
if value.to_i then
	WIDTH = value.to_i
else
	WIDTH = 80
end

start = " |1|2|3|4|5| ".center WIDTH
Part1, Center, Part2 = start.partition(" |1|2|3|4|5| ")

def AskScale(str)
	partt1,partt2 = Part1.dup, Part2.dup
	list1,list2 = str.split("|")
	
	partt1[Part1.length-(list1.length),Part1.length-1] = list1
	partt2[0,Part1.length-1] = list2
	
	puts partt1 + Center + partt2
	result = nil
	while not Question::Answer.scale? result do
		print "> "
		result = gets.chomp.to_i
	end
	return result
end

def PadDoc(doc)
	doc = doc.split("\n")
	out = []
	doc.length.times do |int|
		out[int] = doc[int].center WIDTH
	end
	return out
end

def ParseVariants(desig,iev,snv,ftv,jpv)
	ending = ""
	
	if iev.between?(0,1) then
		if desig[0] == "E" then
			ending << "Lukewarm Extraversion, "
		else
			ending << "Lukewarm Intraversion, "
		end
	elsif iev < 4 then
		if desig[0] == "E" then
			ending << "Weak(#{iev}) Extraversion, "
		else
			ending << "Weak(#{iev}) Intraversion, "
		end
	else
		if desig[0] == "E" then
			ending << "Strong(#{iev}) Extraversion, "
		else
			ending << "Strong(#{iev}) Intraversion, "
		end
	end
	
	if snv.between?(0,1) then
		if desig[1] == "S" then
			ending << "Lukewarm Sensing\n"
		else
			ending << "Lukewarm Intuition\n"
		end
	elsif snv < 4 then
		if desig[1] == "S" then
			ending << "Weak(#{snv}) Sensing\n"
		else
			ending << "Weak(#{snv}) Intuition\n"
		end
	else
		if desig[1] == "S" then
			ending << "Strong(#{snv}) Sensing\n"
		else
			ending << "Strong(#{snv}) Intuition\n"
		end
	end
	
	if ftv.between?(0,1) then
		if desig[2] == "F" then
			ending << "Lukewarm Feeling, "
		else
			ending << "Lukewarm Thinking, "
		end
	elsif ftv < 4 then
		if desig[2] == "F" then
			ending << "Weak(#{ftv}) Feeling, "
		else
			ending << "Weak(#{ftv}) Thinking, "
		end
	else
		if desig[2] == "F" then
			ending << "Strong(#{ftv}) Feeling, "
		else
			ending << "Strong(#{ftv}) Thinking, "
		end
	end
	
	if jpv.between?(0,1) then
		if desig[3] == "J" then
			ending << "Lukewarm Judging"
		else
			ending << "Lukewarm Perceiving"
		end
	elsif jpv < 4 then
		if desig[3] == "J" then
			ending << "Weak(#{jpv}) Judging"
		else
			ending << "Weak(#{jpv}) Perceiving"
		end
	else
		if desig[3] == "J" then
			ending << "Strong(#{jpv}) Judging"
		else
			ending << "Strong(#{jpv}) Perceiving"
		end
	end
	
	return ending
end

options = {}
ARGV.options do |opts|
	opts.banner = "Usage: jungi-cli [options]"
	
	opts.on("-j","Use OEJTS 1.2 test") do |v|
		options[:oejts] = true
	end
	
	options[:helper] = opts.help
	
	opts.parse!
end

if options[:oejts] then
	currentTest = OEJTSTest.new
	system "clear" or system "cls"
	PadDoc(OEJTSTest::DOC).each do |line|
		puts line
	end
	WIDTH.times { print "-" }; print "\n"
	
	32.times do |int|
		puts "Question #{int+1}".center WIDTH
		currentTest.set_answer int,AskScale(currentTest.question int)
	end
	desig, iev, snv, ftv, jpv = currentTest.result

	puts("Test Complete".center WIDTH)
	puts("Designation".center WIDTH,"-")
	puts(desig.center WIDTH)
	WIDTH.times { print "-" }; print "\n"
	PadDoc(ParseVariants(desig,iev,snv,ftv,jpv)).each do |line|
		puts line
	end
	WIDTH.times { print "-" }; print "\n"
else
	puts options[:helper]
end
