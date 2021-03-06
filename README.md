#Instagram Challenge

Makers Academy Week 7 Weekend Challenge

Build an Instagram clone using Rails.

[![Build Status](https://travis-ci.org/harrim91/instagram-challenge.svg?branch=master)](https://travis-ci.org/harrim91/instagram-challenge)
[![Coverage Status](https://coveralls.io/repos/github/harrim91/instagram-challenge/badge.svg?branch=master)](https://coveralls.io/github/harrim91/instagram-challenge?branch=master)

## Installation etc

- Clone this repo `git clone git@github.com:harrim91/instagram-challenge.git`
- `cd instagram-challenge`
- Run bundle to install dependencies `bundle install`
- Create your databases - `bin/rake db:create` and `bin/rake db:create RAILS_ENV=test`
- Migrate your databases - `bin/rake db:migrate` and `bin/rake db:migrate RAILS_ENV=test`
- To run the local server - `bin/rails s`
- To run the tests, run `rspec`

## Features
Users can create an account, sign in and log out (using [Devise](https://github.com/plataformatec/devise))  
Users must be logged in to access any functionality.  
Users can perform CRUD actions on photos.  
Photos can only be edited or deleted by their owners.  
Photos are uploaded using [paperclip](https://github.com/thoughtbot/paperclip) and stored on AWS.  
On upload, photos are resized and a thumbnail is made using [ImageMagick](http://www.imagemagick.org/script/index.php).  

Users can comment on any photo. Only the comment owner can delete the comment.
Requests to add and delete comments are made using ajax, and the comment section is re-rendered using jquery, so the page does not have to be reloaded.

Users have a profile page, accessible via the navigation bar, or by a link on any image or comment posted by them.
This shows all images that the specific user has posted.

Users can like and unlike images. This functionality uses the [acts_as_votable](https://github.com/ryanto/acts_as_votable) gem.

Views are written in haml and styled using Bootstrap.

The flash message styling stuff came from [potashin on Stack Overflow](http://stackoverflow.com/questions/30884139/flash-message-does-not-have-bootstrap-classes)

Adding custom fields to devise users came from [a blog of the same title](http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html) by Jaco Pretorius.
