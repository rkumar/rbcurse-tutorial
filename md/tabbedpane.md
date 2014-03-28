# TabbedPane

Last update: 2014-03-28 20:46

A tabbed pane contains several tabs. Each tab relates to a form or "page". Only one "page" can be viewed at a time. Each ppage contains several widgets.

A TabbedPane is like any other widget, and may be embedded inside a form along with other widgets. However, the usual usage is to place it on a window with buttons such as Ok, Apply and Cancel. This window is popped up from an application. Thus, a TabbedWindow is provided also.

A tabbed window internally sets up a window with a tabbed pane and three buttons: ok, apply and cancel.

## Creating a TabbedWindow

The basic skeleton of a creating a TabbedWindow is as follows:


    tp = TabbedWindow.new :row => 3, :col => 7, :width => 60, :height => 20 do
      title "User Setup"
      button_type :ok_apply_cancel

      tab "&Profile" do
      end
      tab "&Settings" do
      end

      command do |eve|
        alert "user pressed button index:#{eve.event} , Name: #{eve.action_command}, Tab: #{eve.source.current_tab} "
        case eve.event
        when 0,2                   # ok cancel
          throw :close, eve.event
        when 1                     # apply
        end
      end
    end
    buttonindex = tp.run

There will be multiple `tab` blocks. The command block specifies the action to be performed upon clicking a button. `eve.event` contains the offset of the button pressed. `eve.source.current_tab` is the offset of the tab which is required if Apply was pressed.

Items are added to a tab using `add` or `item` as follows:

      tab "&Settings" do
        item Label.new nil, :text => "Text", :row => 1, :col => 2, :attr => 'bold'
        item CheckBox.new nil, :row => 2, :col => 2, :text => "Antialias text"
        item CheckBox.new nil, :row => 3, :col => 2, :text => "Use bold fonts"
        item CheckBox.new nil, :row => 4, :col => 2, :text => "Allow blinking text"
        item CheckBox.new nil, :row => 5, :col => 2, :text => "Display ANSI Colors"
      end

For the complete example, see [newtabbedwindow](https://github.com/rkumar/rbcurse-core/blob/master/examples/newtabbedwindow.rb)

## Creating a TabbedPane

A tabbed pane uses similar methods as a TabbedWindow.

      tp = RubyCurses::TabbedPane.new @form, :height => 12, :width  => 50,
        :row => 13, :col => 10 do
      end

      tp.add_tab "&Language" do
      end

`add_tab` is a synonym for `tab`, just as `add` is a synonym for `item`.

When used inside a block, a noun such as `item` and `tab` seems more appropriate. When used as a method call, a verb such as `add` or `add_tab` seems right.

Thus one may add widgets to a tab in the following ways:

      tp.add_tab "&Language" do
          item Field.new ....
      end

Or get a handle to the tab as follows:

    tab1 = tp.add_tab "&Language"
    tab1.add Field.new ...


## TabbedPane events

This widget does not expose any events at present. These can be added upon request, if required.
The deprecated tabbedpane in rburse's deprecated folder contains the events that would be added: these relate to creation, deletion and opening of tabs.

The tabs themselves are based on radio buttons, so the events of radio buttons may be used. Use the `button` method on a tab to access its RadioButton object to bind to it's events.

## TabbedPane operations

- tab(title, config, block)  : alias `add_tab` adds a tab to the pane. Title is a string such as "&Language". 
- insert_tab(index, title, config, block - inserts a tab at given index
- remove_tab(tab) - removes given tab
- remove_all - removes all tabs
- remove_tab_at(index) - remove tab at index
- command (attach processing to pressing of action buttons (Ok, Cancel) in a TabbedWindow. Calls the :PRESS of the button.

Tab includes the following operations:

- item(Widget) : add a widget to the tab
- widgets : access the widgets (Array)
- button : retrieve the button associated with the Tab to bind to it's events


## 


### See also:

Examples:

- [newtabbedwindow](https://github.com/rkumar/rbcurse-core/blob/master/examples/newtabbedwindow.rb)
- [tabbedpane](https://github.com/rkumar/rbcurse-core/blob/master/examples/newtesttabp.rb)


Source: 
- [TabbedWindow](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/rtabbedwindow.rb)
- [TabbedPane](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/rtabbedpane.rb)
