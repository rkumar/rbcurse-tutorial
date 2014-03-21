# Table and Tabular data

There are two approaches to displaying tabular data. If you have static data, and do not need to allow the user to change columns, or modify column data etc. you might consider using a Tabular object which formats the data and uses a List or Textview to display it. If you need columns, then you will require the TabularWidget.

## Tabular

For simple static data, consider putting your rows and columns into a Tabular object. The render method will format the data with given separators, and then you may use a List or Textview to display the same. If you want single or multiple selection of rows, you may prefer to place the data in a listbox. If you do not want selection, you may prefer putting the data in a textview.

In these examples, it is assumed that a Listbox named listbox has been created.
In the first two examples, data is placed into Tabular as an array of arrays with no header.

      t = Tabular.new(['a', 'b'], [1, 2], [3, 4])
      listbox.list(t.render)

      t = Tabular.new ['a', 'b']
      t << [1, 2]
      t << [3, 4]
      t << [4, 6]
      listbox.list(t.render)

In this example, a header has been supplied for the Tabular. The header results in a separator being printed after the header.

    file = "data/tasks.csv"
    lines = File.open(file,'r').readlines 
    heads = %w[ id sta type prio title ]
    t = Tabular.new do |t|
      t.headings = heads
      lines.each { |e| t.add_row e.split '|'   }
    end
    listbox.list(t.render)

The example term2.rb, uses Tabular inside a textview and listbox. However, term2.rb uses the Application object which we have not yet discussed.

dbdemo.rb uses Tabular to popup the results of an sql statement in just a few lines of code.

Assume we have the column names in $columns and the data in content (an array of arrays).

    require 'rbcurse/core/widgets/tabular'
    t = Tabular.new do |t|
      t.headings = $columns
      t.data=content   
    end
    view t.render

`view` is a method (available globally) that pops up a textview with the data provided, allowing traversal, search etc.
## TabularWidget

The TabularWidget is a multirow widget with data displayed in rows and columms. The columns may be resized, moved,
used for sorting, hidden, aligned etc. However, as in Lists, inline editing of columns is not provided to keep the code-base simple.

However, a user may be given keys to delete a row. The example, tabular.rb, shows how the entire row can be popped up in a popup window and each field edited in a textfield. Similarly, to insert a row, the same popup window allows entry of each field and then inserts the row at the location.

    t = TabularWidget.new @form, :row => 2, :col => 2, :height => 20, :width => 30
    t.columns = ["Name ", "Age ", " Email        "]
    t.add %w{ rahul 33 r@ruby.org }
    t << %w{ _why 133 j@gnu.org }
    t << ["jane", "1331", "jane@gnu.org" ]
    t.column_align 1, :right
    t.create_default_sorter

    s = TabularWidget.new @form, :row => 2, :col =>32  do |b|
      b.columns = %w{ country continent text }
      b << ["india","asia","a warm country" ] 
      b << ["japan","asia","a cool country" ] 
      b << ["russia","europe","a hot country" ] 
      #b.column_width 2, 30
    end
    s.create_default_sorter

      b.column_width 0, 12
      b.column_width 1, 12
      b.column_hidden 1, true


      link programs. and put screenshots.

https://github.com/rkumar/rbcurse-core/tree/master/examples
https://github.com/rkumar/rbcurse-core/tree/master/lib/rbcurse/core/widgets
https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/tabular.rb
https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/tabularwidget.rb
https://github.com/rkumar/rbcurse-core/blob/master/examples/tabular.rb
ihttps://github.com/rkumar/rbcurse-core/blob/master/examples/term2.rb

