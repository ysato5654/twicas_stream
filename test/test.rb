#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

require File.expand_path(File.dirname(__FILE__) + '/category/test_category')
require File.expand_path(File.dirname(__FILE__) + '/comment/test_comment')
require File.expand_path(File.dirname(__FILE__) + '/movie/test_movie')
require File.expand_path(File.dirname(__FILE__) + '/search/test_search')
require File.expand_path(File.dirname(__FILE__) + '/user/test_user')

class Test
	TARGET = ['User', 'Movie', 'Comment', 'Category', 'Search']

	PASS = '** PASS **'

	FAIL = '** FAIL **'

	# this is for summary
	MAIN_WINDOW = '-' * 34

	# this is for description of each test
	SUB_WINDOW = '-' * 23

	def self.summary test
		test_num = test.class.to_s + '::' + 'TEST_NUM'
		# => 'TestCategory::TEST_NUM'

		STDOUT.puts
		STDOUT.puts "\s" * 2 + MAIN_WINDOW
		STDOUT.puts "\s" * 4 + "Summary of Test - #{test.class}"
		STDOUT.puts
		STDOUT.puts "\s" * 4 + "Pass Num / Test Num = #{test.pass_num} / #{Object.const_get(test_num)}"
		STDOUT.puts "\s" * 2 + MAIN_WINDOW
		STDOUT.puts
	end

	def self.description str
		STDOUT.puts SUB_WINDOW
		STDOUT.puts "\s" * 2 + str
		STDOUT.puts SUB_WINDOW
	end

	def self.all
		TARGET.each{ |test_name|
			class_name = self.to_s + test_name
			# => 'Test' + 'User'

			test = Object.const_get(class_name).new
			test.start

			Test.summary(test)
		}
	end
end

if $0 == __FILE__
	test = Test.all
end
