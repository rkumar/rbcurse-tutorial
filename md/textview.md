Rbcurse-core Tutorial
=========

Prev: [Lists](list.md)
Next: [Tables](table.md)

This page shows how to create text views, populate them, update them, and bind events to actions.
A textview is not editable by the user. The data may be programatically changed. However, the user can traverse the textbox. A text box is used to display multiple lines of text. It is scrollable both horizontally and vertically.

rbcurse-extras has a functional textarea that allows editing. However, it is advised that for editing large text, a program shells the data to an external editor. There are examples of this. This is more reliable. 



# Textviews - Multiline text objects


## Creating a textview

      tv = RubyCurses::TextView.new @form, :row => r, :col => w, :height => h, :width => FFI::NCurses.COLS-w-1,
      :name => "tv", :title => "Press Enter on method"
      tv.set_content anArray

The above lines create a textview of the given dimensions and then sets the content with an array. 
The purpose of the name is for another method to get the handle and modify the content.

Textviews come with keys mapped to enable quick movement and scrolling. There are options for Emacs and Vim keys.
There is a key for discovering the keys mapped in any object (press "?" or M-? on a textview).

Textviews can be extended to contain multiple buffers. A user can cycle through those buffers. This helps in creating something like a help system, or documentation.


      require 'rbcurse/core/include/multibuffer'
      tv.extend(RubyCurses::MultiBuffers)

The above lines extend the previously created textview with multibuffer capability. The add_content method can be used to create a new page or buffer. In the following snippet, another object retrieves the handle of this textview in its PRESS event, and adds a new buffer to the textview.


        w = @form.by_name["tv"]; 
        lines = `ri -f bs #{listb.text}`.split("\n")
        w.add_content(lines, :content_type => :ansi, :title => listb.text)
        ## make the last buffer (newly added one) the visible one
        w.buffer_last

In the example above, the content type of the data contained ANSI codes, so we specify the format to textview so it can format the data accordingly. If the data was pure text, then add_content(array) would suffice.

Textviews can print in two formats other than the plain/vanilla two color format. One is ANSI and the other is called TMUX. It is based on the tmux format for status lines and is as follows:


    # Currently, assumes colors and attributes are correct. No error checking or fancy stuff.
    #  s="#[fg=green]hello there#[fg=yellow, bg=black, dim]"

Please see colorparser.rb in rbcurse-core/lib/util for the code and any more details. There are many examples of using tmux format in the examples, both in textviews and in the status line. 

tmux formatting allows embedding of color within color for example, and is thus superior to the ncurses style of color or attribute formatting. In ncurses, if you change the color or style for one word, then the previous style is lost. This allows us to have a textview that shows formatted code, or some documentation, of coloring for headers etc.

ANSI format is inferior, but allows us to take ANSI formatted output of other commands and display them without the programmer having to decode the format.

Most applications will be making heavy usage of lists and textviews thus it is advised to study the methods from the documentation, or source code at this point. Also, we recommend you see all the examples of lists and textviews before proceeding. 

It is for this reason that inline editing was removed from lists, text objects and tables, so that the code base could be simple and stable. It was felt that there would be few use cases for inline editing, and those could use the widgets from extras and experimental. Inline editing essentially means that we are writing an editor for the widget, with wrapping and other complexities, and we felt that is best left for an external editor.

rbcurse-core tries to hit the 80% usage of console applications, leaving other complex widgets for the extras and experimental project.

## Textview Events

In addition to the events exposed by Widget such as ENTER and LEAVE, Textview exposes ENTER_ROW, CHANGE and PRESS

PRESS is useful for performing some function when the user presses ENTER on a line or word. The example testlistbox.rb uses `word_under_cursor` to popup documentation for a method. If you place tabular data inside a textview (say using Tabular), you may use this to sort a column based on which column the user pressed ENTER on, if he is on the first row.

CHANGE is useful since we often include `Vieditable` on textviews. This allows editing via VIM keys (deleting a line, editing a line at the bottom of the screen in a textfield, or inserting a line after taking input in a textfield at bottom of screen).

## Textview popups

This is useful for popping up some large, multi-line text. In many programs, the exception is popped up using this.

You may just pass an exception object in the form of:

    textdialog err

This method checks for an exception object and treats it as:

    textdialog [err.to_s, *err.backtrace], :title => "Exception"

Title is optional, and defaults to "Alert".

An example from abasiclist.rb is:

    textdialog(%x[ gem specification #{name} ].split("\n") , :title => 'Specification')

dbdemo.rb displays the result of the SQL statement in a textdialog.

Prev: [Lists](list.md)
Next: [Tables](table.md)
