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
  
  require "ruby-debug"
  Debugger.settings[:autolist] = 1 # list nearby lines on stop
  Debugger.settings[:autoeval] = 1
  Debugger.start
=end

class VoteSmartApiTest < Test::Unit::TestCase
  context "brand new API manager" do
    setup do
      @apim = GovSdk.load_apis
    end

    should "not be initialized" do
      assert_equal false, @apim.initialized?
    end
  end
  
  context "VoteSmart API" do
    setup do      
      GovSdk.init(:votesmart => "c5056828cffa0be5e095cbd75ce3a663")
      @vs_api = GovSdk.votesmart_api
    end

    should "be initialized once APIkey is set" do
      assert_equal true,  @vs_api.initialized?
    end
    
    should "find no candidates called Kennedy" do
      assert_equal nil, @vs_api.candidate_fuzzy_find("Kennedy")
    end
    
    should "find more than one officials named Kennedy" do
      assert 1 <= @vs_api.officials_fuzzy_find("Kennedy").length
    end
    
  end
end