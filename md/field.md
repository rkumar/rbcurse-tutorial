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

The above shows some very basic settings of a field. There are plenty more which are used in the examples, such as test2.rb (see rbcurse-extras). This example shows creating a label along with the field. The label is automatically attached to the field, so that the mnemonic key puts focus onto the field. A label may be attached later, too. Other widgets may not have a set_label, so label_for may be used to attach to them.

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

Next: [Buttons](button.md)
[Source](prog1.rb)  
[Screenshot](prog1.png) 

