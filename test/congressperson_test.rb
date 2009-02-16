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

require File.dirname(__FILE__) + '/test_helper'

class CongressPersonTest < Test::Unit::TestCase
  context "In basic CongressPerson cases" do
    setup do
      GovSdk.load_apis
      GovSdk.sunlight_api.key = "4ffa22917ab1ed010a8e681c550c9593"
      @cpnone = CongressPerson.fuzzy_find_by_name("Pito Salas")
      @cpkennedy = CongressPerson.fuzzy_find_by_name("Kennedy")
      @cpkennedy[0].nickname == "Ted" ? @ted_crp_id = @cpkennedy[0].crp_id : @ted_crp_id = @cpkennedy[1].crp_id
    end

    should "return none" do
      assert_equal 0, @cpnone.length
    end
  
    should "return two legislators named Kennedy" do
      assert_equal 2, @cpkennedy.length
      @cpkennedy.each do |a_kennedy|
        assert ["Edward", "Patrick Joseph"].include? a_kennedy.firstname
      end
    end

    context "trying to use CRP from earlier test" do
      setup do
        @cpteddy = CongressPerson.find_by_crp_id(@ted_crp_id)
      end
      
      should "Bad crp should be nil" do
        @cpbad = CongressPerson.find_by_crp_id("1")   
        assert_nil @cpbad
      end

      should "crpid should be for ted kennedy" do
        assert_equal "Ted", @cpteddy.nickname
      end
      
      should "have votesmart_id for Ted Kennedy one" do
        assert_equal "53305", @cpteddy.votesmart_id
        assert_equal "http://www.votesmart.org/canphoto/53305.jpg", @cpteddy.photo_url
      end
    end
    
    context "Find all legislators with certain criteria" do
      setup do
        @all_kennedy = CongressPerson.find_by_query(:lastname => "kennedy")
      end

      should "locate 2 kennedies" do
        assert_equal 2, @all_kennedy.length
      end
    end
    

    context "Get fundraising summary for N00000308" do
      setup do
        GovSdk.opensecrets_api.key = "09c975b6d3f19eb865805b2244311065"
        @mycandidate = CongressPerson.find_by_crp_id("N00000308")
      end

      should "pull info out of summary" do
        assert_not_nil @mycandidate.crp_id
        fund_sum = @mycandidate.get_fundraising_summary(2008)
        assert_equal 0, fund_sum.debt
        fund_sum = @mycandidate.get_fundraising_summary(2006)
        assert_equal 0, fund_sum.debt          
      end
    end

    context "Get a look at positions held detail for N00000360 and Clinton" do
      setup do
        GovSdk.opensecrets_api.key = "09c975b6d3f19eb865805b2244311065"
        @mycandidate = CongressPerson.find_by_crp_id("N00000360")
        @nopositioncandidate = CongressPerson.fuzzy_find_by_name("Clinton")
      end

      should "see what positions were held for N00000360" do
        positions_held = @mycandidate.get_positions_held(2008)
        assert_equal 16, positions_held.length
      end
      
      should "work if candidate has no positions held information" do
        positions_held = @nopositioncandidate[0].get_positions_held(2008)
        assert_equal 1, positions_held.length
      end
    end
    
    context "Try some other odd cases" do
      setup do
        GovSdk.opensecrets_api.key = "09c975b6d3f19eb865805b2244311065"
        @franks = CongressPerson.fuzzy_find_by_name("Frank")[0]
      end

      should "see that barney frank reported zero positions" do
        assert_equal 0, @franks.get_positions_held(2008).length        
      end
    end
    
    context "See if we can find the blog url correctly" do
      setup do
        GovSdk.load_apis
        GovSdk.sunlight_api.key = "4ffa22917ab1ed010a8e681c550c9593"
        GovSdk.google_api.key = "ABQIAAAAyvWaJgF_91PvBZhITx5FDxRIYAcXj39F4zFQfQ2X3IEFURxvMRRUi0aCG6WofnUSRRoI-Pgytm5yUA"
        @mycandidate = CongressPerson.fuzzy_find_by_name("Abercombie")
      end
      
      should "N00000308 has a blog" do
        assert_equal "http://www.house.gov/apps/list/press/hi01_abercrombie/RSS.xml", @mycandidate[0].blog_url
      end
    end
  end
end