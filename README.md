# Kaminari Rspec Library



[![Gem Version](https://badge.fury.io/rb/kaminari-rspec.png)](http://badge.fury.io/rb/kaminari-rspec)
[![Build Status](https://travis-ci.org/nessche/kaminari-rspec.png)](https://travis-ci.org/nessche/kaminari-rspec)


`kaminari-rspec` is a ruby gem that aims at simplifying writing the specs for views where Kaminari is used for pagination

## Installing


Simply install the gem to your system

    gem install kaminari-rspec

or if you are using Bundler add it to your gemspec file and run `bundle install`.

## Gem Versioning

The gem version reflects the kaminari version that is supports. Please notice that this gem is maintained in my spare time
so delays occur between the release of a new Kaminari version and the release of a new version of this gem. Feel free
to fork this repo and update the version and the code as needed.

## Rendering views with RSpec's render_view

If you are rendering the views from your controller spec using render_views AND you are mocking
the data returned from the db with something along the lines of

    Model.stub_chain(:order, :page, :per).and_return([model_mock])

you may want to also stub the methods needed by the pagination partials, in order to do that, just
add the following to your `spec_helper`

    config.include KaminariRspec::TestHelpers, :type => :controller

and then modify your controller spec to look like

    Model.stub_chain(:order, :page, :per).and_return(stub_pagination([model_mock]))

the stubs will return the values needed to set the pagination as being on the first and only page.

### Pagination options

If specific pagination values are needed they can be defined using a hash. The following values are supported:

* `:total_count` : the total number of elements to be paginated. It defaults to `resource.length` if resource is a collection,
otherwise to 1
* `:per_page` : the amount of elements per page, defaults to 25
* `:current_page` : the current page of the pagination. Defaults to 1. Notice that `current_page` is anyway always
  set such that it respects the values passed in `total_count` and `per_page`, i.e. if you pass a
  total count of 95 and a per page value of 10, current page will be capped to 10

As an example

    stub_pagination(resource, :total_count => 50, :current_page => 3, :per_page => 10)

will create the pagination links for a total count of 50 elements, with 10
elements per page and page 3 being the current_page.

## Detecting mocking framework

If you are using RSpec >= 2.5.2 there is no need to explicitly pass the mocking framework you
are using to the stub_pagination method, as it is automatically detected by the TestHelpers.
For earlier versions you are required to explicitly use the same string you would pass to
`RSpec.configuration.mock_with` , so the actual method call is

    stub_pagination(mocked_result, :mock => :rspec, :total_count => 50, :current_page => 3, :per_page => 10)

### Supported mocking frameworks

Currently supported mocking frameworks are:

* RSpec's built-in doubles
* RR (Double Ruby)
* Mocha
* Flexmock
