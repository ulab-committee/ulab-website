# README

This README documents the steps necessary to get the website up and running.

* The website is a Rails app running on Ruby 2.6.1 (check `.ruby-version` to confirm)

* Dependencies not installed by Bundler include:

  * PostgreSQL, which allows the app to manipulate PostgreSQL databases
    
    * On Mac, just download [`Postgres.app`](https://postgresapp.com)
        
    * On Windows and Linux, follow the [instructions on the PostgreSQL website](https://www.postgresql.org/download/)
  
  * Redis, for caching and job queues

    * On Mac, you can download [Redis Server](https://langui.net/redis-server/) from the App Store
    
    * On Windows and Linux, follow the [instructions on the Redis website](https://redis.io/download)

* Configuration

* Create the databases for development and testing by running `rake db:create`, repeat in production to create the
  production database

* You can seed the database with sample data by running `rake db:seed`—find the data used in `db/seeds.rb`

* To run the test suite, run `rake test`

* The website makes use of a variety of services when running

  * [Heroku](https://www.heroku.com/dynos) is used to run the app

  * [Heroku Postgres](https://www.heroku.com/postgres) is used for databases

  * [Heroku Redis](https://www.heroku.com/redis) is used for caching and job queues

  * [Amazon S3](https://aws.amazon.com/s3) is used for cloud storage of images and documents

* CI (Contiguous Integration) services include:

  * [Travis](https://travis-ci.com), which runs any tests and reports the result

  * [Code Climate](https://codeclimate.com/quality/), which runs checks on code and monitors test coverage

* Services which allow the identification of problems with the live website include:

  * [Skylight](https://www.skylight.io), which monitors requests and responses for slowness and other issues

  * [Depfu](https://depfu.com), which checks for updated versions of dependencies

  * [Bugsnag](https://www.bugsnag.com), which logs errors which the app reports and creates corresponding issues in this repo
    [![Bugsnag](https://raw.githubusercontent.com/gist/jmalcic/3d5ab904fa9689a7ba5a14c8c2077338/raw/8d24b03e3b8460ebab22bd0948d527d0199fa665/bugsnag-logo.svg?sanitize=true)](https://www.bugsnag.com)

  * [Scout](https://scoutapm.com), which monitors resource usage

  * [Heroku](https://devcenter.heroku.com/categories/monitoring-metrics), which offers some statistics on the app

* The app deploys to Heroku

  * Before any PR is merged, Travis must run `rake test` successfully, and Code Climate must report no problems

  * The app belongs to a Heroku pipeline which auto-deploys `master` to both staging and production
