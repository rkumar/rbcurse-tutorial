# Dialogs

This page describes some common methods for input and output such as alerting a user, displaying text, getting a string, getting a confirmation, etc. Most of these are present in [rdialog.rb](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/util/rdialogs.rb)

### Alert

To alert a user with a single line of text use:

    alert text, config

`text` may be a string or Variable.
`config` is a hash containing title, and other setting which will be passed to a `MessageBox`.

    alert("Hope you enjoyed this demo", {'title' => "Au Revoir", :bgcolor => :blue , :color => :white})

    alert "Successful Operation"
    
### Alert or display multi-line text

    textdialog text, config

`text` can be an array, or an exception object. Exception objects are treated specially, the stacktrace is appended to the `to_s` output of the exception or error object.

    textdialog(%x[ gem specification #{name} ].split("\n") , :title => 'Specification')
    textdialog( res, :title => cmd ) if res


### Viewing text or a file

`view` method takes an array or filename and displays it in a textview using Rbcurses::Viewer. 
This method is a shortcut to Viewer. `view` also takes a config object and a block which are both passed to Textview.

This example, taken from dbdemo, uses Tabular to generate a table from an sql resultset, and passes that to `view` in array form. `Tabular` formats the table in string format with pipe delimiters for columns.

    require 'rbcurse/core/widgets/tabular'
    t = Tabular.new do |t|
      t.headings = $columns
      t.data=content   
    end
    view t.render

See [rwidget.rb](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/rwidget.rb) for `view`.
The current code of `view` is:

      # view a file or array of strings
      def view what, config={}, &block # :yields: textview for further configuration
        require 'rbcurse/core/util/viewer'
        RubyCurses::Viewer.view what, config, &block
      end

### Getting a string

This popups a dialog asking the user for a string. 

    get_string label, config

Config contains an optional `:title` which defaults to "Entry". It also contains `:default` which is an optional default value to use for the field, and `:maxlen` and `:display_length` for the field.

`config` contains two hashes `:label_config` and `field_config` for configuring the respective field and label.
You may thus override the row and col or color or bgcolor of either.

`get_string` also maintains a history of what the user has typed in this session in a global variable named `$get_string_history`. This is available via the `M-h` key. A program can load this variable from a saved source prior to calling `get_string`. A program may maintain separate history for different types of data prompted to user, and populate this variable accordingly prior to calling this method.

Upon pressing OK, returns the string entered. Upon pressing Cancel returns `nil`.

    str = get_string "Enter Name: ", :title => "User Input", :default => "Bilbo"

`get_string` yields the field created for any processing.

### Getting a confirmation

`confirm` is used to get a confirmation from the user

    confirm text, config, block

    confirm "Would you like to quit?", :title => "Quit"

The resultant dialog has an OK and Cancel with OK being the default.
To change the default to cancel, add this in the config:

    :default_button => 1

The default title is "Confirm"
The return value is `true` for pressing yes, and `false` for no.

    if confirm "Leave this application?"
       throw :close
    end


## 


### See also:

-
-

