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

Next: [Windows](window.md)
