require 'kaminari'
require 'kaminari/models/array_extension'

module KaminariRspec


  module TestHelpers

    # Stubs the paginations method on the resource passed.
    #
    # @param resource [Object] A single object or a collection of objects
    # @param options [Hash] The options controlling the stub behaviour
    # @option options [String] :mock the mocking framework to be used, defaults to automatic detection based on RSpec configuration
    # @option options [Integer] :current_page the desired current page number. Defaults to 1
    # @option options [Integer] :per_page the desired amount of elements per page. Defaults to 25
    # @option options [Integer] :total_count the desired total amount of elements (used to calculate the last page link)
    def stub_pagination(resource, options={})
      return nil unless resource
      options[:current_page] ||= 1
      options[:per_page] ||= 25
      mock_framework = options[:mock] || discover_mock_framework
      values = calculate_values(resource, options)
      wrapped_resource = wrap_resource(resource, options)
      case mock_framework
        when :rspec then stub_pagination_with_rspec(wrapped_resource, values)
        when :rr then stub_pagination_with_rr(wrapped_resource, values)
        when :mocha then stub_pagination_with_mocha(wrapped_resource, values)
        when :flexmock then stub_pagination_with_flexmock(wrapped_resource, values)
        when :nothing then resource
        else
          raise ArgumentError, "Invalid mock argument #{options[:mock]} / framework not supported"
      end
    end

  private

    def discover_mock_framework

      mock_framework = RSpec.configuration.mock_framework
      return mock_framework.framework_name if mock_framework.respond_to? :framework_name
      puts('WARNING: Could not detect mocking framework, defaulting to :nothing, use :mock option to override')
      :nothing

    end

    def wrap_resource(resource, options)
      return resource if resource.respond_to? :total_count
      wrappable = resource.respond_to?(:length) ? resource : [resource]
      Kaminari::paginate_array(wrappable).page(1).per([wrappable.length, options[:per_page]].min)
    end


    def calculate_values(resource, options)

      values = {}
      values[:total_count] = options[:total_count] || (resource.respond_to?(:length) ? resource.length : 1)
      values[:limit] = options[:per_page]
      values[:total_pages] = (values[:total_count] / values[:limit]) + ((values[:total_count] % values[:limit]) == 0 ? 0 : 1)
      values[:current_page] = [options[:current_page], values[:total_pages]].min
      values
    end

    def stub_pagination_with_rspec(resource, values)

      values.each do |key, value |
        allow(resource).to receive(key).and_return(value)
      end

      resource

    end

    def stub_pagination_with_rr(resource, values)

      values.each do |key, value|
        eval "stub(resource).#{key} { #{value} }"
      end

      resource

    end

    def stub_pagination_with_mocha(resource, values)

      values.each do |key, value|
        resource.stubs(key).returns(value)
      end

      resource

    end

    def stub_pagination_with_flexmock(resource, values)

      mock = flexmock(resource)

      values.each do |key, value|
        mock.should_receive(key).zero_or_more_times.and_return(value)
      end

      mock

    end

  end
end
