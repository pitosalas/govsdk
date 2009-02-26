require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'mocha'
require 'pp'
require 'httparty'

$LOAD_PATH.unshift(File.dirname(__FILE__)+"/../lib")
$LOAD_PATH.unshift(File.dirname(__FILE__)+"/../lib/apis")

require 'google_api'
require 'govsdk'
require 'govsdk_base'
require 'apimanagers'
require 'congress_person'
require 'generic_api'
require 'sunlight_api'
require 'open_secrets_api'
require 'vote_smart_api'
require 'util'

class Test::Unit::TestCase
end
