require 'spec_helper'
require_relative 'spec_helper_mocha'
require 'kaminari_rspec'
include KaminariRspec::TestHelpers

describe 'KaminariRspec::TestHelpers::' do

  describe 'discover_mock_framework' do

    context 'when the mock framework is mocha' do

      it 'should return mocha' do
        discover_mock_framework.should == :mocha
      end

    end

  end


  describe 'stub_pagination' do

    context 'when passed a nil resource' do

      it 'returns nil' do
        result = stub_pagination(nil)
        result.should be_nil
      end

    end

    context 'when passed a non nil resource' do

      # we check for total_count, to know if the stubbing was successful, no need to check for each
      # method individually
      it 'has the total_count method stubbed' do
        resource = Object.new
        result = stub_pagination(resource, :mock => :mocha, :total_count => 23)
        result.total_count.should == 23
      end

      context 'and an unknown mocking framework' do

        it 'raises an error' do
          resource = Object.new
          expect { stub_pagination(resource, :mock => :my_mock)}.to raise_error(ArgumentError)

        end

      end

    end

  end

end

