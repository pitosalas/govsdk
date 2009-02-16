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
include Opmloco

class MyTest < Test::Unit::TestCase
  context "Test context" do
    setup do
      
    end
    
    should "work with minimal opml case" do
      s = String.new
      Opml.new("hello", "world").xml.write(s)
      assert_equal "<?xml version='1.0'?><opml><head><title>hello</title></head><body><outline text='world'/></body></opml>", s
    end

    should "work with something a little more complicated" do
      s = String.new
      opml = Opml.new("BlogBridge Feeds", "Good Stuff", {:namespace => {:namespace => "xmlns:bb", :value => "http://blogbridge.com/ns/2006/opml"}})
      opml.feeds << Feed.new("Latest News from Congressman Trent Franks Arizona's 2nd District", "rss", "http://www.house.gov/apps/list/press/az02_franks/RSS.xml")
      opml.feeds << Feed.new("Ellen's Illinois Tenth Congressional District Blog", "rss", "http://ellenofthetenth.blogspot.com/feeds/posts/default")
      opml.xml.write(s)
      assert_equal "<?xml version='1.0'?><opml xmlns:bb='http://blogbridge.com/ns/2006/opml'><head><title>BlogBridge Feeds</title></head><body><outline text='Good Stuff'><outline xmlUrl='http://www.house.gov/apps/list/press/az02_franks/RSS.xml' text='Latest News from Congressman Trent Franks Arizona&apos;s 2nd District' type='rss'/><outline xmlUrl='http://ellenofthetenth.blogspot.com/feeds/posts/default' text='Ellen&apos;s Illinois Tenth Congressional District Blog' type='rss'/></outline></body></opml>", s
    end
  end
end
