#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../lib/twicas_stream')

class TestGetCategory
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
							:lang => '123'
						}, 
				:test5 => {
							:description => 'unset language', 
							:lang => ''
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

			api = TwicasStream::Category::GetCategories.new(val[:lang])
			categories = api.response

			STDOUT.puts

			if TwicasStream::Category::GetCategories::LANG_LIMITATION.include?(val[:lang])
				if categories.empty?
					STDOUT.puts Test::FAIL
				else
					@pass_num += 1
					STDOUT.puts Test::PASS
				end
			# special condition for out of support language
			elsif val[:lang].alphabet?
				if categories.keys == [:categories]
					@pass_num += 1
					STDOUT.puts Test::PASS
				else
					STDOUT.puts Test::FAIL
				end
			else
				if categories.keys == [:error]
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
