#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	path = File.expand_path(File.dirname(__FILE__)) + '/'
	user_id = 'twitcasting_jp'
	api = TwicasStream::LiveThumbnail::GetLiveThumbnailImage.new(path, user_id)

	exit(0) if api.filepath.empty?

	STDOUT.puts 'saved image is here.'
	STDOUT.puts api.filepath

end
