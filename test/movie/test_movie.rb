#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/test_get_movie_info')

class TestMovie
	attr_reader :pass_num
	attr_reader :result

	TEST_NUM = TestGetMovieInfo::PARAM.keys.size

	def initialize
		@pass_num = 0
		@result = false
	end

	def start
		@pass_num = 0

		test = TestGetMovieInfo.new
		test.start
		@pass_num += test.pass_num
		@result = test.result

		Test.summary(test)
	end
end

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')
	require File.expand_path(File.dirname(__FILE__) + '/../test')

	test = TestMovie.new
	test.start

	Test.summary(test)

end
