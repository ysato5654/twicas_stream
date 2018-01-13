#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

class Test
	PASS = '** PASS **'

	FAIL = '** FAIL **'

	def self.summary test
		test_num = test.class.to_s + '::' + 'TEST_NUM'
		# => 'TestCategory::TEST_NUM'

		STDOUT.puts
		STDOUT.puts "\s" * 2 + "----------------------------------"
		STDOUT.puts "\s" * 4 + "Summary of Test - #{test.class}"
		STDOUT.puts
		STDOUT.puts "\s" * 4 + "Pass Num / Test Num = #{test.pass_num} / #{Object.const_get(test_num)}"
		STDOUT.puts "\s" * 2 + "----------------------------------"
		STDOUT.puts
	end
end

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/category/test_category')
	require File.expand_path(File.dirname(__FILE__) + '/comment/test_comment')
	require File.expand_path(File.dirname(__FILE__) + '/movie/test_movie')
	require File.expand_path(File.dirname(__FILE__) + '/search/test_search')
	require File.expand_path(File.dirname(__FILE__) + '/user/test_user')


	test = TestUser.new
	test.start

	Test.summary(test)


	test = TestMovie.new
	test.start

	Test.summary(test)


	test = TestComment.new
	test.start

	Test.summary(test)


	test = TestCategory.new
	test.start

	Test.summary(test)


	test = TestSearch.new
	test.start

	Test.summary(test)

end
