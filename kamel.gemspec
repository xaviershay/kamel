Gem::Specification.new do |s|
  s.name = "kamel"
  s.version = "0.1"
  s.date = "2008-06-08"
  s.summary = "Create KML files for tasty overlays on google earth and google maps"
  s.email  = "xavier@rhnh.net"
  s.homepage = "http://github.com/xaviershay/kamel"
  s.description = "Create KML files for tasty overlays on google earth and google maps"
  s.has_rdoc = false
  s.authors = ["Xavier Shay"]
  s.files = ["LICENSE", "Rakefile", "README.textile"] + %w(lib spec).collect {|x| Dir["#{x}/**/*.rb"]}.flatten
  s.test_files = Dir["spec/**/*_spec.rb"]
  s.add_dependency("xaviershay-ruby_kml", ["> 0.0.0"])
end
