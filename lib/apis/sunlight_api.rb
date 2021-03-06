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
require 'cgi'
require 'net/http'
require 'generic_api'

# Control Access to Sunlight API.

class SunlightApi < GenericApi
  include HTTParty
  SunlightApi.base_uri "services.sunlightlabs.com"

  def legislators_search(params)
    result = SunlightApi.get("/api/legislators.search", :query => {:name => params})
    result["response"]["results"]
  end
  
  # Simply declare and remember the API Key
  def key=(key)
    @api_key = key
    SunlightApi.default_params :apikey => key
  end

  # Call Sunlight queries returning a single legislator matching a query
  def legislators_get(params)
    begin
      result = SunlightApi.get("/api/legislators.get", :query => params)
      result = result["response"]["legislator"]
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Sunlight - legislators.get: #{exception.response.body}"
      return nil
    end
  end
  
  # Sunlight query returning an array of matching legislators
  def legislators_getlist(params)
    begin
      result = SunlightApi.get("/api/legislators.getList", :query => params)
      result = result["response"]["legislators"]
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Sunlight - legislators.getList: #{exception.response.body}"
      return nil
    end
  end
  
  
end
