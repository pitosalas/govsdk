=begin
  * Name: opml_gen_example.rb
  * Description: Example code for GovSdk
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

require 'rubygems'
require 'govsdkgem'
require 'opmlassist'

include OpmlAssist

# You always have to start off by declaring that you want to use Govsdk.
# You need to supply one or more of your API keys. 
GovSdk.init :opensecrets => "09c975b6d3f19eb865805b2244311065", 
            :sunlight => "4ffa22917ab1ed010a8e681c550c9593",
            :google => "ABQIAAAAyvWaJgF_91PvBZhITx5FDxRIYAcXj39F4zFQfQ2X3IEFURxvMRRUi0aCG6WofnUSRRoI-Pgytm5yUA"

opml = Opml.new("BlogBridge Feeds", "Feeds", {:namespace => {:namespace => "xmlns:bb", :value => "http://blogbridge.com/ns/2006/opml"}})
congressmen = CongressPerson.find_by_query(:gender => "F" )
counter = 0
congressmen.each do |cm|
  blog = cm.blog_url
  if (blog.nil?)
    counter += 1
  else
    puts "Processed #{cm.firstname} #{cm.lastname}"
    opml.feeds << Feed.new("#{cm.firstname} #{cm.lastname}", "rss", blog)
  end
end
opml.xml.write(STDOUT,1)
puts "A total of #{counter} congresspeople do not seem to have blogs"


