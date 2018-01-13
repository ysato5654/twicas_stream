#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/test_search_live_movies')
require File.expand_path(File.dirname(__FILE__) + '/test_search_users')

class TestSearch
	attr_reader :pass_num
	attr_reader :result

	TEST_NUM = TestSearchUsers::PARAM.keys.size + TestSearchLiveMovies::PARAM.keys.size

	def initialize
		@pass_num = 0
		@result = false
	end

	def start
		@pass_num = 0

		test = TestSearchUsers.new
		test.start
		@pass_num += test.pass_num
		@result = test.result

		Test.summary(test)

		test = TestSearchLiveMovies.new
		test.start
		@pass_num += test.pass_num
		@result = test.result

		Test.summary(test)
	end
end

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')
	require File.expand_path(File.dirname(__FILE__) + '/../test')

	test = TestSearch.new
	test.start

	Test.summary(test)

end
