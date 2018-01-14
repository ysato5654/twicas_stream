#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	movie_id = '189037369'
	api = TwicasStream::Comment::GetComments.new(movie_id)
	comments = api.response

	exit(0) if api.response.empty?

	STDOUT.puts

	STDOUT.puts 'Movie ID is ' + comments[:movie_id]
	STDOUT.puts

	STDOUT.puts '--------------------------------'
	STDOUT.puts 'name' + ' ' + '(' + '@' + 'screen_id' + ')'
	STDOUT.puts
	STDOUT.puts 'message'
	STDOUT.puts 'created time'
	STDOUT.puts '--------------------------------'
	comments[:comments].each{ |comment|
		STDOUT.puts comment[:from_user][:name] + ' ' + '(' + '@' + comment[:from_user][:screen_id] + ')'
		STDOUT.puts
		STDOUT.puts comment[:message]
		STDOUT.puts Time.at(comment[:created])
		STDOUT.puts '--------------------------------'
	}

end
