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

class GovSdkTest < Test::Unit::TestCase
  context "" do
    setup do

    end

    should "Check error checking with invalid arg" do
      assert_raise ArgumentError do
        GovSdk.init(:xx => 1)
      end
    end
    should "Check error checking with valid args" do
      assert_nothing_raised ArgumentError do
        GovSdk.init(:sunlight => 1, :opensecrets => 2)
      end
    end

  end
end