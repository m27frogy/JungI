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

=begin
	The items of the Open Extended Jungian Type Scales 1.2 are licenced
	under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0
	International License by Eric Jorgenson. The OEJTS comes with no
	guarantees of reliability or accuracy of any kind.
	
	https://creativecommons.org/licenses/by-nc-sa/4.0/
=end

require_relative "./classes"

class OEJTSTest < ScaleTest
	DOC = <<END_FILE
Open Extended Jungian Type Scales 1.2

In this test there are 32 pairs of personality descriptions
connected by a five point scale. For each pair, you must
choose where on the scale between them you think you are.
For example, if the pair is "angry” versus “calm”,
you should type in a 1 if you are always angry and never
calm, a 3 if you are half and half, etc.  Press <ENTER>
after typing your answer.  Answer honestly and as you are,
not as you hope to be.
END_FILE
	QUESTIONS = [
		"makes lists|relies on memory",
		"sceptical|wants to believe",
		"bored by time alone|needs time alone",
		"accepts things as they are|unsatisfied with the way things are",
		"keeps a clean room|just puts stuff where ever",
		"thinks \"robotic\" is an insult|strives to have a mechanical mind",
		"energetic|mellow",
		"prefer to take multiple choice test|prefer essay answers",
		"chaotic|organized",
		"easily hurt|thick-skinned",
		"works best in groups|works best alone",
		"focused on the past|focused on the future",
		"plans far ahead|plans at the last minute",
		"wants people's respect|wants their love",
		"gets worn out by parties|gets fired up by parties",
		"fits in|stands out",
		"keeps options open|commits",
		"wants to be good at fixing things|wants to be good at fixing people",
		"talks more|listens more",
		"when describing an event, will tell people what happened|when describing an event, will tell people what it meant",
		"gets work done right away|procrastinates",
		"follows the heart|follows the head",
		"stays at home|goest out on the town",
		"wants the big picture|wants the details",
		"improvises|prepares",
		"bases morality on justice|bases morality on compassion",
		"finds it difficult to yell very loudly|yelling to others when they are far away comes naturally",
		"theoretical|empirical",
		"works hard|plays hard",
		"uncomfortable with emotions|values emotions",
		"likes to perform in front of other people|avoids public speaking",
		"likes to know \"who?\", \"what?\", \"when?\"|likes to know \"why?\""
	]
	
	def method_missing(name,*args)
		if (name.length == 2 or name.length == 3) and name[0] == "Q" and name[1,name.length-1].to_i >= 1 and name[1,name.length-1].to_i <= self.class.const_get(:QUESTIONS).length then
			return @answers[name[1,name.length-1].to_i-1]
		else
			super
		end
	end
	
	def randomize!()
		32.times do |num|
			self.set_answer(num,rand(1..5))
		end
		nil
	end
	
	def result()
		raise "Not ready yet!" if not self.finished?
		ie = 30 - self.Q3 - self.Q7 - self.Q11 + self.Q15 - self.Q19 + self.Q23 + self.Q27 - self.Q31
		sn = 12 + self.Q4 + self.Q8 + self.Q12 + self.Q16 + self.Q20 - self.Q24 - self.Q28 + self.Q32
		ft = 30 - self.Q2 + self.Q6 + self.Q10 - self.Q14 - self.Q18 + self.Q22 - self.Q26 - self.Q30
		jp = 18 + self.Q1 + self.Q5 - self.Q9  + self.Q13 - self.Q17 + self.Q21 - self.Q25 + self.Q29
		desig = ""
		
		if ie > 24 then
			desig << "E"
		else
			desig << "I"
		end
		if sn > 24 then
			desig << "N"
		else
			desig << "S"
		end
		if ft > 24 then
			desig << "T"
		else
			desig << "F"
		end
		if jp > 24 then
			desig << "P"
		else
			desig << "J"
		end
		
		iev = (ie - 24).abs
		snv = (sn - 24).abs
		ftv = (ft - 24).abs
		jpv = (jp - 24).abs
		
		return desig, iev, snv, ftv, jpv
	end
end
