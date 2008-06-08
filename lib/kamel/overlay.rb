begin
  require 'kml'
rescue LoadError
  $STDERR.puts "You must have ruby_kml either installed to use Kamel - either as a gem or available in your path"
  $STDERR.puts "gem install ruby_kml --source http://gems.github.com"
end

module Kamel  
  class Overlay
    attr_accessor :prefix
    attr_accessor :name
    attr_accessor :placemarks

    def initialize(prefix = '')
      self.prefix = prefix.to_s
      self.placemarks = []
    end

    def placemark!(attributes)
      self.placemarks << attributes
    end

    def to_kml
      doc = KML::Document.new
      doc.name = self.name unless self.name.to_s.length == 0
      self.icons.each_with_index {|icon, index|
        doc.styles << KML::Style.new(
          :id => [prefix, 'style', index].join('-'),
          :icon_style => KML::IconStyle.new(
            :icon => KML::Icon.new(:href => icon)
          )
        )  
      }
      self.placemarks.each do |placemark|
        attrs = {}
        attrs[:name] = placemark[:name].to_s unless placemark[:name].nil?
        attrs[:description] = placemark[:description].to_s unless placemark[:description].nil?
        attrs[:geometry] = KML::Point.new(:coordinates => placemark[:location]) unless placemark[:location].nil?
        attrs[:style_url] = '#' + [prefix, 'style', self.icons.index(placemark[:icon])].join('-') unless placemark[:icon].nil?
        doc.features << KML::Placemark.new(attrs)
      end
      
      kml = KMLFile.new
      kml.objects << doc
      kml.render
    end

    protected

    def icons
      self.placemarks.collect {|x| x[:icon]}.compact.uniq.sort 
    end
  end
end
