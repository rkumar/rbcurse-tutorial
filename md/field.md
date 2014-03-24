# Fields (Text fields)

![Fields](http://www.benegal.org/files/nc_labelhotkey.png)

An entry field may be created as follows.

    r = 1
    fc = 10

    f3 = Field.new @form
    f3.name("mobile").display_length(20).bgcolor(:white).color(:black).
      text("").label('  Mobile: ').
      row(r).col(fc).
      type(:integer)

or 

     f3 = Field.new(@form).name("Address").row(20).col(3)

The above is the conventional way which cannot be deprecate in future revisions. Please use the conventional way as far as possible.

Please note that the `type` method is not currently returning an instance of `self`. That is why it is placed at the end.
This will be fixed in an upcoming version.

There is also a DLS approach which is documented a lot but i advise against, as I would like to remove it in a future version.

        field = Field.new @form do
          name   "Name"
          row  5 
          col  12 
          display_length  30
          bgcolor :cyan
          set_label Label.new @form, {:text => "Name", :color =>:cyan, :mnemonic => 'N'}
        end

There is another way of creating fields (and widgets) using the config hash.

    f1 = Field.new @form,  :name => "name1", :maxlen => 20, :display_length => 20, :bgcolor => :white, 
      :color => :black, :text => "abc", :label => ' Name: ', :row => r, :col => fc

Most new examples use the config approach. I would recommend you avoid this, also. 

The above shows some very basic settings of a field. There are plenty more which are used in the examples, such as testfields.rb (see examples folder). This example shows creating a label along with the field. The label is automatically attached to the field, so that the mnemonic key puts focus onto the field. A label may be attached later, too. Other widgets may not have a `set_label`, so `label_for` may be used to attach to them.

You may traverse using tab and back-tab as well as the mnemonics. 

## Field labels

There are two ways to set the label related to a field. The `set_label` method takes a Label or a String. If a string is given it creates a label. The label may be manipulated using all the methods of a label. However, the `col` specified will be the column of the field, and the label is placed to the left. 

The other way is use the method `label` which sets a string. When you use this approach, the `col` supplied will be the column of this string. The field will be placed after the label. You will have more control on where the label starts but you will have to align, or pad the label. You can understand this by seeing the output of testfields.rb.

When you use `label` as a method, you may also use `label_color_pair` and `label_attr` to get a little more control over the label, but you cannot use the label as a widget.

If you need a lot of control over the label, use `set_label`, otherwise just use the `label` method.

## Other Field properties

`Field` has many properties, some of them are mentioned here.

*  display_length  - how much is displayed, rest is scrolled 

*  maxlen          - maximum length allowed for entry  (Note: rename?)

*  set_buffer      - set a value into field (as in original_value)  (Note: rename?)

*  chars_allowed   - what characters are allowed (e.g. /\d/ ) to be entered
                     This works at the time of input

*  valid_regex     - regex to validate entry when user tabs out.

*  show            - what character to show when entry (useful for password fields) 

*  color           - foreground color 

*  bgcolor         - background color 

*  values          - list of allowed values  (Note: overkill ?)

*  null_allowed    - boolean, whether one can tab out leaving field empty 

*  type            - datatype such as :integer, :numeric, :float, :alpha and :alnum
                     Integer allows only whole numbers, numeric and float allow decimals.
                     Alpha allows only A-Z chars, no numbers.
                     Alphanumeric allows characters and numbers.

`type` internally uses `chars_allowed`, so for more complex cases, you may use `chars_allowed`. This does not allow the user to type characters outside the given range. `valid_regex` does not work at entry time, but upon leaving the field.

For example of usage of these properties, see test2.rb or testfields.rb

Next: [Buttons](button.md)
[Source](https://github.com/rkumar/rbcurse-core/blob/master/examples/testfields.rb)  

