#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class Error
			attr_reader :object

			def initialize elements = {}
				@object = {
							:code    => elements['code'],
							:message => elements['message'],
							:details => elements['details']
						}
			end
		end
	end
end
