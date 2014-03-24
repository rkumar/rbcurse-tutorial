# Widgets

Widget is the parent class for all widgets. Since a program will not create an instance of Widget but of a subclass, therefore this page only discusses general behavior inherited by all widgets.

### Methods

Common attributes of widgets include row, col, color, bgcolor, enabled, focusable, attr (ncurses attribute such as :BOLD, :REVERSE), visible, help_text, hide, show, focus (set focus), width, height, `bind_key`, `unbind_key`, `bind`(event). 

`height` is only applicable to multiline widgets such as textview and list and table. 
`text` is applicable to some widgets and is used for uniformity. Field, label, textview and button are examples of widgetsthat use `text`.

### Events

- :ENTER
- :LEAVE
- :CHANGED
- :PROPERTY_CHANGE

### Others

#### Widget level menu
   
   Each widget (often called field in the documentation even though there is a widget named Field) may have its own menu of actions.
   Calling the `action_manager` method on the widget returns an instance of ActionManager. One may then add Action objects to it, which will get shown in a menu form on pressing "M-:", Alt and ":". See rtextview.rb for an example.

      editor = ENV['EDITOR'] || 'vi'
      am = action_manager()
      am.add_action( Action.new("&Edit in #{editor} ") { edit_external } )
      am.add_action( Action.new("&Saveas") { saveas() })

In the above case, while inside a textview, pressing Alt and ":" prompts the user to edit the contents in his editor of choice, or to save the content to a file.
