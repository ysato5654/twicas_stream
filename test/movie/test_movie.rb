#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../test')

class TestMovie < Test
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
							:description => 'no existing movie', 
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
			STDOUT.puts '-----------------------'
			STDOUT.puts '  ' + val[:description]
			STDOUT.puts '-----------------------'

			movie = TwicasStream::Movie::GetMovieInfo.new(val[:movie_id])
			movie_info = movie.response

			STDOUT.puts

			if val[:movie_id] == DEFAULT_MOVIE_ID
				if movie_info.empty?
					STDOUT.puts TEST_FAIL
				else
					@pass_num += 1
					STDOUT.puts TEST_PASS
				end
			else
				if movie_info.empty?
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

	test = TestMovie.new
	test.start

	Test.summary(test)

end
