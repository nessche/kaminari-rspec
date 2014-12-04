require 'spec_helper'
require 'kaminari_rspec'
include KaminariRspec::TestHelpers

describe 'KaminariRspec::TestHelpers' do


  describe 'calculate_values' do

    context 'when no total_count is specified' do

      context 'and when passed an object that does not implement length' do

        it 'sets total_count to 1' do

          values = calculate_values(Object.new, current_page: 1, per_page: 25)
          values[:total_count].should == 1

        end

      end

      context 'and when passed an object that implements length' do

        it 'sets total_count to the length of the object' do

          values = calculate_values([ Object.new, Object.new], current_page: 1, per_page: 25)
          values[:total_count].should == 2

        end

      end


    end

    context 'when total_count is specified' do

      it 'sets the total_count to the specified value' do

        values = calculate_values(Object.new, current_page: 1, total_count: 13, per_page: 25)
        values[:total_count].should == 13

      end

    end

    it 'sets total_pages based on total_count and per_page' do
      values = calculate_values(Object.new, current_page: 1, :total_count => 50, :per_page => 25)
      values[:total_pages].should == 2
    end

    context 'when current_page is specified' do

      context 'and the current_page value is <= num_pages'do

        it 'sets current_page to the specified value' do

          values = calculate_values(Object.new, :current_page => 19, :total_count => 500, :per_page => 20)
          values[:current_page].should == 19

        end

      end

      context 'and the current_page value is > total_pages' do

        it 'sets current_page to the max value allowed by total_pages' do

          values = calculate_values(Object.new, :current_page => 19, :total_count => 100, :per_page => 20)
          values[:current_page].should == 5
        end


      end

    end

  end



end