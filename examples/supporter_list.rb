#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	user_id = 'twitcasting_dev'
	api = TwicasStream::Supporter::SupporterList.new(user_id = user_id, sort = 'new')
	supporters = api.response[:supporters]

	exit(0) unless api.response[:error].nil?

	STDOUT.puts

end
