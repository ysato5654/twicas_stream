#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestGetComments
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_MOVIE_ID = '189037369'

	DEFAULT_OFFSET = TwicasStream::Comment::GetComments::DEFAULT_OFFSET

	DEFAULT_LIMIT = TwicasStream::Comment::GetComments::DEFAULT_LIMIT

	LOWER_LIMIT = TwicasStream::Comment::GetComments::LOWER_LIMIT

	UPPER_LIMIT = TwicasStream::Comment::GetComments::UPPER_LIMIT

	DEFAULT_SLICE_ID = TwicasStream::Comment::GetComments::DEFAULT_SLICE_ID

	PARAM = {
				# test1 ~ test3 : movie id
				:test1 => {
							:description => 'existing movie', 
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				:test2 => {
							:description => 'no existing movie -> Not Found (code: 404)', 
							:movie_id => 'abc', 
							:offset => DEFAULT_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				:test3 => {
							:description => 'unset movie id -> Not Found (code: 404)', 
							:movie_id => '', 
							:offset => DEFAULT_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				# test4 ~ test7 : limit
				:test4 => {
							:description => 'within limitation (equal to lower limit)', 
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				:test5 => {
							:description => 'out of limitation (less than lower limit)', 
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT - 1, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				:test6 => {
							:description => 'within limitation (equal to upper limit)', 
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}, 
				:test7 => {
							:description => 'out of limitation (over upper limit: set 101 but according to API document, upper limit is 50)', 
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT + UPPER_LIMIT + 1, 
							:slice_id => DEFAULT_SLICE_ID
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

			comment = TwicasStream::Comment::GetComments.new(val[:movie_id], val[:offset], val[:limit], val[:slice_id])
			comments = comment.response

			STDOUT.puts

			if key == :test1 or key == :test4 or key == :test6
				if comments.empty?
					STDOUT.puts Test::FAIL
				else
					@pass_num += 1
					STDOUT.puts Test::PASS
				end
			else
				if comments.empty?
					@pass_num += 1
					STDOUT.puts Test::PASS
				else
					STDOUT.puts Test::FAIL
				end
			end

			STDOUT.puts

		}

		@result = true if @pass_num == TEST_NUM

		return @result
	end
end