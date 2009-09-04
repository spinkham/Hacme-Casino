== Installation

Done generating the login system. but there are still a few things you have to
do manually. First open your application.rb and add

  require_dependency "login_system"

to the top of the file and include the login system with

  include LoginSystem 

The beginning of your ApplicationController.
It should look something like this : 

  require_dependency "login_system"

  class ApplicationController < ActionController::Base
    include LoginSystem
    model :user

After you have done the modifications the the AbstractController you can import
the user model into the database. This model is meant as an example and you
should extend it. If you just want to get things up and running you can find
some create table syntax in db/user_model.sql.

The model :user is required when you are hitting problems to the degree of
"Session could not be restored becuase not all items in it are known"

== Requirements

You need a database table corresponding to the User model. 

mysql syntax:
CREATE TABLE users (
  id int(11) NOT NULL auto_increment,
  login varchar(80) default NULL,
  password varchar(40) default NULL,
  PRIMARY KEY  (id)
);
 
postgres :
CREATE TABLE "users" (
 "id" SERIAL NOT NULL UNIQUE,
 "login" VARCHAR(80),
 "password" VARCHAR,
 PRIMARY KEY("id")
) WITH OIDS;


sqlite:
CREATE TABLE 'users' (
  'id' INTEGER PRIMARY KEY NOT NULL,
  'user' VARCHAR(80) DEFAULT NULL,
  'password' VARCHAR(40) DEFAULT NULL
);

Of course your user model can have any amount of extra fields. This is just a
starting point

== How to use it 

Now you can go around and happily add "before_filter :login_required" to the
controllers which you would like to protect. 

After integrating the login system with your rails application navigate to your
new controller's signup method. There you can create a new account. After you
are done you should have a look at your DB. Your freshly created user will be
there but the password will be a sha1 hashed 40 digit mess. I find this should
be the minimum of security which every page offering login&password should give
its customers. Now you can move to one of those controllers which you protected
with the before_filter :login_required snippet. You will automatically be re-
directed to your freshly created login controller and you are asked for a
password. After entering valid account data you will be taken back to the
controller which you requested earlier. Simple huh?

== Tips & Tricks

How do I...

  ... restrict access to only a few methods? 
  
  A: Use before_filters build in scoping. 
     Example: 
       before_filter :login_required :only => [:myaccount, :changepassword]
       before_filter :login_required :except => [:index]
     
  ... check if a user is logged-in in my views?
  
  A: @session['user'] will tell you. Here is an example helper which you can use to make this more pretty:
     Example: 
       def user?
         !@session['user'].nil?
       end


You can find more help at http://wiki.rubyonrails.com/rails/show/LoginGenerator