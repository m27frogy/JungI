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

# Global Question Module
module Question
  # Question Type Enum
  module Type
    YESORNO = :yn
    SCALE = :scale
    SCALE7 = :scale7
  end

  # Question Answer Module
  module Answer
    YES = :yes
    NO = :no

    # Check value for yes or no value
    def self.yes_or_no?(value)
      if value == Question::Answer::YES || value == Question::Answer::NO
        return true
      else
        return false
      end
    end

    # Check value for scale value
    def self.scale?(value)
      if (value.instance_of? Fixnum) && value.between?(1, 5)
        return true
      else
        return false
      end
    end

    # Reverse scale value
    def self.reverse_scale(value)
      unless Question::Answer.scale?(value)
        fail "#{type} is not a proper scale!"
      end
      [5, 4, 3, 2, 1].to_a[value - 1]
    end

    # Check value for scale7 value
    def self.scale7?(value)
      if (value.instance_of? Fixnum) && value.between?(1, 7)
        return true
      else
        return false
      end
    end

    # Reverse scale7 value
    def self.reverse_scale7(value)
      unless Question::Answer.scale7?(value)
        fail "#{type} is not a proper scale7!"
      end
      [7, 6, 5, 4, 3, 2, 1].to_a[value - 1]
    end

    # Checks value follows type
    def self.follows_type?(type, value)
      if type == Question::Type::YESORNO
        return Question::Answer.yes_or_no?(value)
      elsif type == Question::Type::SCALE
        return Question::Answer.scale?(value)
      elsif type == Question::Type::SCALE7
        return Question::Answer.scale7?(value)
      else
        fail "#{type} is an invalid question type!"
      end
    end
  end
end

# Basic Test Class
class Test
  # The test's questions plus the type of question they are
  QUESTIONS = [
    ['This is a standard question.', :yn],
    ['This is another question.', :scale]
  ]

  def initialize
    @answers = []
  end

  # Enable the use of self.Q<number> for easy implementation of tests
  def method_missing(name, *args)
    section = name[1..(name.length - 1)]
    if name[0] == 'Q' && self.out_of_index?(section.to_i - 1)
      return @answers[section.to_i - 1]
    else
      super
    end
  end

  # Check for out of index
  def out_of_index?(index, truism = false)
    if (index) > (self.class.const_get(:QUESTIONS).length - 1)
      if truism
        false
      else
        fail "##{index} Out of Index"
      end
    end
    true
  end

  # Get question via index
  def get_question(index)
    self.out_of_index? index
    self.class.const_get(:QUESTIONS)[index].dup
  end

  # Alias get_question
  def question(*args)
    get_question(*args)
  end

  # Set question answer to value
  def set_answer(index, value)
    self.out_of_index? index
    type = self.class.const_get(:QUESTIONS)[index][1]

    unless Question::Answer.follows_type?(type, value)
      fail "Type doesn't match with question type!"
    end
    @answers[index] = value
  end

  # Alias set_answer
  def answer(*args)
    set_answer(*args)
  end

  # Alias set_answer
  def answer=(args)
    set_answer(*args)
  end

  # Get a list of the answers so far
  def answers
    Marshal.load(Marshal.dump(@answers))
  end

  # Done supplying answers to questions?
  def finished?
    if @answers.length >= self.class.const_get(:QUESTIONS).length
      return true
    else
      return false
    end
  end

  # Alias finished?
  def done?
    self.finished?
  end

  # Stub method for result of test
  def result
    fail 'Not ready yet!' unless self.finished?
    @answers.to_s
  end
end

# Basic Scale5 Test Class
class ScaleTest < Test
  # Default scale questions
  QUESTIONS = ['very not dead|very dead', 'very not alive|very alive']

  # Set question answer to value
  def set_answer(index, value)
    self.out_of_index? index
    fail "#{value} is not a scale!" unless Question::Answer.scale?(value)
    @answers[index] = value
  end

  # Randomize the answers to a scale test
  def randomize!
    self.class.const_get(:QUESTIONS).length.times do |num|
      set_answer(num, rand(1..5))
    end
    nil
  end

  # Default results for scale test
  def result
    fail 'Not ready yet!' unless self.finished?
    val = @answers[1] - @answers[0]
    if val < 0
      "Sad to hear you're dead."
    elsif val > 0
      "Good to hear you're alive!"
    else
      "You're hard to figure out."
    end
  end
end

# Final Scale7 Test Class
class Scale7Test < ScaleTest
  # Set question answer to value
  def set_answer(index, value)
    self.out_of_index? index
    fail "#{value} is not a scale!" unless Question::Answer.scale7?(value)
    @answers[index] = value
  end

  # Randomize the answers to a scale test
  def randomize!
    self.class.const_get(:QUESTIONS).length.times do |num|
      set_answer(num, rand(1..7))
    end
    nil
  end
end
