# Labels

A label is a dynamic piece of text. It may be changed in many ways once created. Changes can be triggered from other fields.

      colorlabel = Label.new @form, {'text' => "Select a color:", "row" => 2, "col" => 10, "color"=>"cyan", "mnemonic" => 'S'}

In the example, a mnemonic has been set. Alt-s will put the focus on the field or widget that this focus has been attached to using `label_for`. Other settings are self-explanatory. A label may be multi-line, is may be aligned right or left or center, any of its attributes may be changed at any time, including location (although that's rare, but mentioned to emphasize that unlike ncurses, all widgets may be created or modified at any time).

Next: [Fields](field.md)
