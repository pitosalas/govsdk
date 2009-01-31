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

require 'rubygems'
require 'govsdkgem'

# You always have to start off by declaring that you want to use Govsdk. You need to supply one or more
# of your API keys. 
GovSdk.init :opensecrets => "09c975b6d3f19eb865805b2244311065", :sunlight => "4ffa22917ab1ed010a8e681c550c9593"

# Lets start by looking for congress people with "Frank" in their name. We iterate through the resultant array
# and display some factoids about each of the congressmen found

the_franks = CongressPerson.find_by_name("Frank")
the_franks.each do |cp| 
  puts "Congressman: #{cp.firstname} #{cp.lastname} has crp_id #{cp.crp_id}." 
  puts "    He or she reported holding #{cp.get_positions_held(2008).length} positions in 2008"
end

# Within govsdk we've chosen to use the Center for Responsive Politics ID to indicate a particular Congressperson

