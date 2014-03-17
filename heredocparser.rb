#!/usr/bin/env ruby -w
#*******************************************************#
# This is a sample program which reads a data file
# into a hash.
# The format can be either:
#   -  key: value
#   -  key: <<SOMESTR
#        ... any kind of multiline
#      SOMESTR
#                                                       #
# The motive for this is that yaml coughs if the multiline
# date has data in it that appear like another definition.
# My data is often programming code which will give 
# problems to YAML.
# To test this call this with intro.page
# http://www.benegal.org/files/intro.page
# Arunachalesha                                         #
# $Id$  #
#*******************************************************#
def parse_heredoc_to_hash(filename)
  file = File.new(filename, "r");
  myhash=Hash.new
  line = file.gets;
  while line
    # check for heredoc start
    if line =~ /^([_\w]+):\s*<<(.*)$/
      kword=$1;
      delim=$2;
      buffer="";
      line = file.gets;
      # keep reading until you find the end of heredoc
      while line && line !~ /^#{delim}$/
        buffer = buffer + line;
        line = file.gets;
      end
      myhash[kword]=buffer;
    else
      # this is a simple, single line assignment
      if line =~ /^([_\w]+):\s*(.*)$/
        myhash[$1]=$2;
      else
        # did not know what to know with this
        print "ERROR:  #{line}\n"
      end
    end
    line = file.gets;
  end
  return myhash;
end # def

# java's main method !!
if __FILE__ == $0
  require 'pp'
  filename=ARGV[0];
  myhash = parse_heredoc_to_hash(filename)
  print "=========="
  pp myhash
  print "=========="
end
