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
    text = myhash[key];
    if myhash.has_key?("CONVERT_BREAKS")
      if myhash["CONVERT_BREAKS"] == "1"
        text.gsub!("\n","<br />\n");
        #text.gsub!("\n(\s+)") { |match| "&nbsp;" * match.size; }
      end
    end
    if myhash.has_key?("FILTER") && myhash["FILTER"] == "maruku"
      require 'maruku'
      doc = Maruku.new(text)
      text=doc.to_html
      #text=%x{echo "#{text}" | /Users/rahul/bin/multis.sh}
    end
    myhash[key] = text;
  }

  tmpltext.gsub!( /##(.*?)##/ ) {
    raise "Key '#{$1}' found in template but the value has not been set" unless ( myhash.has_key?( $1 ) )
    myhash[ $1 ].to_s
  }
print tmpltext, "\n";

end

