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

# 	BigFive IPIP tests are sourced from  the following locations.
#
#
# 	Goldberg, L. R. (1999). A broad-bandwidth, public domain, personality
# 	inventory measuring the lower-level facets of several five-factor
# 	models. In I. Mervielde, I. Deary, F. De Fruyt, & F. Ostendorf (Eds.),
# 	Personality Psychology in Europe, Vol. 7 (pp. 7-28). Tilburg,
# 	The Netherlands: Tilburg University Press.
#
# 	Goldberg, L. R., Johnson, J. A., Eber, H. W., Hogan, R., Ashton,
# 	M. C., Cloninger, C. R., & Gough, H. C. (2006). The International
# 	Personality Item Pool and the future of public-domain personality
# 	measures. Journal of Research in Personality, 40, 84-96.
#
# 	International Personality Item Pool: A Scientific Collaboratory for
# 	the Development of Advanced Measures of Personality Traits and
# 	Other Individual Differences (http://ipip.ori.org/). Internet Web Site.

begin
  require_relative './classes'
rescue LoadError
  require 'jungi/classes'
end

# Implementation of BigFive Broad 50 Q
class BigFiveBroad50Test < ScaleTest
  DOC = <<END_FILE
IPIP Big Five Broad Domains
50 Question Version

Each question will be asking how well a specific trait
describes you.  For instance, if the trait is
"Start conversations" you should type in "1"
if you never start conversations, "2" if you rarely start
conversations, "3" if you sometimes do, "4" if you often
start them, and "5" if you start them all the time.
Press <ENTER> after you've made your choice.
END_FILE
  QUESTIONS = [
    'Am not really interested in others.',
    'Often forget to put things back in their proper place.',
    'Get irritated easily.',
    'Am the life of the party.',
    'Change my mood a lot.',
    'Often feel blue.',
    'Leave my belongings around.',
    'Am quick to understand things.',
    'Am exacting in my work.',
    'Am quiet around strangers.',
    'Have a vivid imagination.',
    "Feel others' emotions.",
    'Start conversations.',
    'Get upset easily.',
    'Am easily disturbed.',
    'Am full of ideas.',
    'Make a mess of things.',
    "Don't like to draw attention to myself.",
    'Take time out for others.',
    'Do not have a good imagination.',
    'Get stressed out easily.',
    'Have excellent ideas.',
    "Am not interested in other people's problems.",
    'Have frequent mood swings.',
    'Am interested in people.',
    'Get chores done right away.',
    'Talk to a lot of different people at parties.',
    'Worry about things.',
    'Feel comfortable around people.',
    'Have difficulty understanding abstract ideas.',
    "Don't mind being the center of attention.",
    'Feel little concern for others.',
    'Have a soft heart.',
    "Don't talk a lot.",
    'Spend time reflecting on things.',
    'Have a rich vocabulary.',
    'Am relaxed most of the time.',
    'Keep in the background.',
    'Shirk my duties.',
    'Like order.',
    'Pay attention to details.',
    'Insult people.',
    'Am not interested in abstract ideas.',
    'Make people feel at ease.',
    'Use difficult words.',
    'Follow a schedule.',
    'Have little to say.',
    'Am always prepared.',
    "Sympathize with others' feelings.",
    'Seldom feel blue.'
  ]

  def result
    fail 'Not ready yet!' unless self.finished?

    ex = self.Q4 + self.Q29 + self.Q13 + self.Q27 + self.Q31 +
         Question::Answer.reverse_scale(self.Q34) +
         Question::Answer.reverse_scale(self.Q38) +
         Question::Answer.reverse_scale(self.Q47) +
         Question::Answer.reverse_scale(self.Q18) +
         Question::Answer.reverse_scale(self.Q10)
    agr = self.Q25 + self.Q49 + self.Q33 + self.Q19 + self.Q12 +
          self.Q44 + Question::Answer.reverse_scale(self.Q1) +
          Question::Answer.reverse_scale(self.Q42) +
          Question::Answer.reverse_scale(self.Q23) +
          Question::Answer.reverse_scale(self.Q32)
    cons = self.Q48 + self.Q41 + self.Q26 + self.Q40 + self.Q46 +
           self.Q9 + Question::Answer.reverse_scale(self.Q7) +
           Question::Answer.reverse_scale(self.Q17) +
           Question::Answer.reverse_scale(self.Q2) +
           Question::Answer.reverse_scale(self.Q39)
    emo = self.Q37 + self.Q50 +
          Question::Answer.reverse_scale(self.Q21) +
          Question::Answer.reverse_scale(self.Q28) +
          Question::Answer.reverse_scale(self.Q15) -
          self.Q14 + Question::Answer.reverse_scale(self.Q5) +
          Question::Answer.reverse_scale(self.Q24) +
          Question::Answer.reverse_scale(self.Q3) +
          Question::Answer.reverse_scale(self.Q6)
    int = self.Q36 + self.Q11 + self.Q22 + self.Q8 + self.Q45 + self.Q35 +
          self.Q16 + Question::Answer.reverse_scale(self.Q30) +
          Question::Answer.reverse_scale(self.Q43) +
          Question::Answer.reverse_scale(self.Q20)

    [ex, agr, cons, emo, int]
  end
end

# Implementation of BigFive Broad 100 Q
class BigFiveBroad100Test < ScaleTest
  DOC = <<END_FILE
IPIP Big Five Broad Domains
100 Question Version

Each question will be asking how well a specific trait
describes you.  For instance, if the trait is
"Start conversations" you should type in "1"
if you never start conversations, "2" if you rarely start
conversations, "3" if you sometimes do, "4" if you often
start them, and "5" if you start them all the time.
Press <ENTER> after you've made your choice.
END_FILE
  QUESTIONS = [
    'Talk to a lot of different people at parties.',
    'Like to tidy up.',
    'Know how to captivate people.',
    'Change my mood a lot.',
    'Have little to say.',
    'Neglect my duties.',
    'Panic easily.',
    'Often forget to put things back in their proper place.',
    'Make friends easily.',
    'Start conversations.',
    'Follow a schedule.',
    'Am quiet around strangers.',
    'Leave a mess in my room.',
    'Have excellent ideas.',
    'Use difficult words.',
    'Try to avoid complex people.',
    'Catch on to things quickly.',
    'Feel at ease with people.',
    'Love to think up new ways of doing things.',
    'Am skilled in handling social situations.',
    'Often feel blue.',
    'Have a vivid imagination.',
    'Often feel uncomfortable around others.',
    'Insult people.',
    'Love order and regularity.',
    'Feel comfortable around people.',
    'Get irritated easily.',
    'Can handle a lot of information.',
    'Carry the conversation to a higher level.',
    'Grumble about things.',
    'Spend time reflecting on things.',
    'Waste my time.',
    'Do things in a half-way manner.',
    'Show my gratitude.',
    'Seldom get mad.',
    'Make plans and stick to them.',
    'Leave my belongings around.',
    'Have frequent mood swings.',
    'Have difficulty imagining things.',
    "Don't talk a lot.",
    'Love to read challenging material.',
    'Have a good word for everyone.',
    'Get upset easily.',
    'Love to help others.',
    'Feel threatened easily.',
    'Am exacting in my work.',
    'Am not really interested in others.',
    'Get stressed out easily.',
    'Will not probe deeply into a subject.',
    'Continue until everything is perfect.',
    'Am easily disturbed.',
    'Am not interested in abstract ideas.',
    'Am relaxed most of the time.',
    'Get caught up in my problems.',
    "Sympathize with others' feelings.",
    'Am on good terms with nearly everyone.',
    'Find it difficult to get down to work.',
    "Feel others' emotions.",
    "Am not interested in other people's problems.",
    'Do not have a good imagination.',
    'Am the life of the party.',
    'Like order.',
    'Make a mess of things.',
    'Get chores done right away.',
    'Feel little concern for others.',
    'Take offense easily.',
    'Get angry easily.',
    "Don't mind being the center of attention.",
    "Inquire about others' well-being.",
    'Am hard to get to know.',
    'Am interested in people.',
    'Am good at many things.',
    'Worry about things.',
    'Find it difficult to approach others.',
    'Am a very private person.',
    'Have a soft heart.',
    'Keep in the background.',
    'Love children.',
    'Am quick to understand things.',
    "Don't like to draw attention to myself.",
    'Avoid difficult reading material.',
    'Take charge.',
    'Think of others first.',
    'Make people feel at ease.',
    'Wait for others to lead the way.',
    'Know how to comfort others.',
    'Seldom feel blue.',
    'Bottle up my feelings.',
    'Am not easily bothered by things.',
    'Am full of ideas.',
    'Am indifferent to the feelings of others.',
    'Shirk my duties.',
    'Pay attention to details.',
    'Rarely get irritated.',
    'Get overwhelmed by emotions.',
    'Have difficulty understanding abstract ideas.',
    'Have a rich vocabulary.',
    'Am always prepared.',
    'Do things according to a plan.',
    'Take time out for others.'
  ]

  def result
    fail 'Not ready yet!' unless self.finished?

    ex = self.Q61 + self.Q26 + self.Q10 + self.Q1 +
         self.Q68 + self.Q9 + self.Q82 + self.Q3 +
         self.Q18 +
         Question::Answer.reverse_scale(self.Q20) +
         Question::Answer.reverse_scale(self.Q4) +
         Question::Answer.reverse_scale(self.Q77) +
         Question::Answer.reverse_scale(self.Q5) +
         Question::Answer.reverse_scale(self.Q80) +
         Question::Answer.reverse_scale(self.Q12) +
         Question::Answer.reverse_scale(self.Q74) +
         Question::Answer.reverse_scale(self.Q23) +
         Question::Answer.reverse_scale(self.Q88) +
         Question::Answer.reverse_scale(self.Q75) +
         Question::Answer.reverse_scale(self.Q85)
    agr = self.Q71 + self.Q55 + self.Q76 + self.Q100 +
          self.Q58 + self.Q84 + self.Q69 + self.Q86 +
          self.Q78 + self.Q56 + self.Q42 + self.Q34 +
          self.Q83 + self.Q44 +
          Question::Answer.reverse_scale(self.Q24) +
          Question::Answer.reverse_scale(self.Q59) +
          Question::Answer.reverse_scale(self.Q65) +
          Question::Answer.reverse_scale(self.Q47) +
          Question::Answer.reverse_scale(self.Q70) +
          Question::Answer.reverse_scale(self.Q91)
    cons = self.Q98 + self.Q93 + self.Q64 + self.Q62 +
           self.Q11 + self.Q46 + self.Q99 + self.Q50 +
           self.Q36 + self.Q25 + self.Q2 +
           Question::Answer.reverse_scale(self.Q37) +
           Question::Answer.reverse_scale(self.Q63) +
           Question::Answer.reverse_scale(self.Q8) +
           Question::Answer.reverse_scale(self.Q92) +
           Question::Answer.reverse_scale(self.Q6) +
           Question::Answer.reverse_scale(self.Q32) +
           Question::Answer.reverse_scale(self.Q33) +
           Question::Answer.reverse_scale(self.Q57) +
           Question::Answer.reverse_scale(self.Q13)
    emo = self.Q53 + self.Q87 + self.Q89 + self.Q94 +
          self.Q35 + Question::Answer.reverse_scale(self.Q48) +
          Question::Answer.reverse_scale(self.Q73) +
          Question::Answer.reverse_scale(self.Q51) +
          Question::Answer.reverse_scale(self.Q43) +
          Question::Answer.reverse_scale(self.Q4) +
          Question::Answer.reverse_scale(self.Q38) +
          Question::Answer.reverse_scale(self.Q27) +
          Question::Answer.reverse_scale(self.Q21) +
          Question::Answer.reverse_scale(self.Q67) +
          Question::Answer.reverse_scale(self.Q7) +
          Question::Answer.reverse_scale(self.Q45) +
          Question::Answer.reverse_scale(self.Q95) +
          Question::Answer.reverse_scale(self.Q66) +
          Question::Answer.reverse_scale(self.Q54) +
          Question::Answer.reverse_scale(self.Q30)
    int = self.Q97 + self.Q22 + self.Q14 + self.Q79 + self.Q15 +
          self.Q31 + self.Q90 + self.Q29 + self.Q17 + self.Q28 +
          self.Q19 + self.Q41 + self.Q72 +
          Question::Answer.reverse_scale(self.Q96) +
          Question::Answer.reverse_scale(self.Q52) +
          Question::Answer.reverse_scale(self.Q60) +
          Question::Answer.reverse_scale(self.Q16) +
          Question::Answer.reverse_scale(self.Q39) +
          Question::Answer.reverse_scale(self.Q81) +
          Question::Answer.reverse_scale(self.Q49)

    [ex, agr, cons, emo, int]
  end
end
