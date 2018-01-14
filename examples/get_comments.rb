#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	movie_id = '189037369'
	api = TwicasStream::Comment::GetComments.new(movie_id)
	comments = api.response

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
