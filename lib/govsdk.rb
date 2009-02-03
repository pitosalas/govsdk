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

class GovSdk

  def self.load_apis
    @sunl_api = SunlightApi.new
    @opens_api = OpenSecretsApi.new
  end
  
  def self.sunlight_api
    @sunl_api
  end
  
  def self.opensecrets_api
    @opens_api
  end
  
  def self.followmoney_api
    @followm_api
  end
  
  def self.init(apikeys = {})
    apikeys.keys.each { |x| raise ArgumentError unless [:followmoney, :sunlight, :opensecrets].include?(x) }
    GovSdk.load_apis
    apikeys.each do |key, val|
      @sunl_api.key = val if key == :sunlight
      @opens_api.key = val if key == :opensecrets
      @followm_api.key = val if key == :followmoney
    end
  end
  
end
