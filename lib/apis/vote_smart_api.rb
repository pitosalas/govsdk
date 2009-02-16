=begin
  * Name: vote_smart_api.rb
  * Description: GovSdk support for votesmart api
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

require 'generic_api'

class VoteSmartApi < GenericApi
  include HTTParty
  VoteSmartApi.base_uri "http://api.votesmart.org"
  format :xml

  # Simply declare and remember the API Key
  def key=(key)
    @api_key = key
    VoteSmartApi.default_params :key => key
  end
  
  def get_votesmart_candidate(method_name, query)
    begin
      result = VoteSmartApi.get(method_name, query)
    rescue Net::HTTPServerException => exception
      puts "\nEXCEPTION: from votesmart_api #{method_name}: #{exception.response.body}"
      return nil
    end
    if result.has_key?("error")
      puts "\nERROR: from votesmart_api #{method_name}: #{result["error"]["errorMessage"]}"
      return nil
    else
      result["candidateList"]["candidate"]
    end
  end
  
  def candidate_fuzzy_find(lastname)
    get_votesmart_candidate("/Candidates.getByLevenstein", :query => {:lastName => lastname})
  end

  def officials_fuzzy_find(lastname)
    get_votesmart_candidate("/Officials.getByLevenstein", :query => {:lastName => lastname})
  end

  def candidate_getBio(candidateId)
    get_votesmart_candidate("/Candidate.getBio", :query => {:candidateId => candidateId})
  end
  
  def candidate_find_for_office_and_state(office, state)
    get_votesmart_candidate("/Candidate.getByOfficeState", :query => {:officeId => office, :stateId => state})
  end
end
