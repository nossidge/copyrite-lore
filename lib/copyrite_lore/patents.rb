#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Read the plain text file to extract just the patents.
################################################################################

module CopyriteLore

  class Patents

    attr_reader :file_text, :file_json
    attr_reader :file_magic, :file_muggle
    attr_reader :patents_magic, :patents_muggle

    def initialize(file_text   = FileSystem.dir_data + '/patents1992-1993.txt',
                   file_json   = FileSystem.dir_data + '/patents1992-1993.json',
                   file_magic  = FileSystem.dir_data + '/patents_magic.txt',
                   file_muggle = FileSystem.dir_data + '/patents_muggle.txt')
      @file_text   = file_text
      @file_json   = file_json
      @file_magic  = file_magic
      @file_muggle = file_muggle
    end

    ############################################################################

    # Read the text file, process to get a line for each patent.
    # Return a hash of arrays, with the category as the key.
    def patent_hash
      @patent_hash ||= nil; return @patent_hash if !@patent_hash.nil?

      # Read all lines from the patents text file.
      patents_file = File.readlines(@file_text)

      # Don't need to start adding to the array until this line.
      line_start = 'Inspection control system and method'
      bool_start = false

      # Stop adding to the array from this line.
      line_end = 'WHERE TO SEND YOUR COMMENTS ABOUT SOFTWARE PATENTS'
      bool_end = false

      # Lines starting with 3 tab characters are headers.
      prefix_header = '			'
      header = ''

      # Lines starting with 4 spaces are continuations of previous lines.
      prefix_continue = '    '

      # Hash to add patents to.
      patents = Hash.new { |h, k| h[k] = [] }

      # Loop through each line and add to the array if necessary.
      patents_file.each do |line|

        # Start and stop booleans.
        bool_start = true if line.strip == line_start
        bool_end   = true if line.strip == line_end

        # Header is the key for the hash.
        header = line.strip if line.match(prefix_header)

        # Ignore the line if necessary.
        next if line.strip.gsub(/\A[\d_\W]+/, '').empty? or
                line.match(prefix_header) or
                not bool_start or bool_end

        # Add to the array, or append to previous entry.
        # Strip and remove any '--' characters from start of string.
        if line[0...prefix_continue.size] == prefix_continue
          patents[header][-1] += ' ' + line.strip.tap{|s|s.slice!('--')}
        else
          patents[header] << line.strip.tap{|s|s.slice!('--')}
        end
      end

      # Sort the arrays alphabetically.
      @patent_hash = patents.each { |k,v| v.sort!.uniq! }
    end

    # Return an array of all patents, regardless of category.
    def patent_array
      @patent_array ||= nil; return @patent_array if !@patent_array.nil?
      @patent_array = patent_hash.map { |k,v| v }.flatten
    end

    ############################################################################

    # Save the hash back out to a JSON file.
    def save_to_json
      File.open(@file_json, 'w') do |f|
        f.write JSON.pretty_generate(self.patent_hash)
      end
    end

    ############################################################################

    # Perform Wiccan substitutions on each patent string.
    def perform_substitutions
      magic = []
      muggle = []
      self.patent_array.each do |pat|

        # If it includes a substitution, then it is magic.
        if CopyriteLore.substitutions.keys.any? { |i| pat.downcase.include? i }
          arr = magic
        else
          arr = muggle
        end

        # Perform substitutions, preserving capitalisation.
        CopyriteLore.substitutions.each do |k,v|
          pat.gsub!(k,v)
          pat.gsub!(k.capitalize_alpha, v.capitalize_alpha)
        end

        # Push to the appropriate array.
        arr << pat
      end
      @patents_magic  = magic .sort.uniq
      @patents_muggle = muggle.sort.uniq
    end
    
    ############################################################################

    # Save substitutions to file.
    def save_substitutions
      File.open(@file_magic, 'w') { |fo| fo.puts @patents_magic .join("\n") }
      File.open(@file_muggle,'w') { |fo| fo.puts @patents_muggle.join("\n") }
    end

    ############################################################################

  end
end

################################################################################
