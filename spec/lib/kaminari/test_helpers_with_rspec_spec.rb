require 'spec_helper'
require 'spec_helper_rspec'
require 'kaminari_rspec'
include KaminariRspec::TestHelpers

describe 'KaminariRspec::TestHelpers::'do

  describe 'discover_mock_framework' do

    context 'when the mock framework does not support framework_name' do

      before do
        dumb_framework = Object.new
        allow(RSpec.configuration).to receive(:mock_framework) { dumb_framework }
      end

      it 'should return :nothing' do
        discover_mock_framework.should == :nothing

      end

    end

    context 'when the mock framework does support framework_name' do

      before do
        mock_framework = RSpec.configuration.mock_framework
        allow(mock_framework).to receive(:framework_name) { :my_framework }
      end

      it 'should return the framework name' do
        discover_mock_framework.should == :my_framework
      end

    end

    context 'when the mock framework is rspec' do

      it 'should return rspec' do
        discover_mock_framework.should == :rspec
      end

    end

  end

  describe 'calculate_values' do

    context 'when no total_count is specified' do

      context 'and when passed an object that does not implement length' do

        it 'sets total_count to 1' do

          values = calculate_values(Object.new)
          values[:total_count].should == 1

        end

      end

      context 'and when passed an object that implements length' do

        it 'sets total_count to the length of the object' do

          values = calculate_values([ Object.new, Object.new])
          values[:total_count].should == 2

        end

      end


    end

    context 'when total_count is specified' do

      it 'sets the total_count to the specified value' do

        values = calculate_values(Object.new, :total_count => 13)
        values[:total_count].should == 13

      end

    end

    context 'when per_page is not specified' do

      it 'set per_page to the default of 25' do

        values = calculate_values(Object.new)
        values[:limit_value].should == 25

      end

    end

    context 'when per_page is specified' do

      it 'sets limit_value to the specified value' do

        values = calculate_values(Object.new, :per_page => 17)
        values[:limit_value].should == 17

      end

    end

    it 'sets num_pages based on total_count and per_page' do
      values = calculate_values(Object.new, :total_count => 50, :per_page => 25)
      values[:num_pages].should == 2
    end

    context 'when current_page is not specified' do

      it 'set current_page to the default of 1' do

        values = calculate_values(Object.new)
        values[:current_page].should == 1

      end

    end

    context 'when current_page is specified' do

      context 'and the current_page value is <= num_pages'do

        it 'sets current_page to the specified value' do

          values = calculate_values(Object.new, :current_page => 19, :total_count => 500, :per_page => 20)
          values[:current_page].should == 19

        end

      end

      context 'and the current_page value is > num_pages' do

        it 'sets current_page to the max value allowed by num_pages' do

          values = calculate_values(Object.new, :current_page => 19, :total_count => 100, :per_page => 20)
          values[:current_page].should == 5
        end


      end

    end

  end



end

