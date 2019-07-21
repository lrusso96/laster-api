# laster-api
[![Build Status](https://travis-ci.com/lrusso96/laster-api.svg?token=uoNxtXYBDHpqERGMiZA8&branch=master)](https://travis-ci.com/lrusso96/laster-api)
[![codecov](https://img.shields.io/codecov/c/github/lrusso96/laster-api.svg)](https://codecov.io/gh/lrusso96/laster-api)


[![CodeFactor](https://www.codefactor.io/repository/github/lrusso96/laster-api/badge)](https://www.codefactor.io/repository/github/lrusso96/laster-api)
[![BCH compliance](https://bettercodehub.com/edge/badge/lrusso96/laster-api?branch=master)](https://bettercodehub.com/)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)


A very simple Rails 6 app that interacts with [Last.fm API](https://www.last.fm/api).

## What is required
This is a Ruby on Rails project, so first you need to set up Rails

* Rails version
    6

* Ruby version
    Ruby 2.6.3

## How to run
You have to install all gems required. So simply run

    bundle

Then you can run the migrations

    rails db:migrate

Finally put the server up with

    rails s

## Tests
In order to run tests do

    bundle exec rspec spec

## Dependencies
* httparty
* figaro
* json
* codecov, simplecov
* ...

## Contributors
* [Luigi Russo](https://github.com/lrusso96)
* [Matteo Salvino](https://github.com/matteosalvino)
