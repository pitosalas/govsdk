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
require 'httparty'
require 'cgi'
require 'net/http'

#require "ruby-debug"
#Debugger.settings[:autolist] = 1 # list nearby lines on stop
#Debugger.settings[:autoeval] = 1
#Debugger.start

class GenericAPI  
  
  def initialized?
    @api_key != nil || @api_key.class == String
  end
  
end

# Control Access to Sunlight API.

class Sunlight < GenericAPI
  include HTTParty
  Sunlight.base_uri "services.sunlightlabs.com"

  def legislators_search(params)
    result = Sunlight.get("/api/legislators.search", :query => {:name => params})
    result = result["response"]["results"]
  end
  
  # Simply declare and remember the API Key
  def set_apikey(key)
    @api_key = key
    Sunlight.default_params :apikey => key
  end

  # Call any of the various legal Sunlight queries
  def legislators_get(params)
    begin
      result = Sunlight.get("/api/legislators.get", :query => params)
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Sunlight - legislators.get: #{exception.response.body}"
      return nil
    end
    result = result["response"]["legislator"]
  end
  
end

# Control Access to OpenSecrets API.
class OpenSecrets < GenericAPI
  include HTTParty
  base_uri "www.opensecrets.org/api/"
  format :xml

  def set_apikey(key)
    @api_key = key
    OpenSecrets.default_params :apikey => key
  end
  
  def get_cand_summary_for_crpID(crpID, cycle = "")
    queryhash = {:method => "candsummary"}
    begin
      result = OpenSecrets.get("", :query => queryhash.merge({:cid => crpID, :cycle => cycle}))
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Opensecrets - candSummary.get: #{exception.response.body}"
      return nil
    end
    result["response"]["summary"]
  end
  
  def get_cand_pfd_assets(crpID, cycle = "")
    queryhash = {:method => "memPFDprofile"}
    begin
      result = OpenSecrets.get("", :query => queryhash.merge({:cid => crpID, :cycle => cycle}))
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Opensecrets - candSummary.get: #{exception.response.body}"
      return nil
    end
    result["response"]["member_profile"]["assets"]["asset"]
  end
  
  def get_cand_pfd_transactions(crpID, cycle = "")
    queryhash = {:method => "memPFDprofile"}
    begin
      result = OpenSecrets.get("", :query => queryhash.merge({:cid => crpID, :cycle => cycle}))
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Opensecrets - candSummary.get: #{exception.response.body}"
      return nil
    end
    result["response"]["member_profile"]["transactions"]["transaction"]
  end
  
  def get_cand_pfd_positions_held(crpID, cycle = "")
    queryhash = {:method => "memPFDprofile"}
    begin
      result = OpenSecrets.get("", :query => queryhash.merge({:cid => crpID, :cycle => cycle}))
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Opensecrets - candSummary.get: #{exception.response.body}"
      return nil
    end
    result = result["response"]["member_profile"]
    if result.has_key?("positions")
      result["positions"]["position"]
    else
      nil
    end
  end
    
end



  

