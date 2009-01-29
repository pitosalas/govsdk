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

#require "ruby-debug"
#Debugger.settings[:autolist] = 1 # list nearby lines on stop
#Debugger.settings[:autoeval] = 1
#Debugger.start

class CongressPerson
  
  attr_reader :firstname, :lastname, :party, :state, :congress_office, :phone, :fax, :emai,
              :website, :webform, :website_url, :bioguide_id, :congresspedia_url, :state_machine_id,
              :district, :title, :govtrack_id, :crp_id, :nickname
              
  # Maps specific set of CongressPerson attributes to Sunlight APIs. Mapping is structured as
  # "name of attr in CongressPerson object" => "name of hash key in result returned from API call"
  
  SUNLIGHT_MAP = { 
          "firstname"         => "firstname",
          "lastname"          => "lastname",
          "nickname"          => "nickname",
          "party"             => "party",
          "state"             => "state",
          "congress_office"   => "congress_office",
          "phone"             => "phone",
          "fax"               => "fax",
          "email"             => "email",
          "website"           => "website",
          "webform"           => "webform",
          "bioguide_id"       => "bioguide_id",
          "congresspedia_url" => "congresspedia_url",
          "fec_id"            => "fec_id",
          "district"          => "district",
          "title"             => "title",
          "govtrack_id"       => "govtrack_id",
          "crp_id"            => "crp_id"
        }

  def self.copy_sun_properties(sunlight_hash, cong_person)
    SUNLIGHT_MAP.each do |name, attribute|
      val = sunlight_hash[attribute]
      cong_person.instance_variable_set("@#{name}", val)
    end
  end
  
  def self.convert_to_congressperson(sunlight_legislator)
    cong_person = CongressPerson.new
    leg_hash = sunlight_legislator["result"]["legislator"]
    copy_sun_properties(leg_hash, cong_person)
    cong_person
  end

  def self.find_by_name(name)
    raise ArgumentError, 'names must be Strings' unless name.is_a?(String)
    sunlight_hash = GovSdk.sunlight_api.legislators_search(name)
    sunlight_hash.collect {|leg| convert_to_congressperson(leg)}
  end

  def self.find_by_zipcode(zip)
    raise ArgumentError, 'zipcodes must be Strings' unless zip.is_a?(String)
  end
  
  def self.find_by_crp_id(crpId)
    raise ArgumentError, 'Crp-Id should be a string' unless String == crpId.class
    sunlight_hash = GovSdk.sunlight_api.legislators_get(:crp_id => crpId)
    if !sunlight_hash.nil?
      cong_person = CongressPerson.new
      copy_sun_properties(sunlight_hash, cong_person)
      cong_person
    else
      nil
    end
  end
  
  def get_fundraising_summary(electionCycle = nil)
    raise ArgumentError, 'election cycle should be nil or an integer' unless electionCycle.nil? || electionCycle.is_a?(Integer)
    fund_summary_hash = GovSdk.opensecrets_api.get_cand_summary_for_crpID(crp_id, electionCycle)
    fr_summary = FundraisingSummary.new(fund_summary_hash)
  end
  
  def get_positions_held(electionCycle = nil)
    raise ArgumentError, 'election cycle should be nil or an integer' unless electionCycle.nil? || electionCycle.is_a?(Integer)
    positions = GovSdk.opensecrets_api.get_cand_pfd_positions_held(crp_id, electionCycle)
    if positions.class == Array
      return positions.collect {|pos| Positions.new(pos)}
    elsif positions.class == Hash
      return [Positions.new(positions)]
    else
      []
    end
  end
end

class FundraisingSummary
  attr_reader :spent, :total, :cash_on_hand, :debt
  
  # Maps specific set of FundraisingSummary attributes to OpenSecrets APIs. Mapping is structured
  # "name of attr in CongressPerson object" => "name of hash key in result returned from API call"
  OPENS_FUNSUMMARY_MAP = { 
    "spent"         => "spent",
    "total"         => "total",
    "cash_on_hand"  => "cash_on_hand",
    "debt"          => "debt"
  }
  
  def initialize(init_hash)
    OPENS_FUNSUMMARY_MAP.each do |name, attribute| 
      val = init_hash[attribute]
      instance_variable_set("@#{name}", val.to_i)
    end
  end
end

class Positions
  attr_reader :title, :organization
  
  # Maps specific set of CongressPerson attributes to OpenSecrets APIs. Mapping is structured
  # "name of attr in CongressPerson object" => "name of hash key in result returned from API call"
  OPENS_POS_MAP = { 
    "title"         => "title",
    "organization"  => "organization"
  }
  
  def initialize(init_hash)
    OPENS_POS_MAP.each do |name, attribute| 
      val = init_hash[attribute]
      instance_variable_set("@#{name}", val)
    end
  end
  
  def pretty_print(pp)
    pp.text("position #{title} at #{organization}")
  end
end
