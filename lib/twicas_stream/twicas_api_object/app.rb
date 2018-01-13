#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class App
			attr_reader :object

			def initialize elements = {}
				@object = {
							:client_id     => elements['client_id'],
							:name          => elements['name'],
							:owner_user_id => elements['owner_user_id']
						}
			end
		end
	end
end
