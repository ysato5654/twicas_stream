#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/sub_category')

module TwicasStream
	module TwicasApiObject
		class Category
			attr_reader :object
						# => {
						   # 	:id => "_channel",
						   # 	:name => "チャンネル",
						   # 	:sub_categories => [
						   # 		{:id => "_system_channel_5", :name => "ミュージックch", :count => 100},
						   # 		{:id => "_system_channel_6", :name => "ママch", :count => 49},
						   # 		{:id => "_system_channel_7", :name => "アニメch", :count => 42}
						   # 	]
						   # }

			def initialize elements = {}
				sub_categories = SubCategory.new(elements['sub_categories'])

				@object = {
							:id             => elements['id'],
							:name           => elements['name'],
							:sub_categories => sub_categories.objects
						}
			end
		end
	end
end
