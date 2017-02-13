#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Maintains two files:
#   Master: This is read only. Stores all the lines to be tweeted, in order.
#   Buffer: Originally a copy of the master. Each tweet process reads the first
#           line, tweets it, then deleted the line from the buffer. When the
#           buffer file is empty, the master is copied to it again.
# The master file is not used when the buffer contains lines, so it can be
#   altered freely, e.g. to re-shuffle for the next new file iteration.
################################################################################

module CopyriteLore

  class TweetFromFile

    attr_reader :twitter_client
    attr_reader :file_master
    attr_reader :file_buffer

    def initialize(account = 'NossidgeTest', file_master, file_buffer)
      @twitter_client = Accounts.new(account).client
      @file_master = file_master
      @file_buffer = file_buffer
    end

    # Get the first line in the buffer, tweet, and remove.
    def tweet_and_delete

      # If the buffer file is empty, then clone from master.
      if buffer_empty?
        copy_master_to_buffer
      end

      # Get first line of the buffer file.
      line_to_tweet = buffer_get_line

      # Tweet the line.
      tweet_some_text(line_to_tweet)

      # Delete the line from the buffer.
      save_truncated_buffer(line_to_tweet)
    end

    # Create (or overwrite) buffer file with the master.
    def copy_master_to_buffer
      FileUtils.cp(@file_master, @file_buffer)
    end

    # Create a temp file with the contents of the buffer minus the line.
    # Replace the buffer file with the temp file.
    # (Reading the whole file into memory is janky, but it works.)
    def save_truncated_buffer(line_to_exclude)
      tmp = Tempfile.new('tweet_buffer')
      File.readlines(@file_buffer).each do |l|
        tmp << l unless l.chomp == line_to_exclude
      end
      tmp.close
      FileUtils.mv(tmp.path, @file_buffer)
    end

    # Get first line of the buffer file.
    # Raises an exeption if the file is missing or EOF.
    def buffer_get_line
      File.open(@file_buffer, &:readline).chomp
    end

    # Try to read the first line, and if it fails it's empty.
    def buffer_empty?
      begin
        File.open(@file_buffer, &:readline)
        false
      rescue
        true
      end
    end

    # Read a file to array, and shuffle it.
    def shuffle_file(filename)
      File.readlines(filename).shuffle
    end

    # Write an array to file.
    def write_array_to_file(filename, array)
      File.open(filename, 'w+') do |f|
        f.puts(array)
      end
    end

    # Read the master to array, shuffle and save as buffer.
    # Don't include those lines longer than 140 characters.
    def new_shuffled_buffer
      lines = shuffle_file(@file_master).reject do |i|
        i.length >= 140
      end
      write_array_to_file(@file_buffer, lines)
    end

    # Tweet some text.
    def tweet_some_text(some_text)
      loop_until_success do
        @twitter_client.update(some_text)
      end
    end

    ############################################################################

    # Wow, so generic. Should really catch the specific exception,
    #   but it's difficult to test unless Twitter is actually down.
    private def begin_rescue
      begin
        yield

      # Raise this for the moment, while we test it.
      rescue Twitter::Error::Forbidden => e
        puts e.message
        raise e

      rescue
        nil
      end
    end

    # Try to tweet, and retry in 10 seconds if it failed.
    # If it takes more than 5 mins, then just give up.
    # Twitter may be down or something, so wrap in a begin/rescue.
    # Requires a block e.g.:
    #    twitter_client = Accounts.new('NossidgeTest').client
    #    loop_until_success do
    #      begin_rescue do
    #        twitter_client.update('Text to tweet')
    #      end
    #    end
    private def loop_until_success
      seconds_to_wait = 10
      time_out_iterations = (60 * 5) / seconds_to_wait

      iterations = 0
      tweet = nil

      loop do
        tweet = begin_rescue do
          yield
        end
        break if tweet

        if iterations == time_out_iterations
          puts "Cancelling tweet. Too many iterations: #{iterations}"
          break
        end
        iterations += 1

        puts "Tweet failed! Iteration: #{iterations}"
        sleep(seconds_to_wait)
      end
    end

  end

end

################################################################################
