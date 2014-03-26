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

## WIDGET events

-
-
-

## 


### See also:

-
-

