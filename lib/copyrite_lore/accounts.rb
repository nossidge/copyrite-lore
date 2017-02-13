#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# API keys for my various Twitter accounts.
################################################################################

module CopyriteLore

  class Accounts
    attr_reader :account, :url, :email, :client

    def initialize(account)
      @account = nil
      @url = nil
      @email = nil
      @client = nil

      if account.casecmp('NossidgeTest') == 0
        @account = 'NossidgeTest'
        @url = 'https://twitter.com/NossidgeTest'
        @email = 'nossidgetest@gmail.com'
        @client = Twitter::REST::Client.new do |c|
          c.consumer_key        = 'xxxxxxxxxxxxxxxxxxxxxxxxx'
          c.consumer_secret     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          c.access_token        = 'xxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          c.access_token_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        end

      elsif account.casecmp('CopyriteLore') == 0
        @account = 'CopyriteLore'
        @url = 'https://twitter.com/CopyriteLore'
        @email = 'copyritelore@gmail.com'
        @client = Twitter::REST::Client.new do |c|
          c.consumer_key        = 'xxxxxxxxxxxxxxxxxxxxxxxxx'
          c.consumer_secret     = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          c.access_token        = 'xxxxxxxxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
          c.access_token_secret = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        end

      else
        raise ArgumentError, 'Twitter account not listed.'
      end
    end
  end
end

################################################################################
