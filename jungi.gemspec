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

Gem::Specification.new do |s|
  s.name = 'jungi'
  s.version = '0.0.3'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.authors = ['MFrogy Starmade']
  s.email = 'm27frogy.roblox@gmail.com'
  s.date = '2015-10-22'
  s.description = 'A simple program for taking open source personality tests.'
  s.summary = 'Added Spheres of Control Version 3.'
  s.homepage = 'https://github.com/m27frogy/JungI'
  s.license = 'GPL3'

  s.required_ruby_version = '>= 2.0.0'
  s.files = `find * -type f -print`.split($RS)
  s.files.each do |object|
    s.files.delete object if /.+\.gem/.match object
  end
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  # s.test_files = ["test/test_hola.rb"]
  s.require_paths = ['lib']
end
