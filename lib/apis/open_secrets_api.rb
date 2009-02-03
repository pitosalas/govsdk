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
require 'genericapi.rb'
# Control Access to OpenSecrets API.
class OpenSecretsApi < GenericApi
  include HTTParty
  base_uri "www.opensecrets.org/api/"
  format :xml

  def key=(key)
    @api_key = key
    OpenSecrets.default_params :apikey => key
  end
  
  def get_cand_info(method_name, crpID, cycle)
    query_hash = {:method => method_name}
    begin
      result = OpenSecrets.get("", :query => query_hash.merge({:cid => crpID, :cycle => cycle}))
    rescue Net::HTTPServerException => exception
      puts "EXCEPTION: from Opensecrets! #{method_name}: #{exception.response.body}"
      return nil
    end
  end
  
  def get_cand_summary_for_crpID(crpID, cycle = "")
    result = get_cand_info("candSummary", crpID, cycle)
    result["response"]["summary"]
  end
  
  def get_cand_pfd_assets(crpID, cycle = "")
    result = get_cand_info("memPFDprofile", crpID, cycle)
    result["response"]["member_profile"]["assets"]["asset"]
  end
  
  def get_cand_pfd_transactions(crpID, cycle = "")
    result = get_cand_info("memPFDprofile", crpID, cycle)
    result["response"]["member_profile"]["transactions"]["transaction"]
  end
  
  def get_cand_pfd_positions_held(crpID, cycle = "")
    result = get_cand_info("memPFDprofile", crpID, cycle)
    result = result["response"]["member_profile"]
    if result.has_key?("positions")
      result["positions"]["position"]
    else
      nil
    end
  end
end

