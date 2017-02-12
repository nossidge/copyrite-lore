#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Singleton to hold directory locations.
################################################################################

module CopyriteLore

  class FileSystem

    # The root directory.
    def self.dir_root
      @@dir_root ||= File.expand_path('../../../', __FILE__)
    end

    # Location of the Ruby code.
    def self.dir_lib
      @@dir_lib ||= "#{dir_root}/lib"
    end

    # The location of the base data directory.
    def self.dir_data
      @@dir_data ||= "#{dir_root}/data"
    end

  end

end

################################################################################
