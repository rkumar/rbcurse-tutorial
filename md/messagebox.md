# MessageBox

Last update: 2014-03-27 16:04

A messagebox is a popup window with a form and buttons. The widgets may be specified, as well as the button/s. Messageboxes are used internally in dialogs for getting a string, getting a confirmation, or alerting a user.

## Creating a MessageBox

The `add` (aka `item`) method is used to add widgets to the messagebox. `button_type` is used to specify which combination of buttons are required such as ':ok_cancel', ':ok' etc. The `message` method creates a label and is used for short strings that will fit within the width of the window. The `text` method is to be used if displaying a long string or array, especially if the size of the string is not known. `text` uses a TextView so allows scrolling, searching, etc,, and thus takes focus unlike `message`.

MessageBox's `run` method is called which returns the index of the button clicked, from which it can be ascertained if the user pressed Ok or Cancel. It is recommended to check for Ok and Cancel before proceeding.

This is a simple example that prompts the user to enter a name. It is similar to the `get_string` utility method, except that it adds some validations.

      mb = RubyCurses::MessageBox.new do
        title "Enter your name"
      
        message "Enter your first name. Initcaps "
        add Field.new :chars_allowed => /[^0-9xyz]/, :valid_regex => /^[A-Z][a-z]*/, 
            :default => "Matz", :bgcolor => :cyan
        button_type :ok_cancel
      end

The caller may retrieve the text entered in two ways, by name of widget or widget index.

    mb.widget(1).text
    mb.widget("name").text

In the above example, we did not name the field, so we must use the index.

in the following example, a list of names is displayed in a popup with a label, for the user to select. Two elements have been preselected perhaps as defaults.

Since the list has been created outside the messagebox and we have the handle "l" to it, we may call `l.selected_indices` to determine the selection. However, we may also retrieve the list with it's name using `@mb.widget(name)` and then call `n.selected_indices`.

        require 'rbcurse/core/widgets/rlist'
        nn = "mylist"
        l = List.new  nil, :row => 2, :col => 5, :list => %w[john tim lee wong rahul edward why chad andy], 
          :selection_mode => :multiple, :height => 10, :width => 20 , :selected_color => :green, :selected_bgcolor => :white, :selected_indices => [2,6], :name => nn

      @mb = MessageBox.new :width => 30, :height => 18 do
        title "Select a name"
        button_type :ok_cancel
        item Label.new :row => 1, :col => 1, :text => "Enter your name:"
        item l
  
      end
      @mb.run
      $log.debug "XXX:  #{l.selected_indices}  "
      n = @mb.widget(nn)
      $log.debug "XXXX:  #{n.selected_indices}, #{n.name}  "


This is a slightly larger example with check boxes and radio buttons. Upon entering the field, a list of names is popped up and the selected value placed in the field.

      mb = MessageBox.new :title => "HTTP Configuration" , :width => 50 do
        add Field.new :label => 'User', :name => "user", :display_length => 30, :bgcolor => :cyan
        add CheckBox.new :text => "No &frames", :onvalue => "Selected", :offvalue => "UNselected"
        add CheckBox.new :text => "Use &HTTP/1.0", :value => true
        add CheckBox.new :text => "Use &passive FTP"
        add Label.new    :text => " Language ", :attr => REVERSE
        $radio = RubyCurses::Variable.new
        add RadioButton.new :text => "py&thon", :value => "python", :color => :blue, :variable => $radio
        add RadioButton.new :text => "rub&y", :color => :red, :variable => $radio
        button_type :ok
      end
      field = mb.widget("user")
      field.bind(:ENTER) do |f|   
        listconfig = {'bgcolor' => 'blue', 'color' => 'white'} # not used ??
        users= %w[john tim lee wong rahul edward _why chad andy]
        index = popuplist(users, :relative_to => field, :col => field.col + 6, :width => field.display_length)
        field.set_buffer users[index] if index
      end
      mb.run

The values selected by the user are available by using `mb.widget(offset)` or `mb.widget(name)`.

### A rudimentary file selector

This simple example creates a listbox containing the filename in the current directory. If the user types in the field, then the system is requeried for matching files, and the list filtered accordingly.

        require 'rbcurse/core/widgets/rlist'
        label = Label.new 'text' => 'File', 'mnemonic'=>'F', :row => 3, :col => 5
        field = Field.new :name => "file", :row => 3 , :col => 10, :width => 40, :set_label => label
        
        flist = Dir.glob("*")
        listb = List.new :name => "mylist", :row => 4, :col => 3, :width => 50, :height => 10,
          :list => flist, :title => "File List", :selected_bgcolor => :white, :selected_color => :blue,
          :selection_mode => :single, :border_attrib => REVERSE
        #listb.bind(:ENTER_ROW) { field.set_buffer listb.selected_item }
        field.bind(:CHANGE) do |f|   
          flist = Dir.glob("*"+f.getvalue+"*")
          listb.list flist
        end
        mb = RubyCurses::MessageBox.new :height => 20, :width => 60 do
          title "Sample File Selector"
          add label
          add field
          add listb
          #height 20
          #width 60
          #top 5
          #left 20
          #default_button 0
          button_type :ok_cancel

        end
        mb.run
        $log.debug "MBOX :selected #{listb.selected_item}"

The example can be extended to drill down into a directory if the user selects a directory. Upon pressing Ok, the focussed item can be checked for file or directory.

### Custom buttons

In this example, we create our own buttons instead of using the provided ones. Colors are prompted and user selects a color by pressing on the button.


      @mb = RubyCurses::MessageBox.new do
        title "Color selector"
        message "Select a color"

        r = 3
        c = 2
        %w[&red &green &blue &yellow].each_with_index { |b, i|
          bu =  Button.new :name => b, :text => b, :row => r, :col => c
          bu.command { throw(:close, i) }
          item bu
          c += b.length + 5
        }
      end
      index = @mb.run

Please note that in the case of custom buttons, the messagebox `run` returns whatever value was given in the `throw`, which in this case is the button index.

To use the mnemonics, the user has to press the Alt key with the mnemonic since that is default button behaviour. Menulinks use the key itself as a mnemonic, so one can consider them also.

## MessageBox operations

- message (String) : displays string using a Label
- text (String or Array): displays wrapped String or Array using a Textview (use if size of text is not known)
- add / item (widget) : add a widget
- button_type (symbol) : specify button/s to place. e.g. :ok, :ok_cancel, :ok_apply_cancel, :yes_no, :yes_no_cancel
- default_button (int) : index of button that is selected if user presses ENTER. default 0
- widget (int) : return handle to widget at given offset
- widget (String) : return handle to widget by given name
- run : displays the messagebox and returns offset of button pressed

As mentioned earlier, use `text` if the size of the String is not known. There is currently one difference in behaviour between `text` and `message`, Message uses a label which does not take focus. If ENTER is pressed, the form interprets that as the default button being pressed. However, `text` uses a textview (to enable searching and scrolling), thus it consumes ENTER. Therefore, the user will have to tab out of the text to the button for an ENTER to have effect.

A user may use 'C-q' and 'Esc-Esc' to quit a messagebox in place of pressing Cancel.



### See also:

Examples: [testmessagebox.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/testmessagebox.rb)


Source: [rmessagebox.rb](https://github.com/rkumar/rbcurse-core/blob/master/lib/rbcurse/core/widgets/rmessagebox.rb)
