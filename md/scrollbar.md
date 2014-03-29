# Scrollbars

Last update: 2014-03-28 22:11

A vertical scrollbar may be attached to a multiline widget. This widget is not focusable, and is only a visual element showing how much of the widget is visible and which portion. In other words, the user gets an indication that there is more data.
The scrollbar uses simple data from the parent widget such as current_index and number of rows. That is why this creates only a vertical bar.
Also, the bar is painted over the right border of the parent widget.

## Creating a Scrollbar

There are two ways of creating a vertical scrollbar. We assume we already have a list with a hundred or so items.

    lb = list_box "A list", :list => list

    rb = Scrollbar.new @form, :parent => lb

This is the simplest form. The scrollbar picks up the coordinates from the list or textview or table. It binds a block to the parent object's :ENTER_ROW so it is informed of a change in the current_index. It also binds a block to the :LEAVE of the parent, so it can be repainted after the parent is painted. Otherwise, the parent's border will overwrite the scrollbar.
Please note that the parent object must respond to `current_index` and `row_count` or this approach cannot be used.

The second method is longer and gives full control to the user.

     sb = Scrollbar.new @form, :row => lb.row, :col => lb.col, :length => lb.height, :list_length => lb.row_count, :current_index => 0
      ## .... later as user traverses
      sb.current_index = lb.current_index

In the second way, the scrollbar must be informed of any changes to current_index (and of course row_count) as a user traverses.

## Scrollbar events

-
-
-

## Scrollbar operations

## 


### See also:

Examples:

- 
-
-

Source: [Source]()
