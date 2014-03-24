Prev: [Tables](table.md)
Next: [????](list.md)


# Trees

Trees show data in a heirarchical structure allowign the user to expand or collapse branches.

[atree.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/atree.rb) shows various kinds of tree.

Another example is [testree.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/testree.rb).

## Creating a tree 

The basic form of creating a Tree like all widgets is:

    Tree.new @form, config, &block

### The Java-ish way of creating a tree is as follows:


          ## We first create the nodes
          ## Then we create a model
          ## Finally we create a tree with the model

          root    =  TreeNode.new "ROOT"
          subroot =  TreeNode.new "subroot"
          leaf1   =  TreeNode.new "leaf 1"
          leaf2   =  TreeNode.new "leaf 2"
          model = DefaultTreeModel.new root

          # model.insert_node_into(subroot, root,  0)  # BLEAH JAVA !!


          # slightly better, since we return self in ruby
          root << subroot
          subroot << leaf1 << leaf2
          leaf1 << "leaf11"
          leaf1 << "leaf12"

          # more rubyish way
          root.add "blocky", true do 
            add "block2"
            add "block3" do
              add "block31"
            end
          end

          ## now we create a tree giving it the model we created.
          tree :data => model, :title => "[ legacy way ]"
          # above line is using the tree shortcut inside a stack or flow

### A Rubyish way of creating a tree

The following code is inside a stack, so the form is assumed to be @form

          atree = tree :height => 10, :title => '[ ruby way ]'  do
            root "root" do
              branch "hello" do
                leaf "ruby"
              end
              branch "goodbye" do
                leaf "java"
                leaf "verbosity"
              end
            end
          end

The advantage of the block or DSL way is that the structure is visible and there is no chance of forgetting to place a node. A branch contains further children whereas a leaf does not.

### Creating a tree from a hash

If your heirarchical data is in a hash/dict format, you can pass that to tree.

          # using a Hash
          model = { :ruby => [ "jruby", {:mri => %W[ 1.8.6 1.8.7]}, {:yarv => %W[1.9.1 1.9.2]}, "rubinius", "macruby" ], :python => %W[ cpython jython laden-swallow ] }
          tree :data => model, :title => "[ Hash ]"

### Creating a tree from an array


          # using an Array, these would be expanded on selection, using an event
          tree :data => Dir.glob("*"), :title=> "[ Array ]" do 
            command do |node|
              # insert dir entries unless done so already
              if node.children && !node.children.empty?
              else
                f = node.user_object
                if File.directory? f
                  l = Dir.glob(f + "/*")
                  node.add(l) if l
                end
              end
            end
            bind :ENTER_ROW do |t|
              var.value = t.text.user_object
            end
          end

## Tree events

- :TREE_WILL_EXPAND_EVENT - the user has pressed ENTER on this node and wishes expansion. Default.
- :TREE_EXPANDED_EVENT    - tree has expanded
- :TREE_SELECTION_EVENT   - user has pressed space on node, thus selecting it.
- :PROPERTY_CHANGE        - a tree property has changed
- :LEAVE                  - user leaves the widget
- :ENTER                  - user enters the widget

The method `command` maps to TREE_WILL_EXPAND_EVENT, since this is often used to expand a branch with dynamic data such as the contents of a directory. This does not imply that the user has selected that node. And example of using expansion and selection is a screen that has a tree structure for directories on the left. On the right is a list containing the files in the selected directory. The tree contains only directories and never shows files.

In other words, branches are on the left tree. Leaves of a selected branch are displayed as a list on the right. ENTER expands or collapses a branch and updates the file list. SPACE only affects the file list, it does not expand or collapse. This is how the File Explorer in jasspa microemacs behaves.

The example [dirtree.rb](https://github.com/rkumar/rbcurse-core/blob/master/examples/dirtree.rb) is a small prototype of the above list. The only difference is that pressing ENTER does not update the list on the right. (oversight).

## Traversal

Aside from the bindings of list, some keys of interest are:

- O : expand children
- o : toggle expanded state (same as ENTER)
- X : collapse children
- x : collapse parent
- p : goto parent
- f : goto first row starting with char
- > : scroll right
- < : scroll left

Press F1 or "?" on a tree to see all current bindings at runtime. Some of the above bindings were inspired by NerdTree.
