require 'rspec/core/rake_task'

task :default => :spec

desc "Run tests"
RSpec::Core::RakeTask.new do |s|
  s.rspec_opts = ["-c", "-f progress"]
end
