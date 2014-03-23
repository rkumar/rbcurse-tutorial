Windows
=======

## Creating a root window

Typically for an application, you wish to start with a full screen. We use the window class for that.

    @window = VER::Window.root_window

A root window is a window that has zero for all dimensions, thus ncurses stretches it to cover the entire terminal screen.

## Creating a window with dimensions

However, you may also create a window giving it a top, left location and height and width as follows:

        @window = VER::Window.new :height => h, :width => w, :top => t, :left => l

In rbcurse, windows have been used for messageboxes and dialogs. 

## Other details regarding windows

A window may be written to as follows (NOT recommended). The parameters are row, column, string to print, color, and attributes. Other colors that have been created include: errorcolor, promptcolor, reversecolor. See colormap.rb.

    @window.printstring 0, 30, "Demo of Ruby Curses Widgets - rbcurse", $normalcolor, 'reverse'

Attributes are: bold, reverse, normal and underline. blink is present but does not work. underline does not work on a few terminals.

Note that only static text is written directly to a window. This text could get overwritten or erased by another field or print statement. What that means is that for most other purposes a label is recommended. A labels color or text or attribute or alignment or position can be changed at any time, whereas static text cannot be changed. 

The other function of a window is to accept keyboard input in the outer loop and despatch it to the form. The window takes care of decoding function keys and multiple key codes, meta or escape combinations, so a form or component never has to decode.

      while((ch = @window.getchar()) != KEY_F1 )

The above accepts all keys, but exits on an F1.

Remember to call `window.destroy` at the end, so that all ncurses windows, panels etc may be destroyed. This is essential when one window creates another window as not releasing panels could result in a crash.

Next: [Forms](form.md)
