Application Object
==================

The Application object wraps ncurses, logger and other setup and teardown methods. This makes it easy for creating an application or a program without the boiler-plate. However, this may reduce the level of control the programmer may want.

Thus it is advised that you first familiarize yourself with the programmatic style of application before using this wrapper. However, since many examples use the App object, therefore some familiarization with it is essential to under the examples.

The Application object also wraps other methods, features and shortcuts making it quite easy to generate an application with few lines of code. It introduces stacks and flows. Stacks allow for objects to be placed one below the other, with minimal location information. Flows allow objects to be placed to the right of the previous ones, such as buttons. One may also place a stack within a flow, or vice-versa, to get two columns of stacks.

An app object may be declared as follows:

    require 'rbcurse/core/util/app'

    App.new do 
      ## application code comes here
    end # app

== Providing some help

Most of the examples, provide help text on pressing F1. You may declare a method (say help_text) outside the App object. This method returns a string containing the help text.


    def help_text
        <<-eos
        Enter as much help text
        here as you want
        eos
    end

Now we supply this string to the Application system.

    @form.help_manager.help_text = help_text()

The help manager pops up a textview with the help text. There are additional pages in the help text specifying the various keys provided by the application such as F10 or C-q for quitting. Or keys for running an external command, running additional commands specified by this application, or the keys used by various widgets.

If you do not specify any help text, then F1 will still provide the general help for various widgets and the system itself. The App object tries to give uniformity for ones applications.

== Headers and Footers

Typically, most text applications contain an application header and some kind of status line. These two features are available outside of the App object, but in the interest of uniformity should be mentioned here.

    @header = app_header "My App #{MyApp::VERSION}", :text_center => "Yet Another Email Client that sucks", :text_right =>"Some text", :color => :black, :bgcolor => :white

Since we are inside an App block in this example, form does not have to be specified. Also notice the syntax of the header. This is a shortcut to creating an object that you will see a lot in app examples. The text may be changed during application execution, such as when a user traverses a list the text_right is updated with line number, or filename etc.


A status line may also be used to keep displaying some relevant application status at the bottom of the application. This is much like the status line of Vim or Emacs or Tmux.

    status_line 

The above call will create a status line on the last line of the screen.

You will of course want a handle to the same so you can modify it.

    @status_line = status_line

You may specify the row on which it is displayed.

   @statusline = status_line :row => Ncurses.LINES-1

A block may be passed to status_line to execute upon each form refresh. This results in status of application being refreshed constantly. The method command takes arguments and a block which should return a string.

Similarly, the method right() takes a command that will right align the resultant text. If the text returned contains tumux style formatting codes, then the string is displayed using the given colors and attributes.

If no block is specified, then status_line checks the value of a global $status_message and prints that.

The following line is taken from dbdemo.rb in examples. The program has a more complete version. The format code specified a red background and a yellow foreground for that portion of text.

      @statusline.command { 
          "[%-s] %s" % [ "#[bg=red,fg=yellow]Select a Database#[end]", text]
      }

== A skeleton of a program using App


    require 'rbcurse/core/util/app'
    def help_text
        <<-eos
        Enter as much help text
        here as you want
        eos
    end

    App.new do 
        ## application code comes here
        @form.help_manager.help_text = help_text()

        @header = app_header "My App #{MyApp::VERSION}", :text_center => "Yet Another Email Client that sucks", :text_right =>"Some text", :color => :black, :bgcolor => :white

        @status_line = status_line
        @status_line.command {

        }
    end # app

=== See also

- [Stacks and Flows](./stackflow.md)
- [Headers](./header.md)
- [Status Line](./statusline.md)
