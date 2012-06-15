require 'kamel'
require 'xpath_matchers'
require 'rexml/document'
require 'rexml/element'

RSpec.configure do |config|
  config.include(XpathMatchers)
end