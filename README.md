# How to start app locally:

- Clone this repo `git clone git@github.com:trinhphong/test-trinhphong.git`
- `bundle install` to install all dependencies
- `touch .env` and copy/paste environment variable which is attached on the email
- `rails db:create` to create database
- `rails db:migrate` to make all database migrations
- `rails s` to start the local server

# How to run tests:

- `rspec --format documentation` to run the rspec tests
- `cucumber` to run the cucumber tests
