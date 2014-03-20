Installation
============

It is best to have ruby 1.9.1 or higher (latest) installed. If you are using 1.8.7 and you face any issues, please report.
If you use both versions, you will have to install both gems under both version. 

rbcurse can be installed as follows:

    gem install rbcurse-core

rbcurse-core depends on ffi-ncurses only, which should get installed as a dependency. 


Please try out some examples, preferable [test2.rb](https://github.com/rkumar/rbcurse-extras/blob/master/examples/test2.rb) in the examples directory of [rbcurse-extras](https://github.com/rkumar/rbcurse-extras/blob/master/examples/test2.rb) project (This is no longer under core since it uses several non-core componrnts). rbcurse-core's examples has many examples which use only core components.
   
    cd examples
    ruby test2.rb

Next: [Basic Setup](02-setup.md)
