# Presentations
*Collect* is a plugin for [Spina](https://www.spinacms.com 'Spina website') (a [Rails](http://rubyonrails.org 'Ruby on Rails website') content management system) to add conference management functionality.
With the plugin, you'll be able to manage details of conferences, delegates, and presentations.
See the wiki for details of the types of data supported.
The plugin also includes three extra page parts for Spina pages: `Spina::Date`, `Spina::Url`, and `Spina::EmailAddress`.
`Spina::Url` and `Spina::EmailAddress` both have validators for the format of HTTP(S) URLs (using `URI`) and email addresses respectively.

[Short description and motivation.]

## Usage
The plugin will add a **Conferences** item to Spina's primary navigation menu.
The menu structure will be as follows:

* [*Other menu items*]

* Conferences
    
    * Conferences
    
    * Delegates
    
    * Presentations
    
You'll want to set up a conference first,
then delegates, which must belong to at least one conference,
and then presentations, which must belong to one conference and at least one delegate.

After installing the plugin, you just need to start your server in the usual way:
```bash
$ rails server
```

Make sure you choose 'Conference' as the theme.
You can choose the theme from the admin interface by going to **Preferences** &rarr; **Styling**.

[How to use my plugin.]

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'collect'
```

And then execute:
```bash
$ bundle:install
```

If you haven't installed Spina at this point, it will be installed.

### For brand new Spina installations

If the previous command installed Spina, you'll need to set up Spina first before you continue.

Run the Spina install generator:
```bash
$ rails generator spina:install
```
And follow the prompts.

You'll also need to install Active Storage.

To create the database tables to support Active Storage, run:
```bash
$ rails active_storage:install
```

Then follow the steps below.

### For existing Spina installations

You'll then need to install and run the migrations from Collect (the Spina install generator does this for Spina).

First install the migrations:
```bash
$ collect_engine:install:migrations
```

Then migrate the database:
```bash
$ rake db:migrate
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
