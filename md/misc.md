Miscellaneous
=============

Contains small helpful features for text and keyboard driven applications.

== Prefix Command

If you wish to attach multiple commands to, say, C-s, using a second key you would do as follows:

  App.new do

      @form.define_prefix_command :csmap, :scope => self
      @form.define_key(:csmap, "r", 'refresh', :refresh )
      @form.define_key(:csmap, "s", 'specification') { specification }
      @form.bind_key ?\C-s, :csmap

  end

The methods refresh and specification have been defined inside the App object. After pressing C-s, pressing r or s would cinvoke these methods.

Please note that C-x has already been used by App and various widgets for mappings. 
App uses M-x (Alt-x) for binding to various functions which can be selected by the user. See abasiclist.rb for an example.

