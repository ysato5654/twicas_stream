#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	movie_id = '189037369'
	api = TwicasStream::Movie::GetMovieInfo.new(movie_id)
	movie_info = api.response[:movie]

	STDOUT.puts

	STDOUT.puts 'Movie ID is ' + movie_info[:id]
	STDOUT.puts

	STDOUT.puts '<Title>'
	STDOUT.puts movie_info[:title] + ' ~ ' + movie_info[:subtitle]
	STDOUT.puts

	STDOUT.puts '<Tags>'
	STDOUT.puts api.response[:tags]
	STDOUT.puts

	STDOUT.puts 'Current View Count = ' + movie_info[:current_view_count].to_s
	STDOUT.puts 'Total View Count = ' + movie_info[:total_view_count].to_s

end
