require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'pp'

$LOAD_PATH.unshift(File.dirname(__FILE__)+"/../lib")
$LOAD_PATH.unshift(File.dirname(__FILE__)+"/../lib/apis")

require 'govsdk'
require 'govsdk_base'
require 'apimanagers'
require 'congress_person'
require 'generic_api'
require 'sunlight_api'
require 'open_secrets_api'

class Test::Unit::TestCase
end
