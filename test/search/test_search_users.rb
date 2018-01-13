#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestSearchUsers
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_WORDS = 'ツイキャス 公式'

	DEFAULT_LIMIT = TwicasStream::Search::SearchUsers::DEFAULT_LIMIT

	LOWER_LIMIT = TwicasStream::Search::SearchUsers::LOWER_LIMIT

	UPPER_LIMIT = TwicasStream::Search::SearchUsers::UPPER_LIMIT

	DEFAULT_LANG = 'ja'

	PARAM = {
				# test1 ~ test3 : words
				:test1 => {
							:description => 'two words', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				:test2 => {
							:description => 'one word', 
							:words => 'ツイキャス', 
							:limit => DEFAULT_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				:test3 => {
							:description => 'no word', 
							:words => '', 
							:limit => DEFAULT_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				# test4 ~ test7 : limit
				:test4 => {
							:description => 'within limitation (equal to lower limit)', 
							:words => DEFAULT_WORDS, 
							:limit => LOWER_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				:test5 => {
							:description => 'out of limitation (less than lower limit)', 
							:words => DEFAULT_WORDS, 
							:limit => LOWER_LIMIT - 1, 
							:lang => DEFAULT_LANG
						}, 
				:test6 => {
							:description => 'within limitation (equal to upper limit)', 
							:words => DEFAULT_WORDS, 
							:limit => UPPER_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				:test7 => {
							:description => 'out of limitation (over upper limit)', 
							:words => DEFAULT_WORDS, 
							:limit => UPPER_LIMIT + 1, 
							:lang => DEFAULT_LANG
						}, 
				# test8 ~ test12 : language
				:test8 => {
							:description => 'language is Japanese', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
							:lang => DEFAULT_LANG
						}, 
				:test9 => {
							:description => 'language is English', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
							:lang => 'en'
						}, 
				:test10 => {
							:description => 'language is Chinese', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
							:lang => 'ch'
						}, 
				:test11 => {
							:description => 'number', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
							:lang => 123
						}, 
				:test12 => {
							:description => 'nil class', 
							:words => DEFAULT_WORDS, 
							:limit => DEFAULT_LIMIT, 
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

			search = TwicasStream::Search::SearchUsers.new(val[:words], val[:limit], val[:lang])
			search_users = search.response

			STDOUT.puts

			test_num = key.to_s.gsub(/[^\d]/, '').to_i

			# pass/fail for words
			if test_num >= 0 and test_num <= 3
				passfail_for_words(val[:words], search_users)
			# pass/fail for limit
			elsif test_num >= 4 and test_num <= 7
				passfail_for_limit(val[:limit], search_users)
			# pass/fail for language
			elsif test_num >= 8 and test_num <= 12
				passfail_for_lang(val[:lang], search_users)
			end

			STDOUT.puts

		}

		@result = true if @pass_num == TEST_NUM

		return @result
	end

	private
	def passfail_for_words words, response
		if words.empty?
			if response.empty?
				@pass_num += 1
				STDOUT.puts Test::PASS
			else
				STDOUT.puts Test::FAIL
			end
		else
			if response.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		end
	end

	private
	def passfail_for_limit limit, response
		# within limitation
		if limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
			if response.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		# out of limitation
		else
			if response.empty?
				@pass_num += 1
				STDOUT.puts Test::PASS
			else
				STDOUT.puts Test::FAIL
			end
		end
	end

	private
	def passfail_for_lang lang, response
		if TwicasStream::Search::SearchUsers::LANG_LIMITATION.include?(lang)
			if response.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		# special condition for out of support language
		elsif lang.is_a?(String)
			if response.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		else
			if response.empty?
				@pass_num += 1
				STDOUT.puts Test::PASS
			else
				STDOUT.puts Test::FAIL
			end
		end
	end
end
