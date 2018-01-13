#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestGetUserInfo
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_USER_ID = 'twitcasting_jp'

	PARAM = {
				# for 'GetUserInfo' class
				:test1 => {
							:description => 'existing user', 
							:user_id => DEFAULT_USER_ID
						}, 
				# for 'GetUserInfo' class
				:test2 => {
							:description => 'no existing user', 
							:user_id => DEFAULT_USER_ID + 'hogehoge'
						}, 
				# for 'GetUserInfo' class
				:test3 => {
							:description => 'unset user id', 
							:user_id => ''
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

			user = TwicasStream::User::GetUserInfo.new(val[:user_id])
			user_info = user.response

			STDOUT.puts

			if val[:user_id] == DEFAULT_USER_ID
				if user_info.empty?
					STDOUT.puts Test::FAIL
				else
					@pass_num += 1
					STDOUT.puts Test::PASS
				end
			else
				if user_info.empty?
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
