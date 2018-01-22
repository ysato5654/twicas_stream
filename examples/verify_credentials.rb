#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	api = TwicasStream::User::VerifyCredentials.new
	app = api.response[:app]
	user = api.response[:user]

	unless api.response[:error].nil?
		STDOUT.puts

		STDOUT.puts '<Error Code>'
		STDOUT.puts api.response[:error][:code]
		STDOUT.puts

		STDOUT.puts '<Error Message>'
		STDOUT.puts api.response[:error][:message]
		STDOUT.puts

		exit(0)
	end

	STDOUT.puts

	STDOUT.puts '<Client ID>'
	STDOUT.puts app[:client_id]
	STDOUT.puts

	STDOUT.puts '<Application Name>'
	STDOUT.puts app[:name]
	STDOUT.puts

	STDOUT.puts '<Name>'
	STDOUT.puts user[:name]
	STDOUT.puts

	STDOUT.puts '<Screen ID>'
	STDOUT.puts user[:screen_id]
	STDOUT.puts

end
