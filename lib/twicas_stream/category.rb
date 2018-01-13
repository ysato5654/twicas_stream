#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/category')

module TwicasStream
	module Category
		class GetCategories
			attr_reader :response
						# => {
						   # 	:categories => [
						   # 						{
						   # 							:id => "_channel",
						   # 							:name => "チャンネル",
						   # 							:sub_categories => [
						   # 								{:id => "_system_channel_5", :name => "ミュージックch", :count => 100},
						   # 								{:id => "_system_channel_6", :name => "ママch", :count => 49},
						   # 								{:id => "_system_channel_7", :name => "アニメch", :count => 42}
						   # 							]
						   # 						},
						   # 						{
						   # 							:id => "girls_jp",
						   # 							:name => "女子CAS",
						   # 							:sub_categories => [
						   # 								{:id => "girls_face_jp", :name => "女子：顔出し", :count => 66},
						   # 								{:id => "girls_jcjk_jp", :name => "女子：JCJK", :count => 17},
						   # 								{:id => "girls_ljk_jp", :name => "女子：LJK", :count => 89}
						   # 							]
						   # 						}
						   # 					]
						   # }


			PREFIX_URL = 'categories'

			LANG_LIMITATION = ['ja', 'en']

			def initialize lang
				@response = Hash.new
				param = Hash.new

				unless LANG_LIMITATION.include?(lang)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. support language is '#{LANG_LIMITATION[0]}' or '#{LANG_LIMITATION[1]}'"
				end

				param['lang'] = lang

				url = BASE_URL + '/' + PREFIX_URL + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/categories?lang=ja'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
