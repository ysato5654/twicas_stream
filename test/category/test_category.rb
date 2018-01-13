#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../test')

class TestCategory < Test
	attr_reader :pass_num
	attr_reader :result

	PARAM = {
				:test1 => {
							:description => 'language is Japanese', 
							:lang => 'ja'
						}, 
				:test2 => {
							:description => 'language is English', 
							:lang => 'en'
						}, 
				:test3 => {
							:description => 'language is Chinese', 
							:lang => 'ch'
						}, 
				:test4 => {
							:description => 'number', 
							:lang => 123
						}, 
				:test5 => {
							:description => 'nil class', 
							:lang => nil
						}
			}

	TEST_NUM = PARAM.keys.size

	def initialize
		@pass_num = 0
		@result = false
	end

	def start
		@pass_num = 0

		PARAM.each{ |key, val|
			STDOUT.puts '-----------------------'
			STDOUT.puts '  ' + val[:description]
			STDOUT.puts '-----------------------'

			category = TwicasStream::Category::GetCategories.new(val[:lang])
			categories = category.response

			STDOUT.puts

			if TwicasStream::Category::GetCategories::LANG_LIMITATION.include?(val[:lang])
				if categories.empty?
					STDOUT.puts TEST_FAIL
				else
					@pass_num += 1
					STDOUT.puts TEST_PASS
				end
			# special condition for out of support language
			elsif val[:lang].is_a?(String)
				if categories.empty?
					STDOUT.puts TEST_FAIL
				else
					@pass_num += 1
					STDOUT.puts TEST_PASS
				end
			else
				if categories.empty?
					@pass_num += 1
					STDOUT.puts TEST_PASS
				else
					STDOUT.puts TEST_FAIL
				end
			end

			STDOUT.puts

		}

		@result = true if @pass_num == TEST_NUM

		return @result
	end
end

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

	test = TestCategory.new
	test.start

	Test.summary(test)

end