#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	#words = 'ツイキャス 公式'
	words = 'twitcasting'
	limit = 3
	lang = 'ja'
	api = TwicasStream::Search::SearchUsers.new(words, limit, lang)
	users = api.response[:users]

	exit(0) unless api.response[:error].nil?

	STDOUT.puts

	STDOUT.puts '--------------------------------'
	users.each{ |user|
		STDOUT.puts '<Name>'
		STDOUT.puts user[:name]
		STDOUT.puts

		STDOUT.puts '<Screen ID>'
		STDOUT.puts user[:screen_id]
		STDOUT.puts

		STDOUT.puts '<Profile>'
		STDOUT.puts user[:profile]
		STDOUT.puts

		STDOUT.puts '--------------------------------'
	}

	STDOUT.puts

end
