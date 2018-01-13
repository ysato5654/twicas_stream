#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/sub_category')

module TwicasStream
	module TwicasApiObject
		class Category
			attr_reader :objects
						# => [
						   # 	{
						   # 		:id => "_channel",
						   # 		:name => "チャンネル",
						   # 		:sub_categories => [
						   # 			{:id => "_system_channel_5", :name => "ミュージックch", :count => 100},
						   # 			{:id => "_system_channel_6", :name => "ママch", :count => 49},
						   # 			{:id => "_system_channel_7", :name => "アニメch", :count => 42}
						   # 		]
						   # 	},
						   # 	{
						   # 		:id => "girls_jp",
						   # 		:name => "女子CAS",
						   # 		:sub_categories => [
						   # 			{:id => "girls_face_jp", :name => "女子：顔出し", :count => 66},
						   # 			{:id => "girls_jcjk_jp", :name => "女子：JCJK", :count => 17},
						   # 			{:id => "girls_ljk_jp", :name => "女子：LJK", :count => 89}
						   # 		]
						   # 	}
						   # ]

			def initialize elements = []
				@objects = Array.new

				elements.each{ |element|
					sub_categories = SubCategory.new(element['sub_categories'])

					object = {
									:id             => element['id'],
									:name           => element['name'],
									:sub_categories => sub_categories.objects
								}

					@objects.push object
				}
			end
		end
	end
end
