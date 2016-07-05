#Instagram Challenge

Makers Academy Week 7 Weekend Challenge

Build an Instagram clone using Rails.

[![Build Status](https://travis-ci.org/harrim91/instagram-challenge.svg?branch=master)](https://travis-ci.org/harrim91/instagram-challenge)
[![Coverage Status](https://coveralls.io/repos/github/harrim91/instagram-challenge/badge.svg?branch=master)](https://coveralls.io/github/harrim91/instagram-challenge?branch=master)

Users can create an account, sign in and log out (using Devise)
Users must be logged in to access any functionality.
Users can perform CRUD actions on photos.
Photos can only be edited or deleted by their owners.
Photos are uploaded using paperclip and stored on AWS.
On upload, photos are resized, and a thumbnail is made, using ImageMagick.

Users can comment on any photo. Only the comment owner can delete the comment.
Requests to add and delete comments are made using ajax, and the comment section is re-rendered using jquery, so the page does not have to be reloaded.

Users have a profile page, accessible via the navigation bar, or by a link on any image or comment posted by them.
This shows all images that the specific user has posted.

Users can like and unlike images. This functionality uses the acts_as_votable gem.

Views are written in haml and styled using Bootstrap.

The flash message styling stuff came from [potashin on Stack Overflow](http://stackoverflow.com/questions/30884139/flash-message-does-not-have-bootstrap-classes)

Adding custom fields to devise users came from [a blog of the same title](http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html) by Jaco Pretorius.
