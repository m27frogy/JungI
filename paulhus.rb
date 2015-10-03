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
	These tests were created by Delroy L. Paulhus for the public domain.
	For more information, see this page:
	<http://www2.psych.ubc.ca/~dpaulhus/Paulhus_measures/>
=end

class SD3Test < ScaleTest
	DOC =<<END_FILE
Short Dark Triad
-
Delroy L. Paulhus

This test evaluates how strongly you display the
dark triad of personality.  Answer each question with
a "1" for Strongly Disagree, "2" for Disagree,
"3" for Neither Agree nor Disagree, "4" for Agree,
and "5" for Strongly Agree.  Press <ENTER> after
you've made your choice.
END_FILE
	QUESTIONS = [
		"Whatever it takes, you must get the important people on your side.",
		"Avoid direct conflict with others because they may be useful in the future.",
		"I have never gotten into trouble with the law.",
		"People often say I’m out of control.",
		"I avoid dangerous situations.",
		"I like to get acquainted with important people.",
		"I feel embarrassed if someone compliments me.",
		"Many group activities tend to be dull without me.",
		"People see me as a natural leader.",
		"It’s wise to keep track of information that you can use against people later.",
		"I am an average person.",
		"There are things you should hide from other people because they don’t need to know.",
		"It’s true that I can be mean to others.",
		"I know that I am special because everyone keeps telling me so.",
		"I have been compared to famous people.",
		"I enjoy having sex with people I hardly know",
		"I’ll say anything to get what I want.",
		"I hate being the center of attention.",
		"I like to use clever manipulation to get my way.",
		"I like to get revenge on authorities.",
		"You should wait for the right time to get back at people.",
		"Make sure your plans benefit you, not others.",
		"Most people can be manipulated.",
		"It's not wise to tell your secrets.",
		"I insist on getting the respect I deserve.",
		"People who mess with me always regret it.",
		"Payback needs to be quick and nasty."
	]
	
	def self.parse_result(mach, narc, psycho)
		mach, narc, psycho = (mach.round 1),(narc.round 1), (psycho.round 1)
		out = ""
		if mach < 1.5 then
			out << "Strong(#{mach}) Anti-Machivellianism\n"
		elsif mach < 3.1 then
			out << "Weak(#{mach}) Anti-Machivellianism\n"
		elsif mach < 4.3 then
			out << "Weak(#{mach}) Machivellianism\n"
		else
			out << "Strong(#{mach}) Machivellianism\n"
		end
		
		if narc < 1.5 then
			out << "Strong(#{narc}) Anti-Narcissism\n"
		elsif narc < 2.8 then
			out << "Weak(#{narc}) Anti-Narcissism\n"
		elsif narc < 4 then
			out << "Weak(#{narc}) Narcissism\n"
		else
			out << "Strong(#{narc}) Narcissism\n"
		end
		
		if psycho < 1.5 then
			out << "Strong(#{psycho}) Anti-Psychopathy\n"
		elsif psycho < 2.4 then
			out << "Weak(#{psycho}) Anti-Psychopathy\n"
		elsif psycho < 3 then
			out << "Weak(#{psycho}) Psychopathy\n"
		else
			out << "Strong(#{psycho}) Psychopathy\n"
		end
		
		return out
	end
	
	def result()
		mach = (self.Q24 + self.Q19 + self.Q1 + self.Q2 + self.Q10 + 
			self.Q21 + self.Q12 + self.Q22 + self.Q23) / 9.0
		narc = (self.Q9 + Question::Answer.reverse_scale(self.Q18) + 
			self.Q8 + self.Q14 + self.Q6 + Question::Answer.reverse_scale(self.Q7) + self.Q15 + Question::Answer.reverse_scale(self.Q11) + self.Q25) / 9.0
		psycho = (self.Q20 + Question::Answer.reverse_scale(self.Q5) + 
			self.Q27 + self.Q4 + self.Q13 + self.Q26 + Question::Answer.reverse_scale(self.Q3) + self.Q16 + self.Q17) / 9.0
		return mach, narc, psycho
	end
end
