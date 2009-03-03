=begin
  * Name: test_template.rb
  * Description: Template for GovSdk Tests
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

class UtilTest < Test::Unit::TestCase
  context "Util methods test" do

    should "Lookup a state" do
      assert_equal "MA", Util.lookup_state_name("Mass")
      assert_equal "MA", Util.lookup_state_name("mass")
      assert_equal "MA", Util.lookup_state_name("MA")      
      assert_equal "WV", Util.lookup_state_name("WV")
      assert_equal "WV", Util.lookup_state_name("wv")
      assert_equal nil, Util.lookup_state_name("new")
      assert_equal nil, Util.lookup_state_name("pito")
    end
  end
end