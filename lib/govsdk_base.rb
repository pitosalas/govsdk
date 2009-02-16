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

class GovSdkBase

# General error checking and reporting methods
  def assume_not_blank val, message
    raise ArgumentError, (message + caller.shift) unless val.nil? || val.kind_of?(String)
  end
  
  def assume_uses_google_api
    raise ArgumentError, "Call requires Google API and Google key" + called.shift unless GovSdk.google_api.initialized?
  end
  
  def assume_nil_or_integer val
    raise ArgumentError, "Requires nil or integer argument. Called from " + called.shift unless  val.nil? || val.kind_of?(Integer)
  end
  
  def self.assume_hash val
    raise ArgumentError, "Requires a hash argument. Called from " + called.shift unless val.kind_of?(Hash)
  end    
  
  def assume_hash val
    self.assume_hash val
  end
  
end