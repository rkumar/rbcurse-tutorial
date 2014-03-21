
## Forms

Typically we want more control over what is printed. We want user entry and navigation. Thus one or more forms may be created using a window. A form uses a window to write to. It is a container for various components.

      @form = Form.new @window

All components take the form as the first parameter. This obviates having to separately add a component to a form. In rare situations, we do create components with a nil form in situations where the form will be created later, but this shall be discussed later.

After adding all the components to a form, the form is painted using repaint(), the window refreshed and panels updated. After this, the keypress loop may be commenced. `repaint` only repaints those widgets that have been modified since the last keypress, thus is very efficient.

    @form.repaint
    @window.wrefresh
    Ncurses::Panel.update_panels

Within the outer (keypress) loop, the form handles each key, sending it to the relevant component for further handling.

      @form.handle_key(ch)

Only if a key is unhandled by the focused component, does the form process it. Actions may be mapped to keystrokes caught by all components and the Form too. Actions may be bound to Form events, too. (XXX)

Form events include ENTER and LEAVE. These actually apply to all components of a form. This allows us to attach an action to all fields of a form on entry and exit of that component. This can be used to change the background of the label of the focused field as in test2.rb, or to save values to a structure etc.

      @form.bind(:ENTER) { |f|   f.label && f.label.bgcolor = 'red' if f.respond_to? :label}
      @form.bind(:LEAVE) { |f|  f.label && f.label.bgcolor = 'black'   if f.respond_to? :label}

Unlike ncurses, rbcurse allows components to be added or removed even after the form has been created. There are almost no restrictions on widget/component creation and removal. All attributes of a widget may be changed at any time. rbcurse does not use ncurses FORM or other features. It only uses the basic window and panel. Everything else is handled within ruby itself.

Next: [Labels](label.md)