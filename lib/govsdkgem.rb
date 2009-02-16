=begin
  * Name: govsdkgem.rb
  * Description: Gem root 'require' file for govsdk
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

$LOAD_PATH.unshift(File.dirname(__FILE__)+"/../lib/apis")

require 'govsdk'
require 'govsdk_base'
require 'open_secrets_api'
require 'congress_person'
require 'vote_smart_api'
require 'google_api'
require 'sunlight_api'
require 'opmloco'
