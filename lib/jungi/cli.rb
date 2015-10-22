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

begin
  require_relative './classes'
rescue LoadError
  require 'jungi/classes'
end

# JungiCli utility module
module JungiCli
  # Fetch terminal width
  def self.width
    val = `tput cols`.chomp.to_i
    val = 80 if val == 0
    val
  rescue Errno::ENOENT
    80
  end

  # Fetch prototype objects
  def self.scale_proto
    start = (' |1|2|3|4|5| '.center width)
    start.partition(' |1|2|3|4|5| ')
  end

  # Handle question via scale
  def self.parse_scale(scale)
    p1, p2 = scale.split '|'
    if p2
      s1, c1, s2 = scale_proto
      s1[s1.length - p1.length, s1.length - 1] = p1
      s2[0, p2.length - 1] = p2
      s1 + c1 + s2
    else
      (p1 + ' |1|2|3|4|5| ').center WIDTH
    end
  end

  # Ask for integer
  def self.ask_integer(prompt)
    result = nil
    until yield result
      print prompt
      result = gets.chomp.to_i
    end
    result
  end

  # Nicely ask a scale
  def self.ask_scale(scale, randomize = false)
    puts parse_scale scale

    if randomize
      int = rand(1..5)
      puts "> #{int}"
      int

    else
      ask_integer '> ' do |r|
        Question::Answer.scale? r
      end
    end
  end

  # Pad a document to width
  def self.center_doc(doc)
    doc = doc.split "\n"
    out = []
    doc.length.times do |int|
      out[int] = doc[int].center width
    end
    out
  end

  # Display document centered
  def self.display_doc(doc)
    center_doc(doc).each do |line|
      puts line
    end
  end

  # Render line
  def self.line
    puts '-' * width
  end

  # Clear screen
  def self.clr
    system('clear') || system('cls')
  end
end
