require 'spec_helper'
require_relative 'spec_helper_rspec'
require 'kaminari_rspec'
include KaminariRspec::TestHelpers

describe 'KaminariRspec::TestHelpers::'  do

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




end

