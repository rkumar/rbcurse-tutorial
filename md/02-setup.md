Approaches to Application Creation
==================================

There are two ways of creating an application. In the first, all the setup and teardown is done by the programmer. In the second, the setup and teardown of ncurses, is taken care of by an App object. We recommend that you first get used to doing the setup yourself. Once you are familiar, you can try out the simpler [App wrapper](./app.md).

rbcurse-core's examples contain examples of both the App object, and the original way. For the original way see [testlistbox.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/testlistbox.rb).

Basic Setup
===========

The following are the minimal requires for a program. Since rbcurse logs internally, a logger must be instantiated. rwidget contains some basic widgets such as field, button and label.

    ```ruby
    require 'logger'
    ## this includes ffi-ncurses, window, Form and the basic widgets such as field and button, 
    ## as well as dialog
    require 'rbcurse'
    ```

If you are using additional widgets such as listbox or textview, you will require them as follows:

    ```ruby
    require 'rbcurse/core/widgets/rlist'
    require 'rbcurse/core/widgets/rtextview'
    ```

### Curses setup

This initializes colors, keys and various other setting such as delay, cbreak etc so that control and other keys may be used.

    VER::start_ncurses  

### Logger setup

Setting up the logger is critical, rbcurse uses it. You may however modify the location
and the log level. 

    $log = Logger.new((File.join(ENV["LOGDIR"] || "./" ,"rbc13.log")))
    $log.level = Logger::DEBUG

### Widget creation

There are three syntaxes or ways to create widgets.
The first that is much used in documentation and the oldest samples is the DSL approach. I would recommend against using the DSL approach as that may be deprecated in future releases to make the code base simpler.

The DSL form is as follows:
   
        w = Thingie.new @form do
          row 1
          col 3
          text 'hello'
        end

The hash or config form has been used in recent examples and demos a lot. I would like to even remove this form to make the code simpler. However, i am not sure of this since the shortcuts us this form.

        w = Thingie.new @form, :row => 1, :col => 3

The third is the conventional ruby way which cannot be deprecated or changed. I would advise you to use this as much as possible. This form needs to be tested, I suspect the constructor expects various values together. Also, several methods are not returning self, such as text in buttons and mnemonic (fixed in 0.0.15)

        w = Thingie.new(@form).row(1).col(3).
        text('hello').
        color( :cyan ).bgcolor( :white )

Radio button checks for @variable at end of constructor. There could be such cases which necessitate other styles
of construction. Fixed in version 0.0.15.

Next: [Windows](window.md)
