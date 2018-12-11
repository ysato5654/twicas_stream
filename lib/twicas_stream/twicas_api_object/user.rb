#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class User
			attr_reader :object

			def initialize elements = {}
				@object = {
							:id               => elements['id'],
							:screen_id        => elements['screen_id'],
							:name             => elements['name'],
							:image            => elements['image'],
							:profile          => elements['profile'],
							:level            => elements['level'],
							:last_movie_id    => elements['last_movie_id'],
							:is_live          => elements['is_live'],
							:supporter_count  => elements['supporter_count'], # deprecated (2018/09/03's change log)
							:supporting_count => elements['supporting_count'], # deprecated (2018/09/03's change log)
							:created          => elements['created'] # deprecated (2018/08/03's change log)
						}
			end
		end
	end
end
