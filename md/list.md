Rbcurse-core Tutorial
=========

Prev: [Buttons](button.md)
Next: [TextViews](textview.md)

This page shows how to create list boxes, populate them, update them, and bind events to listbox actions.
Various ways of navigating a listbox are also shown. Listboxes support single and multiple selection.



# Listboxes

![Listbox](http://www.benegal.org/files/screen/nc_list_edit.png)

## Creating a listbox

NOTE: Added on 2014-03-20. In the original rbcurse, Listboxes and Tables were editable. However, later in rbcurse-core, i simplified code, and moved editable Lists and Table to either rbcurse-extras or rbcurse-experimental. rbcurse-core contains only non-editable lists. That means that data can be programmatically added, deleted or modified, but a user cannot edit inside the row (as is possible in the original version). This change was done to keep the code base of core as simple and clean as possible.


      require 'rbcurse/core/widgets/rlist'

      listb = List.new @form, :name   => "mylist" ,
        :row  => 1 ,
        :col  => 1 ,
        :width => 25,
        :height => 12,
        :list => mylist,
        :selection_mode => :SINGLE,
        :show_selector => true,
        #row_selected_symbol "[X] "
        #row_unselected_symbol "[ ] "
        :title => " Ruby Classes "
        #title_attrib 'reverse'

This creates a list at the given coordinations, populated with an array named mylist. This array has already been populated. Examples of population of list are:

   
      file = "./data/ports.txt"
      mylist = File.open(file,'r').readlines 

or 
      mylist = `ri -l `.split("\n")

Ordinarily, pressing any alphabet will move focus to the first row starting with that character. But to switch this off, you may use:


      listb.one_key_selection = false # this allows us to map keys to methods

An example of this can be seen in testlistbox.rb. We wish to use Vim's navigation keys, so we disable one_key_selection in that example. It also maps pressing of ENTER key to run a command on the value on that row. The text() method returns the value of the row which has focus.


      listb.bind(:PRESS) { 
          #  do something with listb.text
      }

The events mapped are ENTER_ROW, LEAVE_ROW, LIST_SELECTION_EVENT and PRESS. ENTER_ROW and LEAVE_ROW can be used
to synch movement in this list with some other widget such as a textview. Events inherited from Widget are ENTER, LEAVE, CHANGED and PROPERTY_CHANGE.

the attribute current_index gives you the index of the focussed row. selected_index and selected indices will give you the selection, depending on SINGLE or MULTIPLE selection.

Other methods of interest are:

- list : to supply values as an array or list_data_model
- []   : to get value at an offset
- append : append a value to the list
- remove_all: remove all values

Other methods are similar to their Array counterpart: insert, clear, delete_at, []= and <<.
The methods current_value and text both return the focussed value.

NOTE: The following relates to the old rbcurse project. Listbox is now part of rbcurse-extras.

A listbox can be created with list data contained in an array. It may also be passed a list_variable which is a Variable object created with an array. Changes to original array do not affect the listbox. The listbox uses a model-controller architecture. Changes to the original array will not fire events bound on the listbox. To insert objects into a Listbox after creation, please use either `insert` of the listbox or its data model. 

A list manages scrolling and paging of data. Lists can be editable or readonly.

First create a list of 100 items.

        mylist = []
        0.upto(100) { |v| mylist << "#{v} scrollable data" }
        $listdata = Variable.new mylist

Create a list box giving it the array, or list variable. You may select single or multiple selection, symbol to display when selecting or deselecting, and whether editing is allowed.


        listb = Listbox.new @form do
          name   "mylist" 
          row  r 
          col  1 
          width 40
          height 11
          #list mylist
          list_variable $listdata
          #selection_mode :SINGLE
          show_selector true
          row_selected_symbol "[X] "
          row_unselected_symbol "[ ] "
          title "A long list"
          title_attrib 'reverse'
          cell_editing_allowed true
        end

The following are three ways of inserting data into the listbox at offset 55.

        listb.insert 55, "hello ruby", "so long pypy", "farewell java", "RIP .Net"
        $listdata.value.insert 55, "hello ruby", "so long XML", "farewell j2ee", "RIP jsp"
        listb.list_data_model.insert 55, "hello ruby", "so long perl", "farewell java", "RIP .Net", "hi lisp"


### Listbox events

Binding an event to when focus enters a row. The list and the given object are passed to the block. ENTER_ROW and LEAVE_ROW are two navigational events.

        listb.bind(:ENTER_ROW, @textview) { |alist, tview| tview.top_row alist.current_index }

A ListDataEvent is fired whenever a row is added, appended, deleted or modified. This also holds true for when the entire list is deleted. An action can be bound to :LIST_DATA_EVENT, the event object's type reveals CONTENT_CHANGED, INTERVAL_ADDED or INTERVAL_REMOVED. See rlistbox.rb.

### ListDataModel

A data model may be created as follows. One may then attach actions to it.

      list = ListDataModel.new( %w[spotty tiger panther jaguar leopard ocelot lion])
      list.bind(:LIST_DATA_EVENT) { |lde| $message.value = lde.to_s; "  } 
      list.bind(:ENTER_ROW) { |obj| $message.value = "ENTER_ROW :#{obj.current_index} : #{obj.selected_item} "; }

A listbox may then be created with this data model. This technique is not required when creating a Listbox since one can get the data model and attach actions to it. However, when an object internally creates a list such as a combobox or message box, then this may be required. XXX CONFIRM.

### Listbox navigation

The usual arrow keys, and C-n and C-p work for paging. The select key is typically "C-x" (confirm this XXX). C-a and C-e work within a line for beginning and end. Beginning and end of list are XXX. "/" will prompt user with a search dialog.

Earlier, in a readonly list, pressing a key would take the cursor to the first row whose data started with that key. So pressing "x" would go to the first row starting with "x". In order to make this more keyboard friendly, in readonly lists, now "_f_x" (as in vim's f for forward) will do the same job. This frees other keys such as j and k for navigation. The user may map single or double keys (gg for start) as needed.


Listboxes and Tables have 2 modes of editing. In one a field is editable as one enters. Exiting saves the cell. Escape or C-c reverts change. In another mode, pressing Enter on a field makes it editable. For rare edits, this would be better since enhanced vim-like navigation can be used. 

prog3.rb shows a listbox, with multiple selection and editing. Using the toggle buttons, one may make the list readonly, single selection, and switch on Vim-keys. If the list is readonly and Vim-key enabled, motion commands such as 5j, 10k, gg, G, and C-u k will work in addition to arrow keys. (C-u is the emacs numeric multiplier and has values of 4, 16, 64 for each consecutive press). (For vim keys, the multiplier will not work in 1.1.1. Please get latest code from github or try a higher gem if loaded.). Small typo!



Prev: [Buttons](button.md)
Next: [TextViews](textview.md)
