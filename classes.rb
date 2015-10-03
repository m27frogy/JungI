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

module Question
	module Type
		YESORNO = :yn
		SCALE = :scale
	end
	module Answer
		YES = :yes
		NO = :no
		
		def self.yes_or_no?(value)
			if value == Question::Answer::YES or value == Question::Answer::NO then
				return true
			else
				return false
			end
		end
		
		def self.scale?(value)
			if value == 1 or value == 2 or value == 3 or value == 4 or value == 5 then
				return true
			else
				return false
			end
		end
		
		def self.follows_type?(type,value)
			if type == Question::Type::YESORNO then
				return Question::Answer.yes_or_no?(value)
			elsif type == Question::Type::SCALE then
				return Question::Answer.scale?(value)
			else
				raise "#{type} is an invalid question type!"
			end
		end
	end
end

class Test
	QUESTIONS = [["This is a standard question.",:yn],["This is another question.",:scale]]
	
	def initialize()
		@answers = []
	end
	
	def out_of_index?(index)
		raise "##{index} Out of Index" if index > self.class.const_get(:QUESTIONS).length - 1
	end

	def get_question(index)
		self.out_of_index? index
		self.class.const_get(:QUESTIONS)[index].dup
	end
	
	def question(*args)
		self.get_question(*args)
	end
	
	def set_answer(index,value)
		self.out_of_index? index
		raise "Type doesn't match with question type!" if not Question::Answer.follows_type?(self.class.const_get(:QUESTIONS)[index][1],value)
		@answers[index] = value
	end
	
	def answer(*args)
		self.set_answer(*args)
	end
	
	def answer=(args)
		self.set_answer(*args)
	end
	
	def answers()
		Marshal.load(Marshal.dump(@answers))
	end
	
	def finished?()
		if @answers.length >= self.class.const_get(:QUESTIONS).length then
			return true
		else
			return false
		end
	end
	
	def done?()
		self.finished?()
	end
	
	def result()
		raise "Not ready yet!" if not self.finished?
		return @answers.to_s
	end
end

class ScaleTest < Test
	QUESTIONS = ["very not dead|very dead", "very not alive|very alive"]
	
	def set_answer(index, value)
		self.out_of_index? index
		raise "#{value} is not a scale!" if not Question::Answer.scale?(value)
		@answers[index] = value
	end
	
	def randomize!()
		self.class.const_get(:QUESTIONS).length.times do |num|
			self.set_answer(num,rand(1..5))
		end
		nil
	end
	
	def method_missing(name,*args)
		if name[0] == "Q" and (name.length == 2 or name.length == 3 or name.length == 4) and name[1,name.length-1].to_i >= 1 and name[1,name.length-1].to_i <= self.class.const_get(:QUESTIONS).length then
			return @answers[name[1,name.length-1].to_i-1]
		else
			super
		end
	end
	
	def result()
		raise "Not ready yet!" if not self.finished?
		val = @answers[1] - @answers[0]
		if val < 0 then
			"Sad to hear you're dead."
		elsif val > 0 then
			"Good to hear you're alive!"
		else
			"You're hard to figure out."
		end
	end
end
