#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestGetUserInfo
	attr_reader :pass_num
	attr_reader :result

	DEFAULT_USER_ID = 'twitcasting_jp'

	PARAM = {
				:test1 => {
							:description => 'existing user', 
							:user_id => DEFAULT_USER_ID
						}, 
				:test2 => {
							:description => 'no existing user', 
							:user_id => DEFAULT_USER_ID + 'hogehoge'
						}, 
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
			Test.description(val[:description])

			TwicasStream.reset

			TwicasStream.configure do |request_header|
				request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
			end

			api = TwicasStream::User::GetUserInfo.new(val[:user_id])
			user_info = api.response

			STDOUT.puts

			if val[:user_id] == DEFAULT_USER_ID
				if user_info.keys == [:user]
					@pass_num += 1
					STDOUT.puts Test::PASS
				else
					STDOUT.puts Test::FAIL
				end
			else
				if user_info.keys == [:error]
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
