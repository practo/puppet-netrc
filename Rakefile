require 'rake'

task :test do
  system('augparse -I lib/augeas/lenses lib/augeas/lenses/tests/test_netrc.aug')
end

task :default => :test
