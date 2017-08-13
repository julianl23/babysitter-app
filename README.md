# README

This app is built on Ruby version 2.4

## Local Installation instructions
- Download and use Ruby 2.4.0 through RVM (or by your preferred means)
- Ensure you have Postgres installed (using Homebrew on Mac or your built-in package manager on Linux)
- Run `bundle install` in the app's root directory
- Run `rake db:create` to set up the database and tables
- Run `rails db:migrate` to ensure the data structure is up to date
- Run `rails db:seed` to seed role data
- `rails s` to start the app
