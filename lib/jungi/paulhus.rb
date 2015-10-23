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

# 	These tests were created by Delroy L. Paulhus for the public domain.
# 	For more information, see this page:
# 	<http://www2.psych.ubc.ca/~dpaulhus/Paulhus_measures/>

begin
  require_relative './classes'
rescue LoadError
  require 'jungi/classes'
end

# Short Dark Triad Test
class SD3Test < ScaleTest
  DOC = <<END_FILE
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
    'Whatever it takes, you must get the important people'\
    ' on your side.',
    'Avoid direct conflict with others because they may be'\
    ' useful in the future.',
    'I have never gotten into trouble with the law.',
    'People often say I’m out of control.',
    'I avoid dangerous situations.',
    'I like to get acquainted with important people.',
    'I feel embarrassed if someone compliments me.',
    'Many group activities tend to be dull without me.',
    'People see me as a natural leader.',
    'It’s wise to keep track of information that you can use'\
    ' against people later.',
    'I am an average person.',
    'There are things you should hide from other people because'\
    ' they don’t need to know.',
    'It’s true that I can be mean to others.',
    'I know that I am special because everyone keeps telling'\
    ' me so.',
    'I have been compared to famous people.',
    'I enjoy having sex with people I hardly know',
    'I’ll say anything to get what I want.',
    'I hate being the center of attention.',
    'I like to use clever manipulation to get my way.',
    'I like to get revenge on authorities.',
    'You should wait for the right time to get back at people.',
    'Make sure your plans benefit you, not others.',
    'Most people can be manipulated.',
    "It's not wise to tell your secrets.",
    'I insist on getting the respect I deserve.',
    'People who mess with me always regret it.',
    'Payback needs to be quick and nasty.'
  ]

  def self.parse_mach(mach)
    if mach < 1.5
      "Strong(#{mach}) Anti-Machivellianism\n"
    elsif mach < 3.1
      "Weak(#{mach}) Anti-Machivellianism\n"
    elsif mach < 4.3
      "Weak(#{mach}) Machivellianism\n"
    else
      "Strong(#{mach}) Machivellianism\n"
    end
  end

  def self.parse_narc(narc)
    if narc < 1.5
      "Strong(#{narc}) Anti-Narcissism\n"
    elsif narc < 2.8
      "Weak(#{narc}) Anti-Narcissism\n"
    elsif narc < 4
      "Weak(#{narc}) Narcissism\n"
    else
      "Strong(#{narc}) Narcissism\n"
    end
  end

  def self.parse_psycho(psycho)
    if psycho < 1.5
      "Strong(#{psycho}) Anti-Psychopathy\n"
    elsif psycho < 2.4
      "Weak(#{psycho}) Anti-Psychopathy\n"
    elsif psycho < 3
      "Weak(#{psycho}) Psychopathy\n"
    else
      "Strong(#{psycho}) Psychopathy\n"
    end
  end

  def self.parse_result(mach, narc, psycho)
    mach = (mach.round 1)
    narc = (narc.round 1)
    psycho = (psycho.round 1)
    parse_mach(mach) << parse_narc(narc) << parse_psycho(psycho)
  end

  def result
    mach = (self.Q24 + self.Q19 + self.Q1 + self.Q2 + self.Q10 +
           self.Q21 + self.Q12 + self.Q22 + self.Q23) / 9.0
    narc = (self.Q9 + Question::Answer.reverse_scale(self.Q18) +
           self.Q8 + self.Q14 + self.Q6 +
           Question::Answer.reverse_scale(self.Q7) +
           self.Q15 + Question::Answer.reverse_scale(self.Q11) + self.Q25) / 9.0
    psycho = (self.Q20 + Question::Answer.reverse_scale(self.Q5) +
           self.Q27 + self.Q4 + self.Q13 + self.Q26 +
           Question::Answer.reverse_scale(self.Q3) + self.Q16 + self.Q17) / 9.0
    [mach, narc, psycho]
  end
end

# Spheres of Control Version 3
class SOC3Test < Scale7Test
  DOC = <<END_FILE
Spheres of Control Version 3
-
Delroy L. Paulhus

This test evaluates how you perceive certain
spheres of control.  Answer each question with
a "1" for Completely Disagree, "2" for Strongly
Disagree, "3" for Disagree, "4" for Neither
Agree nor Disagree, "5" for Agree, "6" for
Strongly Disagree, and "7" for Completely Agree.
Press <ENTER> after you've made your choice.
END_FILE
  QUESTIONS = [
    'I can usually achieve what I want if I work hard for it.',
    "In my personal relationships, the other person usually has more\n"\
    'control than I do.',
    "By taking an active part in political and social affairs, we the\n"\
    ' people can influence world events.',
    'Once I make plans, I am almost certain to make them work.',
    'I have no trouble making and keeping friends.',
    'The average citizen can have an influence on government decisions.',
    'I prefer games involving some luck over games requiring pure skill.',
    'I\'m not good at guiding the course of a conversation with several'\
    ' others.',
    "It is difficult for us to have much control over the things\n"\
    'politicians do in office.',
    'I can learn almost anything if I set my mind to it.',
    "I can usually develop a personal relationship with someone I find\n"\
    'appealing.',
    "Bad economic conditions are caused by world events that are beyond\n"\
    'our control.',
    'My major accomplishments are entirely due to my hard work and ability.',
    'I can usually steer a conversation toward the topics I want to talk'\
    ' about.',
    'With enough effort we can wipe out political corruption.',
    "I usually do not set goals because I have a hard time following\n"\
    'through on them.',
    "When I need assistance with something, I often find it difficult to\n"\
    'get others to help.',
    "One of the major reasons we have wars is because people don\'t take\n"\
    'enough interest in politics.',
    'Bad luck has sometimes prevented me from achieving things.',
    'If there\'s someone I want to meet, I can usually arrange it.',
    "There is nothing we, as consumers, can do to keep the cost of living\n"\
    'from going higher.',
    'Almost anything is possible for me if I really want it.',
    'I often find it hard to get my point of view across to others.',
    'It is impossible to have any real influence over what big businesses do.',
    'Most of what happens in my career is beyond my control.',
    'In attempting to smooth over a disagreement, I sometimes make it worse.',
    "I prefer to concentrate my energy on other things rather than on\n"\
    'solving the world\'s problems.',
    "I find it pointless to keep working on something that\'s too diffic"\
    'ult for me.',
    'I find it easy to play an important part in most group situations.',
    "In the long run, we the voters are responsible for bad government\n"\
    'on a national as well as a local level.'
  ]

  def self.parse_pers(pers)
    "Personal Control #{pers}, "
  end

  def self.parse_inter(inter)
    "Interpersonal Control #{inter}, "
  end

  def self.parse_socio(socio)
    "Socio-Political Control #{socio}"
  end

  def self.parse_result(pers, inter, socio)
    pers = (pers.round 1)
    inter = (inter.round 1)
    socio = (socio.round 1)
    parse_pers(pers) << parse_inter(inter) << parse_socio(socio)
  end

  def result
    pers = (self.Q1 + self.Q4 + self.Q10 + self.Q13 +
           self.Q22 + Question::Answer.reverse_scale7(self.Q7) +
           Question::Answer.reverse_scale7(self.Q16) +
           Question::Answer.reverse_scale7(self.Q19) +
           Question::Answer.reverse_scale7(self.Q25) +
           Question::Answer.reverse_scale7(self.Q28)) / 10.0
    inter = (self.Q5 + self.Q11 + self.Q14 + self.Q20 +
            self.Q29 + Question::Answer.reverse_scale7(self.Q2) +
            Question::Answer.reverse_scale7(self.Q8) +
            Question::Answer.reverse_scale7(self.Q17) +
            Question::Answer.reverse_scale7(self.Q23) +
            Question::Answer.reverse_scale7(self.Q26)) / 10.0
    socio = (self.Q3 + self.Q6 + self.Q15 + self.Q18 +
            self.Q30 + Question::Answer.reverse_scale7(self.Q9) +
            Question::Answer.reverse_scale7(self.Q12) +
            Question::Answer.reverse_scale7(self.Q21) +
            Question::Answer.reverse_scale7(self.Q24) +
            Question::Answer.reverse_scale7(self.Q27)) / 10.0
    [pers, inter, socio]
  end
end
