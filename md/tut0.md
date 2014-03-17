Rbcurse Tutorial
=========

| Prev: | [Home](README.md) | Next: [Buttons](tut1.html) |

The following is a simple introduction to [rbcurse-core ](https://github.com/rkumar/rbcurse-core), a ruby ncurses windowing toolkit to create "graphical" user interfaces for terminals or character based interfaces. For more details, please refer examples in the examples folder of the distribution. 

I am in the process of updating this tutorial based on an ancient tutorial which lies on rubyforge which I can no longer update due to some "Permission denied (publickey,gssapi-keyex,gssapi-with-mic)" error. 



Installation
============

It is best to have ruby 1.9.1 or higher (latest) installed. If you are using 1.8.7 and you face any issues, please report.
If you use both versions, you will have to install both gems under both version. 

rbcurse can be installed as follows:

    gem install rbcurse-core

rbcurse-core depends on ffi-ncurses only, which should get installed as a dependency. 


Please try out some examples, preferable test2.rb in the examples directory.
   
    cd examples
    ruby test2.rb

If you any problems running these examples, the first step is to run the examples in the ffi-ncurses gem to see that there is no issue in ncurses or ffi-ncurses install. The examples require write access in the current folder (configurable) for the log file.

Here's a screenshot of [test2.rb](http://www.benegal.org/files/screen/nc_screenshot_122508.png). At this point, you have a working version of rbcurse.

Approaches to Application Creation
==================================

There are two ways of creating an application. In the first, all the setup and teardown is done by the programmer. In the second, the setup and teardown of ncurses, is taken care of by an App object. We recommend that you first get used to doing the setup yourself. Once you are familiar, you can try out the simpler App wrapper.

Basic Setup
===========

The following are the minimal requires for a program. Since rbcurse logs internally, a logger must be instantiated. rwidget contains some basic widgets such as field, button and label.

    require 'ncurses'
    require 'logger'
    require 'rbcurse'
    require 'rbcurse/rwidget'

### Curses setup

This initializes colors, keys and various other setting such as delay, cbreak etc so that control and other keys may be used.

    VER::start_ncurses  


## Creating a root window

Typically for an application, you wish to start with a full screen. We use the window class for that.

    @window = VER::Window.root_window

A window may be written to as follows. The parameters are row, column, string to print, color, and attributes. Other colors that have been created include: errorcolor, promptcolor, reversecolor. See colormap.rb.

    @window.printstring 0, 30, "Demo of Ruby Curses Widgets - rbcurse", $normalcolor, 'reverse'

Attributes are: bold, reverse, normal and underline. blink is present but does not work. underline does not work on a few terminals.

Note that only static text is written directly to a window. This text could get overwritten or erased by another field or print statement. What that means is that for most other purposes a label is recommended. A labels color or text or attribute or alignment or position can be changed at any time, whereas static text cannot be changed. 

The other function of a form is to accept keyboard input in the outer loop and despatch it to the form. The window takes care of decoding function keys and multiple key codes, meta or escape combinations, so a form or component never has to decode.

      while((ch = @window.getchar()) != KEY_F1 )

The above accepts all keys, but exits on an F1.
Remember to call `window.destroy` at the end, so that all ncurses windows, panels etc may be destroyed. This is essential when one window creates another window as not releasing panels could result in a crash.

## Forms

Typically we want more control over what is printed. We want user entry and navigation. Thus one or more forms may be created using a window. A form uses a window to write to. It is a container for various components.

      @form = Form.new @window

Within the outer loop, the form handles each key, sending it to the relevant component for further handling.

      @form.handle_key(ch)

Only if a key is unhandled by the focused component, does the form process it. Actions may be mapped to keystrokes caught by all components and the Form too. Actions may be bound to Form events, too. (XXX)


Form events include ENTER and LEAVE. These actually apply to all components of a form. This allows us to attach an action to all fields of a form on entry and exit of that component. This can be used to change the background of the label of the focused field as in test2.rb, or to save values to a structure etc.

      @form.bind(:ENTER) { |f|   f.label && f.label.bgcolor = 'red' if f.respond_to? :label}
      @form.bind(:LEAVE) { |f|  f.label && f.label.bgcolor = 'black'   if f.respond_to? :label}

## Labels

A label is a dynamic piece of text. Its may be changed in many ways once created. Changed can be triggered from other fields.

      colorlabel = Label.new @form, {'text' => "Select a color:", "row" => 2, "col" => 10, "color"=>"cyan", "mnemonic" => 'S'}

In the example, a mnemonic has been set. Alt-s will put the focus on the field or widget that this focus has been attached to using `label_for`. Other settings are self-explanatory. A label may be multi-line, is may be aligned right or left or center, any of its attributes may be changed at any time, including location (although that's rare, but mentioned to emphasize that unlike ncurses, all widgets may be created or modified at any time).

## Fields (Text fields)

![Fields](http://www.benegal.org/files/nc_labelhotkey.png)

An entry field may be created as follows.

        field = Field.new @form do
          name   "Name"
          row  5 
          col  12 
          display_length  30
          set_label Label.new @form, {'text' => "Name", 'color'=>'cyan','mnemonic'=> 'N'}
        end

The above shows some very basic settings of a field. There are plenty more which are used in the examples, such as test2.rb. This example shows creating a label along with the field. The label is automatically attached to the field, so that the mnemonic key puts focus onto the field. A label may be attached later, too. Other widgets may not have a set_label, so label_for may be used to attach to them.

The above has been put together in prog1.rb in which several fields are created in a loop. You may traverse using tab and back-tab as well as the mnemonics. Not much else you can do since this is the very basic screen. 


## Other Field properties

`Field` has many properties, some of them are mentioned here.

*  display_length  - how much is displayed, rest is scrolled 

*  maxlen          - maximum length allowed for entry  (Note: rename?)

*  set_buffer      - set a value into field (as in original_value)  (Note: rename?)

*  chars_allowed   - what characters are allowed (e.g. /\d/ ) 

*  valid_regex     - regex to validate entry 

*  show            - what character to show when entry (useful for password fields) 

*  color           - foreground color 

*  bgcolor         - background color 

*  values          - list of allowed values  (Note: overkill ?)

*  null_allowed    - boolean, whether one can tab out leaving field empty 

For example of usage of these properties, see test2.rb

[Source](prog1.rb)  
[Screenshot](prog1.png) 


[Home](./tut0.md)
Prev: []()
Next: [Buttons](tut1.html)

| Table | of | Contents |
| :------------ |:---------------:| -----:|
| Prev: | [Home](README.md) | Next: [Buttons](tut1.html) |
