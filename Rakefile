begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "kamel"
    gemspec.summary = "Create KML files for tasty overlays on google earth and google maps"
    gemspec.description = "Create KML files for tasty overlays on google earth and google maps"
    gemspec.email = "contact@rhnh.net"
    gemspec.homepage = "http://github.com/xaviershay/lesstile"
    gemspec.authors = ["Xavier Shay"]
    gemspec.test_files = Dir["spec/**/*_spec.rb"]
    gemspec.add_dependency("schleyfox-ruby_kml", [">= 0.1.4"])
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'

Spec::Rake::SpecTask.new do |t|
  t.warning = false
  t.rcov = false
  t.spec_files = FileList['spec/**/*_spec.rb']
end

task :test    => :spec
task :default => :spec
