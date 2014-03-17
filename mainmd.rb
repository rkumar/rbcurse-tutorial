#!/usr/bin/env ruby
require 'rubygems'

require 'heredocparser'
#*******************************************************#
#                                                       #
#                                                       #
# Arunachalesha                                         #
# $Id$  #
#*******************************************************#
if __FILE__ == $0
  inputfilename=ARGV[0];
  tmpl = ARGV[1];
  tmpltext=File::read(tmpl);
  myhash=parse_heredoc_to_hash(inputfilename);
  ["BODY","INTRO"].each { |key|
    #text = myhash[key];
    #myhash[key] = text;
  }

  tmpltext.gsub!( /##(.*?)##/ ) {
    raise "Key '#{$1}' found in template but the value has not been set" unless ( myhash.has_key?( $1 ) )
    myhash[ $1 ].to_s
  }
print tmpltext, "\n";

end

