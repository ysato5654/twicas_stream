#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/user')

module TwicasStream
	module TwicasApiObject
		class Comment
			attr_reader :object

			def initialize elements = {}
				from_user = User.new(elements['from_user'])

				@object = {
							:id        => elements['id'],
							:message   => elements['message'],
							:from_user => from_user.object, 
							:created   => elements['created']
						}
			end
		end
	end
end
