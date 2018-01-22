#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	limit = 2
	type = 'recommend'
	context = 'ツイキャス 公式'
	lang = 'ja'
	api = TwicasStream::Search::SearchLiveMovies.new(limit, type, context, lang)
	movies = api.response[:movies]

	exit(0) unless api.response[:error].nil?

	STDOUT.puts '--------------------------------'
	movies.each{ |movie|
		STDOUT.puts 'Movie ID is ' + movie[:movie][:id]
		STDOUT.puts

		STDOUT.puts '<Title>'
		STDOUT.puts movie[:movie][:title].to_s + ' ~ ' + movie[:movie][:subtitle].to_s
		STDOUT.puts

		STDOUT.puts '<Tags>'
		STDOUT.puts movie[:tags]
		STDOUT.puts

		STDOUT.puts 'Current View Count = ' + movie[:movie][:current_view_count].to_s
		STDOUT.puts 'Total View Count = ' + movie[:movie][:total_view_count].to_s

		STDOUT.puts '--------------------------------'
	}

	STDOUT.puts

end
