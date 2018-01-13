#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/user')

module TwicasStream
	module TwicasApiObject
		class Comment
			attr_reader :objects

			def initialize elements = []
				@objects = Array.new

				elements.each{ |element|
					from_user = User.new(element['from_user'])

					object = {
								:id        => element['id'],
								:message   => element['message'],
								:from_user => from_user.object, 
								:created   => element['created']
							}

					@objects.push object
				}
			end
		end
	end
end
