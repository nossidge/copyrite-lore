#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Read in a list of patents.
# Substitute tech terms for Wiccan terms.
# Tweet one at regular intervals.
################################################################################

require 'fileutils'
require 'tempfile'
require 'twitter'
require 'json'

require_relative 'copyrite_lore/core_extensions/string.rb'
require_relative 'copyrite_lore/substitutions.rb'
require_relative 'copyrite_lore/file_system.rb'
require_relative 'copyrite_lore/patents.rb'
require_relative 'copyrite_lore/tweet_from_file.rb'
require_relative 'copyrite_lore/accounts.rb'

################################################################################

module CopyriteLore

  # Tweet the first line from the buffer.
  def self.make_wiccan_patent_files
    patents = CopyriteLore::Patents.new
    patents.perform_substitutions
    patents.save_substitutions
  end

  # Tweet the first line from the buffer.
  def self.tweet_a_patent
    account = 'NossidgeTest'
    file_master = FileSystem.dir_data + '/patents_magic.txt'
    file_buffer = FileSystem.dir_data + '/patents_buffer.txt'
    tweet_from_file = TweetFromFile.new(account, file_master, file_buffer)

    # Tweet the top line in the buffer.
    # (Shuffle the master if no buffer.)
    if tweet_from_file.buffer_empty?
      tweet_from_file.new_shuffled_buffer
    end
    tweet_from_file.tweet_and_delete
  end

end

################################################################################
