# TableauRestApi

A wrapper around a subset of version 2.6 of the Tableau REST API. The latest documentation for the API can be found at:

https://onlinehelp.tableau.com/current/api/rest_api/en-us/help.htm#REST

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tableau_rest_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tableau_rest_api

## Configuration

You will need to export the following environmental variables if the default options are not suitable:
```
export TABLEAU_HOST="https://tableau.lvh.me"
export TABLEAU_USERNAME="username"
export TABLEAU_PASSWORD="password"
export TABLEAU_AUTH_TOKEN_DURATION="4"
```

## Usage

The easiest way to try out the client is from the root of this repo via the included console:
```
./bin/console
```
You can then create an instance of the Resource Class and interact with it:
```ruby
r = TableauRestApi::Resource.new
site = r.sites.first.id
users = r.users_on_site(site)
```
There are also methods for retrieving resources through other resources:
```ruby
site = r.sites.first
group = site.groups.last.name
user = site.users.find { |user| user.name == 'John Smith' }
new_user = site.add_user_to_site { :name => 'New User', :siteRole => 'Viewer' }
```
Workbooks and Datasources can be uploaded like so:
```ruby
workbook = File.read('sample.twbx')
site = r.sites.first
project = site.projects.first
metadata = { :name => 'Sample', :project => project.id }
payload = { :filename => 'sample.twbx', :data => workbook }
r.publish_workbook(site.id, metadata, payload )
```
You can reconfigure an instance of the client at runtime:
```ruby
r.configure({ :host => 'https://another.tableau.server' })
```
You can switch sites, which will request a new token for the target site and invalidate your current token. To delete a site you will need to switch to it first to gain the required token. After the site is deleted your token will be invalidated in Tableau and cleared in the client.
```ruby
r.switch_site({ :site => { :contentUrl => 'Another Site' } })
site = r.sites.find { |site| site.content_url == 'Another Site' }
r.delete_site(site.id)
```
## Coverage

General | UserGroup | WorkbookDatasource | ScheduleSubscription
--------|-----------|--------------------|---------------------
server_info | users_on_site | query_workbooks | subscriptions
sites | groups | datasources | query_subscription
create_site | users_in_group | get_workbook | create_subscription
switch_site | add_user_to_site | get_datasource | delete_subscription
delete_site | add_user_to_group | update_workbook | delete_schedule
|| create_group | update_datasource | schedules
|| delete_group | update_project |
|| remove_user_from_group | query_projects |
|| remove_user_from_site | delete_workbook |
|| update_user | delete_datasource |
|| update_group | delete_project |
||| publish_workbook |
||| publish_datasource |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davelancaster/tableau_rest_api.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

