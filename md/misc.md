Miscellaneous
=============

Contains small helpful features for text and keyboard driven applications.

== Prefix Command

If you wish to attach multiple commands to, say, C-s, using a second key you would do as follows:

  App.new do

      @form.define_prefix_command :csmap, :scope => self
      @form.define_key(:csmap, "r", 'refresh', :refresh )
      @form.define_key(:csmap, "s", 'specification') { specification }
      @form.bind_key ?\C-s, :csmap

  end

The methods refresh and specification have been defined inside the App object. After pressing C-s, pressing r or s would cinvoke these methods.

Please note that C-x has already been used by App and various widgets for mappings. 
App uses M-x (Alt-x) for binding to various functions which can be selected by the user. See abasiclist.rb for an example.

== Shortcuts for widgets

[widgetshortcuts.rb](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/util/widgetshortcuts.rb) contains the latest names of shortcuts for various widgets. If you are using an App object you may find this a more conveneient way of creating objects on the screen. Shortcuts can also help in stacking objects in stacks or flows.

In case you are not using App object, you may create a form named @form and also use shortcuts as in the sample code below.

Some shortcuts are: 

- blank : a blank line between fields in a stack, creates an empty label
- radio : for radio button
- toggle for togglebutton
- check for check button.
- listbox
- progress, label, field, button, textview, textarea, menubar , tree for their respective classes
- dock
- menulink
- link
- table or tabular_widget
- stack
- flow
- box

Some sample code taken from testwsshortcuts.rb is as follows. Since this program did not use the App object, therefore widget_shortcuts_init had to be called to load the shortcuts as well as stack and flow.

The form has already been created. The shortcuts are first loaded.
`stack` is an object that computes the positions and widths of objects that are created in it. It stacks them one below the other. Only in the case of stacks can ":expand" be used to width, it will compute this value based on the width of the stack.

In order to place objects side by side, like a flow of buttons, we use `flow`.

      def _create_form
        widget_shortcuts_init
        stack :margin_top => 2, :margin_left => 3, :width => 50 , :color => :cyan, :bgcolor => :black do
          label :text => " Details ", :color => :blue, :attr => :reverse, :width => :expand, :justify => :center
          blank
          field :text => "john", :attr => :reverse, :label => "%15s" % ["Name: "]
          field :label => "%15s" % ["Address: "], :width => 15, :attr => :reverse
          check :text => "Using version control", :value => true, :onvalue => "yes", :offvalue => "no"
          check :text => "Upgraded to Lion", :value => false, :onvalue => "yes", :offvalue => "no"
          blank
          radio :text => "Linux", :value => "LIN", :group => :os
          radio :text => "OSX", :value => "OSX", :group => :os
          radio :text => "Window", :value => "Win", :group => :os
          flow :margin_top => 2, :margin_left => 4, :item_width => 15  do
            button :text => "Ok" do throw :close; end
            button :text => "Cancel"
            button :text => "Apply"
          end
        end
      end

== Dialogs

== Text Popups

== The Help System

== Displaying exceptions

== Color formatting of text

== Key Label Printer or Dock

This mimics the bottom 2 lines of Pine/Alpine email client, or calcurse. You may specify labels and hotkeys and their respective actions. You may have context sensitive KLP's. These are also called "docks" for short. Docks may have keys added or removed from them at any stage of the application.
A dock may contain any number of modes (the first and default being :normal, unless specified). Each mode has keys and lables associated with it. Changing the mode is enough to change the labels displayed at the bottom.

Usually when a dock is used, the status line is placed above it.
