#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Monkey patch the String class.
################################################################################

module CopyriteLore
  module CoreExtensions
    module String

      # What case is the word in?
      def case
        if self == downcase
          'down'
        elsif self == upcase
          'up'
        elsif self[0] == self[0].upcase && self[1..-1] == self[1..-1].downcase
          'title'
        else
          'mixed'
        end
      end

      # Uppercase the first alpha, even if it's not the first character.
      def capitalize_alpha
        sub(/(\w)/, &:upcase)
      end

      # Remove all non alphanumerics.
      def strip_punc
        gsub(/[^A-Za-z0-9\s]/i, '')
      end

    end
  end
end

################################################################################

class String
  include CopyriteLore::CoreExtensions::String
end

################################################################################
