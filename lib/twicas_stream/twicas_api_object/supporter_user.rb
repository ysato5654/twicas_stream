#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class SupporterUser
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
							:supporter_count  => elements['supporter_count'],
							:supporting_count => elements['supporting_count'],
							:created          => elements['created'], 
							:point            => elements['point'],
							:total_point      => elements['total_point']
						}
			end
		end
	end
end
