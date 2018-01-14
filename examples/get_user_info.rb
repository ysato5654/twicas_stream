#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	user_id = 'twitcasting_jp'
	api = TwicasStream::User::GetUserInfo.new(user_id)
	user_info = api.response[:user]

	STDOUT.puts

	STDOUT.puts '<Name>'
	STDOUT.puts user_info[:name]
	STDOUT.puts

	STDOUT.puts '<Screen ID>'
	STDOUT.puts user_info[:screen_id]
	STDOUT.puts

	STDOUT.puts '<Profile>'
	STDOUT.puts user_info[:profile]
	STDOUT.puts

end
