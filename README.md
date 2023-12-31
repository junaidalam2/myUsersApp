# Welcome to My Users App
***

## Task
The application applies the MVC architecture to a simple website that can perform basic CRUD functions for users which correspond to relevant HTTP routes. 

## Description

Users may use Postman API or similar applications to send POST, GET, PUT and DELETE requests to the controller, *app.rb*. *app.rb* makes requests to the database *db.sql* via the model, *my_user_model.rb*. Results of GET requests are accessible by a standard browser via *index.erb*.

### Architecture
-Model: *my_user_model.rb*\
-View: *views\index.erb*\
-Controller: *app.rb*\
-Database: *db.sql*

## Tech Stack

- Ruby
  - Gems:
    - sqlite3
    - sinatra

## Installation

Installation of Ruby is required. The application uses the sqlite3 gem which is already included within Ruby. Sinatra also requries installation. Ruby operates on a standard IDE.

## Usage

-GET route: http://localhost:8080/users - lists the first name, last name, age and email address of all users.\
-POST route: http://localhost:8080/users - creates a new user with the following parameters:
1. first name - *params[:firstname]*
2. last name - *params[:lastname]*
3. age - *params[:age]*
4. password - *params[:password]*
5. email - *params[:email]*

-DELETE route: http://localhost:8080/users - if a user is logged in, deletes a user if the user's user ID is provided with the following parameter: *params[:id]*.\
-POST route: http://localhost:8080/sign_in - allows a user to log in upon provision of their email address, *params[:email]* and password, *params[:password]*.\
-DELETE route: http://localhost:8080/sign_out - logs out the user. No parameters are required.\
-PUT route: http://localhost:8080/users - if a user is a logged in, allows a user to update their password by providing *params[:password]*.


To run the server, type the following in the terminal:
```
ruby app.rb -s puma
```

### The Core Team
Junaid Alam

<span><i>Made at <a href='https://qwasar.io'>Qwasar Silicon Valley</a></i></span>
<span><img alt='Qwasar Silicon Valley Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>