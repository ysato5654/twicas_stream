#! /opt/local/bin/ruby
# coding: utf-8

if $0 == __FILE__
	require File.expand_path(File.dirname(__FILE__) + '/../lib/twicas_stream')

	TwicasStream.configure do |request_header|
		#request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))
		# => for developer

		request_header.access_token = 'xxx'# put your access token here
	end

	lang = 'ja'
	api = TwicasStream::Category::GetCategories.new(lang)
	categories = api.response[:categories]

	exit(0) if api.response.empty?

	STDOUT.puts

	STDOUT.puts '--------------------------------'
	STDOUT.puts 'category name'
	STDOUT.puts
	STDOUT.puts '    sub category name'
	STDOUT.puts '--------------------------------'
	categories.each{ |category|
		STDOUT.puts category[:name]
		STDOUT.puts
		category[:sub_categories].each{ |sub_category|
			STDOUT.puts '    ' + sub_category[:name]
		}
		STDOUT.puts '--------------------------------'
	}

	STDOUT.puts

end
