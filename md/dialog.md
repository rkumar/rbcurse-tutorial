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

There is also an old style program that gets the confirmation at the bottom of the screen, and prompts of a y or n.
`rb_confirm` (alias `confirm_window` )


    rb_confirm text, aconfig={}, &block

This returns a true (for Y/y) else false.
If a default (true or false) is passed in the Hash, then the user can press Enter and the default is returned.
The Hash can also have ':color' or ':bgcolor' but there is no 'wait'.

### Print a status or error message

    print_status_message text, aconfig={}, &block
    print_error_message text, aconfig={}, &block

This method prints a status or error message at the bottom of the screen and pauses for a key. 

`text` can be a string, Variable or Exception. 
`aconfig` is a Hash that may have ':color', ':bgcolor' or ':color_pair'
It may also have ':wait' which takes a number of seconds to wait before closing (in case the user does not press a key).

Currently, the only difference between these two methods is that error prints red on black whereas status prints white on black.

### Progress Dialog

This is a window for printing status messages during a process. This is not the same as the [Progress widget](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/rprogress.rb) which is embedded in a form.

There are two forms: `progress_dialog` has the look of a popup with borders. It has a height of 10 and width of 60. `status_window` does not have borders and takes the last two rows of the screen like old applications. The choice of using this depends on the look and feel you want.


   progress_dialog config={}, &block
   status_window config={}, &block

Both return a StatusWindow so they have identical operations such as `print`, `print_string`, `destroy`, `hide`, `show` , `linger` and `pause`. 

    sw = progress_dialog :color_pair => $reversecolor, :row_offset => 4, :col_offset => 5

`sw.print (array)` : will print the array, one element on each row.
`sw.printstring (row, col, string, color_pair)` : print given string on row and col. color_pair is optional and default to that of window. It may be supplied when calling status_window or progress_dialog.
`sw.pause` waits for a char from the user
`sw.linger` keeps the window open for a second and then destroys it.
In all other case, `destroy` must be called on the status window.

### Popup list

    popuplist list, config={}, &block

`popuplist` allows us to popup a list in a dialog for the user to select. The selected_index is returned.

ENTER (or SPACE) are used to select and return the current index

In multiple selection mode, ENTER returns an array of indices. By default, ':selection_mode' is ':single'. It may also be ':multiple'. Keys for multiple selection need to be confirmed with List widget.

A nil is returned if the user presses 'C-q'.

    if names
        ix = popuplist( names )
        if ix
          value = names[ix]
        end
    end

See dbdemo.rb for usage 




### See also:

The following demos show usage of the above features

- [dbdemo.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/dbdemo.rb)
- [test2.rb](https://github.com/rkumar/rbcurse-extras/blob/master/examples/test2.rb)

The following source links may give further details and customizations.

- [rdialog.rb](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/util/rdialogs.rb)

