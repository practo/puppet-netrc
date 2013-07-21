require 'rake'

require 'rspec/core/rake_task'

task :test do
  system('augparse -I lib/augeas/lenses lib/augeas/lenses/tests/test_netrc.aug')
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/*/*_spec.rb'
end

task :default => [:test, :spec]
