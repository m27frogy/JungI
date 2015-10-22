#!/usr/bin/env ruby

# Thanks, fhsjaagshs!

s = eval(File.read(Dir.glob("*.gemspec").first))
app_name = s.name
gem_name = "#{s.name}-#{s.version}.gem"

desc "Cleanup gem files"
task :clean do
	`[ -f #{gem_name} ] && rm #{gem_name}`
end

desc "Build gem"
task :build do
	puts "Building '#{app_name}'..."
	`gem build -q #{app_name}.gemspec`
end

desc "Install gem"
task :install do
	puts "Uninstalling currently installed '#{app_name}'..."
	`gem uninstall -q --force #{gem_name}`
	puts "Installing '#{app_name}'..."
	`gem install -q --ignore-dependencies --local #{gem_name}`
end

desc "Upload gem to rubyforge"
task :push do
	Rake::Task["clean"].invoke
	Rake::Task["build"].invoke
	puts "Pushing '#{app_name}' to rubygems..."
	exec("gem push #{gem_name}")
end

task :default do
	Rake::Task["build"].invoke
end
