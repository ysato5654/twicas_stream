#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestGetMovieInfo
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_MOVIE_ID = '189037369'

	PARAM = {
				:test1 => {
							:description => 'existing movie', 
							:movie_id => DEFAULT_MOVIE_ID
						}, 
				:test2 => {
							:description => 'no existing movie', 
							:movie_id => DEFAULT_MOVIE_ID + 'hogehoge'
							}, 
				:test3 => {
							:description => 'unset movie id', 
							:movie_id => ''
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
			Test.description(val[:description])

			api = TwicasStream::Movie::GetMovieInfo.new(val[:movie_id])
			movie_info = api.response

			STDOUT.puts

			if val[:movie_id] == DEFAULT_MOVIE_ID
				if movie_info.empty?
					STDOUT.puts Test::FAIL
				else
					@pass_num += 1
					STDOUT.puts Test::PASS
				end
			else
				if movie_info.empty?
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
