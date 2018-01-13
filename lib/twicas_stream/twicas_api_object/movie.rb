#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module TwicasApiObject
		class Movie
			attr_reader :object

			def initialize elements = {}
				@object = {
							:id                 => elements['id'],
							:user_id            => elements['user_id'],
							:title              => elements['title'],
							:subtitle           => elements['subtitle'],
							:last_owner_comment => elements['last_owner_comment'],
							:category           => elements['category'],
							:link               => elements['link'],
							:is_live            => elements['is_live'],
							:is_recorded        => elements['is_recorded'],
							:comment_count      => elements['comment_count'],
							:large_thumbnail    => elements['large_thumbnail'],
							:small_thumbnail    => elements['small_thumbnail'],
							:country            => elements['country'],
							:duration           => elements['duration'],
							:created            => elements['created'],
							:is_collabo         => elements['is_collabo'],
							:is_protected       => elements['is_protected'],
							:max_view_count     => elements['max_view_count'],
							:current_view_count => elements['current_view_count'],
							:total_view_count   => elements['total_view_count'],
							:hls_url            => elements['hls_url']
						}
			end
		end
	end
end
