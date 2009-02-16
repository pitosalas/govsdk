require File.dirname(__FILE__) + '/test_helper'
=begin
  * Name: google_api_test.rb
  * Description: Tests for google_api.rb
  * Author: Pito Salas
  * Copyright: (c) R. Pito Salas and Associates, Inc.
  * Date: January 2009
  * License: GPL

  This file is part of GovSDK.

  GovSDK is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  GovSDK is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with GovSDK.  If not, see <http://www.gnu.org/licenses/>.
  
  require "ruby-debug"
  Debugger.settings[:autolist] = 1 # list nearby lines on stop
  Debugger.settings[:autoeval] = 1
  Debugger.start
=end
require "ruby-debug"

class GoogleApiTest < Test::Unit::TestCase
  context "brand new API manager" do
    setup do
      @apim = GovSdk.load_apis
    end

    should "not be initialized" do
      assert_equal false, @apim.initialized?
    end
  end
  
  context "Google API" do
    setup do      
      GovSdk.init(:google => "ABQIAAAAyvWaJgF_91PvBZhITx5FDxRIYAcXj39F4zFQfQ2X3IEFURxvMRRUi0aCG6WofnUSRRoI-Pgytm5yUA")
      @g_api = GovSdk.google_api
    end

    should "be initialized once APIkey is set" do
      assert_equal true,  @g_api.initialized?
    end
    
    should "find feed for salas.com" do
      assert_equal "http://www.salas.com/feed/", @g_api.lookup_feed_url("http://www.salas.com")
    end
    
    should "not find a feed for google.com" do
      assert_equal nil, @g_api.lookup_feed_url("http://www.google.com")
    end
    
  end
end