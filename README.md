foosball
========

A simple Rails app to handle our intra-office foosball tournaments

## About

foosball is written with [Ruby on Rails 4.2.0.rc3](rubyonrails.org/download) and
highly influenced by [The Ruby on Rails Tutorial](https://www.railstutorial.org/book)
by Michael Hartl.

## Prerequisites

I'm using Ruby `2.0.0p48`, installed by default with Mac OS X Yosemite. I tried to
use Ruby 2.1.5 with [rbenv](https://github.com/sstephenson/rbenv) but I ran into
a problem with getting `bundle` to find the right paths so I just didn't bother
trying to figure it out & stuck with the default system Ruby.

Once you clone the repo, you should be able to rely on the executables in `./bin/`
to get you everything you need without having to worry about installing and
configuring a bunch of stuff. `Bundle` has a passthrough command that will run
whatever command you pass it in the appropriate context with the right executable,
so by running something in Terminal like

```bash
bin/bundle exec rake db:migrate
```

it should all just work for you, even if you don't have some gems installed
globally or if you have conflicting versions of a certain gem or its requirements
(*ie, Compass*).

## Installation

In order to get everything installed, it's as simple as

```bash
bin/bundle install --path vendor/bundle
```

This will install all the required gems, unsurprisingly, into `vendor/bundle`.
The app is configured to use SQLite in the dev environment *(and everywhere else too)*
and again I'm just using the version of SQLite that came with Yosemite, version
`3.7.13`. To set up the database run

```base
bin/bundle exec rake db:migrate
```

To start a local development server, do

```bash
bin/bundle exec rails server
```

and you'll get a built-in Ruby web server at `localhost:3000`.

## Testing

Tests are run through a Rake task with

```sh
bin/bundle exec rake test

# or simply
bin/bundle exec rake
```
