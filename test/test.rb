#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

class Test
	TEST_PASS = '** PASS **'

	TEST_FAIL = '** FAIL **'

	def self.summary test
		test_num = test.class.to_s + '::' + 'TEST_NUM'
		# => 'TestCategory::TEST_NUM'

		STDOUT.puts
		STDOUT.puts ' ' * 2 + '----------------------------------'
		STDOUT.puts ' ' * 4 + "Summary of Test - #{test.class}"
		STDOUT.puts
		STDOUT.puts ' ' * 4 + "Pass Num / Test Num = #{test.pass_num} / #{Object.const_get(test_num)}"
		STDOUT.puts ' ' * 2 + '----------------------------------'
		STDOUT.puts
	end

end

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/user/test_user')
	require File.expand_path(File.dirname(__FILE__) + '/category/test_category')

	test = TestUser.new
	test.start

	Test.summary(test)

	test = TestCategory.new
	test.start

	Test.summary(test)

end
