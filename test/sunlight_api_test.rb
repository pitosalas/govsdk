require File.dirname(__FILE__) + '/test_helper'
=begin
  * Name: GovSDK
  * Description: 
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
=end

class SunlightApiTest < Test::Unit::TestCase
  context "brand new API manager" do
    setup do
      @apim = GenericAPI.new
    end

    should "not be initialized" do
      assert_equal false, @apim.initialized?
    end
  end
  
  context "Sunlight API" do
    setup do      
      GovSdk.load_apis
      GovSdk.sunlight_api.key = "4ffa22917ab1ed010a8e681c550c9593"
    end

    should "be initialized once APIkey is set" do
      assert_equal true, GovSdk.sunlight_api.initialized?
    end
    
    should "return no legislator called Pito Salas" do
      result = GovSdk.sunlight_api.legislators_search("Pito Salas")
      assert_equal 0, result.length        
    end
    
    should "return a single legislator called Ted Kennedy" do    
      result = GovSdk.sunlight_api.legislators_search("Ted Kennedy")
      assert 1, result.length
    end
    
    should "return a single legislator with the nickname ted" do
      result = GovSdk.sunlight_api.legislators_get(:nickname => "Ted", :lastname => "Kennedy")
      assert_equal "Ted", result["nickname"]
    end
    
    should "be able to locate crp_id N00000308" do
      result = GovSdk.sunlight_api.legislators_get(:crp_id => "N00000308")
    end
    
    should "be able to go from name to crp_id and back" do
      result = GovSdk.sunlight_api.legislators_get(:nickname => "ted", :lastname => "Kennedy")
      crp_id = result["crp_id"]
      result = GovSdk.sunlight_api.legislators_get(:crp_id => crp_id)
      assert_equal "Ted", result["nickname"]
    end
  end
end