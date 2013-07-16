
== Rendering views with RSpec's render_view

If you are rendering the views from your controller spec using render_views AND you are mocking
the data returned from the db with something along the lines of
    Model.stub_chain(:order, :page, :per).and_return([model_mock])

you may want to also stub the methods needed by the pagination partials, in order to do that, just
add the following to your +spec_helper+
    config.include Kaminari::TestHelpers, :type => :controller

and then modify your controller spec to look like
    Model.stub_chain(:order, :page, :per).and_return(stub_pagination_methods([model_mock]))

the stubs will return the values needed to set the pagination as being on the first and only page.
If specific pagination values are needed they can be defined using a hash
    stub_pagination(mocked_result, :total_count => 50, :current_page => 3, :per_page => 10)

will create the same pagination links as a total count of 50 elements are available, with 10
elements per page and page 3 being the current_page.

=== Detecting mocking framework

If you are using RSpec >= 2.5.2 there is no need to explicitly pass the mocking framework you
are using to the stub_pagination method, as it is automatically detected by the TestHelpers.
For earlier versions you are required to explicitly use the same string you would pass to
+RSpec.configuration.mock_with+ , so the actual method call is
    stub_pagination(mocked_result, :mock => :rspec, :total_count => 50, :current_page => 3, :per_page => 10)

=== Default values

The TestHelpers will also try to guess values so that you don't need to explicitly pass them all.
* :per_page will default to 25
* :current_page will default to 1
* :total_page will default to 1 if the object passed as resource is not a collection, otherwise it will
  invoke get the value from resource.length

