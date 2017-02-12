#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# xxxxxxxxxx
################################################################################

require 'json'

require_relative 'copyrite_lore/core_extensions/string.rb'
require_relative 'copyrite_lore/substitutions.rb'
require_relative 'copyrite_lore/file_system.rb'
require_relative 'copyrite_lore/patents.rb'

################################################################################

patents = CopyriteLore::Patents.new
patents.perform_substitutions
patents.save_substitutions

################################################################################
