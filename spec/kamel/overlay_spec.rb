$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rubygems'
require 'spec'
require 'kamel'
require File.dirname(__FILE__) + '/../xpath_matchers'


require 'rexml/document'
require 'rexml/element'

describe Kamel::Overlay, '#to_kml' do
  setup do
    @overlay = Kamel::Overlay.new('test')
    @overlay.placemark!(:name => 'placemark-1', :location => {:lat => 1, :lng => 2}, :description => 'Place 1', :icon => 'icon-1.png')
    @overlay.placemark!(:name => 'placemark-2', :location => "3,4", :description => 'Place 2', :icon => 'icon-1.png')
    @overlay.placemark!(:name => 'placemark-3', :location => [5,6,7], :icon => 'icon-2.png')
    @doc = @overlay.to_kml
  end

  it 'outputs one style block for each unique icon' do
    @doc.should have_nodes("/kml/Document/Style", 2)
  end

  it 'outputs one placemark block for each placemark' do
    @doc.should have_nodes("/kml/Document/Placemark", 3)
  end

  it 'records the name of each placemark' do
    @doc.should match_xpath("/kml/Document/Placemark[1]/name", "placemark-1")
    @doc.should match_xpath("/kml/Document/Placemark[2]/name", "placemark-2")
    @doc.should match_xpath("/kml/Document/Placemark[3]/name", "placemark-3")
  end
  
  it 'records the description of each placemark if it is provided' do
    #TODO Figure out how to check for CDATA
    @doc.should have_xpath("/kml/Document/Placemark[1]/description")
    @doc.should have_xpath("/kml/Document/Placemark[2]/description")
    @doc.should_not have_xpath("/kml/Document/Placemark[3]/description")
  end

  it 'records the location of each placemark' do
    @doc.should match_xpath("/kml/Document/Placemark[1]/Point/coordinates", "2,1")
    @doc.should match_xpath("/kml/Document/Placemark[2]/Point/coordinates", "3,4")
    @doc.should match_xpath("/kml/Document/Placemark[3]/Point/coordinates", "5,6,7")
  end

  it 'records a styleUrl that matches up to the style block for the given icon' do
    doc = REXML::Document.new(@doc)
    style_ids = REXML::XPath.match(doc, "/kml/Document/Style/IconStyle/Icon/href").inject({}) {|a,v|
      a.update(v.text => '#' + v.parent.parent.parent.attribute('id').value)
    }
    @doc.should match_xpath("/kml/Document/Placemark[1]/styleUrl", style_ids['icon-1.png'])
    @doc.should match_xpath("/kml/Document/Placemark[2]/styleUrl", style_ids['icon-1.png'])
    @doc.should match_xpath("/kml/Document/Placemark[3]/styleUrl", style_ids['icon-2.png'])
  end
end
