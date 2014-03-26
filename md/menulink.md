# Menu Links

Last update: 2014-03-27 01:01

The opening page of the Pine/Alpine mail client has a main menu with links to other applications or programs.
These are called MenuLinks in rbcurse-core. MenuLink derives from Link which is in turn derives from Button.

MenuLinks may contain a mnemonic which may be specified with an ampersand in the text. However, if they don't exist in the text they may be specified with ':mnemonic'. MenuLinks contain a description which is printed alongside. Unlike buttons which register an Alt-mnemonic combination with the form object, menu links register the mnemonic itself with the form. 

That is, if 'q' is the mnemonic for Quit, pressing 'q' anywhere on this form quits. Thus, menu links are often the only widgets on the a form.

## Creating a Menu Link

    stack :margin_top => 10, :margin_left => 15 do

      w = 60
      menulink :text => "&View Dirs", :width => w, :description => "View Dirs in tree"  do |s, *stuff|
        message "Pressed #{s.text} "
        load './dirtree.rb'
    
      end
      blank
      menulink :text => "&Tabular", :width => w, :description => "Tabula Rasa"  do |s, *stuff|
        message "Pressed #{s.text} "
        load './tabular.rb'
   
      end
      blank
    end # stack


## Menu Link events

-
-
-

## Menu Link operations

## 


### See also:

alpmenu.rb
-
-

[Source](rlink.rb)
