RBCURSE Tutorial
=========

Prev: [Forms and Fields](tut0.md)
Next: [Listboxes](tut2.md)

On the previous page, installation, and creation of basics such as a window, form, fields and labels was demonstrated. Only a few capabilities were shown.



# Buttons

Although buttons are a core component, however the only example that uses all the various types of buttons
is test2.rb which exists inside the rbcurse-extras project. I strongly suggest that you download that project from github, or install the gem and try out test2.rb. (TODO: extract field and button portion from test2.rb into an example in core).

## Creating an action button

A basic button may be created as follows. Name is optional for all widgets, but helps if we wish to change attributes of a widget by name. Otherwise, usually a handle is used. Name is also often used in debug listings.

      ok_button = Button.new @form do
        text "OK"
        name "OK"
        row 20
        col 20
        mnemonic 'O'
      end


The above creates an OK button that may be pressed, or executed using Alt-o. However, you will want to attach some action to the button. By default, changing of color or attribute while tabbing over etc is taken care of but may be overriden.

      ok_button.command { |form|
        alert("About to dump data into log file!")
        myobject.insert name.getvalue, age.getvalue, password.getvalue
      }


In this case, an alert box has been popped up using a convenience method. However, here is where you could call a method to dump data to a file, or send to a server. In this case, we pretend that you have some object named myobject which can take an array of values and perhaps save the same. See the method `dump_data` in rwidget.rb to get an idea how you can make a method to unroll form objects in a loop and write out their values. dump_data is just a test method, don't use it as it is deprecated.

![Button](http://www.benegal.org/files/nc_button_focus.png "Two buttons")


## Creating a radio button


      row = 3
      col = 4
      $radio = Variable.new

      radio1 = RadioButton.new @form do
        variable $radio
        text "red"
        value "red"
        color "red"
        display_length 18  # helps when right aligning
        row row
        col col
      end

We haven't really discussed Variable and should do so soon. However, typically a global variable is shared across various linked radio buttons. That variable contains the value of what's been selected. Several fields instead of using a buffer of their own use an object called Variable. Variable is an object whose value can be changed, and when changed it triggers actions that have been attached to it. Multiple actions may be attached. 

In the above case, a Variable was used so that some other components could attach their actions using `update_command`. In test2.rb, you may select a color from a set of radio buttons with different colors. Various other labels change their color instantly based on this.

Typically, a radio button is left aligned. If you wish to right-align, then give a display length. A radio buttons alignment may be changed at any time (see test2.rb), although you would rarely want to do so.

[Various Buttons](http://www.benegal.org/files/nc_buttonhotkeys.png)

## Creating a check box

A check box may be created as follows.

      checkbutton = CheckBox.new @form do
        variable $results
        onvalue "Selected bold   "
        offvalue "UNselected bold"
        text "Bold attribute "
        display_length 18  # helps when right aligning
        row row
        col col
        mnemonic 'B'
      end

In the above example, `text` is what is displayed. When selected the onvalue is placed in `variable` which is a Variable. In test2.rb, the variable results has been used as `text_variable` for a Label. Selection of this checkbox, changes the text of that label. However, a Variable is not necessary. `checkbutton.getvalue` will return the value depending on whether checked or not.

TODO - Need to list events and bindings for each component.

## Creating a ToggleButton

A toggle button can have an off or on value. 

      togglebutton = ToggleButton.new @form do
        value  true
        onvalue  " Toggle Down "
        offvalue "  Untoggle   "
        row row
        col col
        mnemonic 'T'
      end

One small catch, ensure that the mnemonic letter is present in both on or off value. Otherwise, it will still be active but will not obviously display. (XXX - cant remember. maybe the same offset will be shown underlined)

## Create a Variable

Variable is a concept taken from the Tk toolkit. A variable is an object whose value may be changed. Upon change, actions that have been attached to it are triggered. This way 2 or more components can be tied together. This concept influenced some of the initial components that were created. Perhaps due to the event driven nature of this toolkit, there are other ways around to do the same without using Variable, by attaching blocks to the dependent component itself. Most of the later components do not give the option of Variable (actually it may not make sense in all). 

Any component that is created with `text_variable` property, will have its change handler fired when the value of the Variable is changed. This ensures that the component is redrawn automatically. In other words, a variable used as text_variable knows all the objects that depend on it.

Variables types allows for Hash and Array in addition to basic types.

(XXX- Note, my memory of Variable is not too good, i could have missed out some stuff).

[Source](prog2.rb)  
[Screenshot](prog2.png) 


[Home](./tut0.md)
Prev: [Forms and Fields](tut0.md)
Next: [Listboxes](tut2.md)

