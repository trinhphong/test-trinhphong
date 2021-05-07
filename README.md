# Backend - Rails API

## How to setup backend server locally:

We are using `test` branch

- `rvm use` or `rvm use 2.7.3`
- Clone this repo `git clone git@github.com:trinhphong/test-trinhphong.git`
- `cd test-trinhphong`
- `bundle install` to install all dependencies
- `cp .env.example .env` to copy/paste environment variables
- `rails db:create` to create database
- `rails db:migrate` to make all database migrations

## How to start backend server locally:
- `rails s` to start the local server

# Frontend - Expo Web App

## How to setup frontend web locally:
- `cd test-trinhphong/frontend`
- `yarn install` to install packages
- `yarn web` to install expo packages

## How to start frontend web locally:
- `yarn web`

# How to build frontend web:
- `yarn build:web`


# How to run tests:

- `rspec --format documentation` to run the rspec tests
- `cucumber` to run the cucumber tests

# Video demo
- `test-trinhphong.mov`
