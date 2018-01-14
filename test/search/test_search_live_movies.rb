#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestSearchLiveMovies
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_LIMIT = TwicasStream::Search::SearchLiveMovies::DEFAULT_LIMIT

	LOWER_LIMIT = TwicasStream::Search::SearchLiveMovies::LOWER_LIMIT

	UPPER_LIMIT = TwicasStream::Search::SearchLiveMovies::UPPER_LIMIT

	DEFAULT_TYPE = 'recommend'

	DEFAULT_CONTEXT = '初心者'

	DEFAULT_LANG = 'ja'

	PARAM = {
				# test1 ~ test4 : limit
				:test1 => {
							:description => 'within limitation (equal to lower limit)', 
							:limit => LOWER_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test2 => {
							:description => 'out of limitation (less than lower limit)', 
							:limit => LOWER_LIMIT - 1, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test3 => {
							:description => 'within limitation (equal to upper limit)', 
							:limit => UPPER_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test4 => {
							:description => 'out of limitation (over upper limit)', 
							:limit => UPPER_LIMIT + 1, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}#, 
=begin
				# test5 ~ test12 : type
				:test5 => {
							:description => "type ('new')", 
							:limit => DEFAULT_LIMIT, 
							:type => 'new', 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test6 => {
							:description => "type ('recommend')", 
							:limit => DEFAULT_LIMIT, 
							:type => 'recommend', 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test7 => {
							:description => 'no type', 
							:limit => DEFAULT_LIMIT, 
							:type => '', 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				# test8 ~ test12 : language
				:test8 => {
							:description => 'language is Japanese', 
							:limit => DEFAULT_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}, 
				:test9 => {
							:description => 'language is English', 
							:limit => DEFAULT_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => 'en'
						}, 
				:test10 => {
							:description => 'language is Chinese', 
							:limit => DEFAULT_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => 'ch'
						}, 
				:test11 => {
							:description => 'number', 
							:limit => DEFAULT_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => 123
						}, 
				:test12 => {
							:description => 'nil class', 
							:limit => DEFAULT_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => nil
						}
=end
			}

	TEST_NUM = PARAM.keys.size

	def initialize
		@pass_num = 0
		@result = false
	end

	def start
		@pass_num = 0

		PARAM.each{ |key, val|
			Test.description(val[:description])

			TwicasStream.reset

			TwicasStream.configure do |request_header|
				request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
			end

			api = TwicasStream::Search::SearchLiveMovies.new(val[:limit], val[:type], val[:context], val[:lang])
			search_users = api.response

			STDOUT.puts

			test_num = key.to_s.gsub(/[^\d]/, '').to_i

			# pass/fail for limit
			if test_num >= 0 and test_num <= 4
				passfail_for_limit(val[:limit], search_users)
			# pass/fail for type
			elsif test_num >= 5 and test_num <= 7
				passfail_for_type(val[:type], search_users)
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
	def passfail_for_type type, response
		# mismatch type
		if TwicasStream::Search::SearchLiveMovies::TYPE_LIMITATION.include?(type)
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

	private
	def passfail_for_lang lang, search_users
		if TwicasStream::Search::SearchUsers::LANG_LIMITATION.include?(lang)
			if search_users.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		# special condition for out of support language
		elsif lang.is_a?(String)
			if search_users.empty?
				STDOUT.puts Test::FAIL
			else
				@pass_num += 1
				STDOUT.puts Test::PASS
			end
		else
			if search_users.empty?
				@pass_num += 1
				STDOUT.puts Test::PASS
			else
				STDOUT.puts Test::FAIL
			end
		end
	end
end
