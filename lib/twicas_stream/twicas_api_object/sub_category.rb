#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class SubCategory
			attr_reader :objects

			def initialize elements = []
				@objects = Array.new

				elements.each{ |element|
					object = {
								:id    => element['id'],
								:name  => element['name'],
								:count => element['count']
							}

					@objects.push object
				}
			end
		end
	end
end
