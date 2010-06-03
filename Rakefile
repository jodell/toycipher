
require 'rake'
require 'rake/testtask'
require 'rake/gempackagetask'

$: << File.expand_path(File.dirname(__FILE__) + '/test')

task :default => :test 

desc 'Run all tests'
task :test => 'test:unit'

namespace :test do
  Rake::TestTask.new :unit do |t|
    t.libs << 'test'
    t.pattern = "test/tc_*.rb"
    t.verbose = true
  end

end

spec = Gem::Specification.new do |s| 
  s.name = "toycipher"
  s.version = "0.5" # FIXME
  s.author = "Jeffrey ODell"
  s.email = "jeffrey.odell@gmail.com"
  s.homepage = "http://github.com/jodell/toycipher"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby implementation of popular ciphers for recreational and educational cryptanalysis"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.autorequire = "name"
  s.test_files = FileList["{test}/**/tc_*.rb"].to_a
  s.has_rdoc = false
  #s.extra_rdoc_files = ["README"]
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end 

