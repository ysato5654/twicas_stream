#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/comment')

module TwicasStream
	module Comment
		class GetComments
			attr_reader :response
						# =>  {
						   # 	:movie_id => "189037369",
						   # 	:all_count => 2124,
						   # 	:comments => [
						   # 					{
						   # 						:id => "7134775954",
						   # 						:message => "モイ！",
						   # 						:from_user => {
						   # 										:id => "182224938",
						   # 										:screen_id => "twitcasting_jp",
						   # 										:name => "ツイキャス公式",
						   # 										:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
						   # 										:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
						   # 										:level => 24,
						   # 										:last_movie_id => "189037369",
						   # 										:is_live => false,
						   # 										:supporter_count => 0,
						   # 										:supporting_count => 0,
						   # 										:created => 0
						   # 									},
						   # 						:created => 1479579471
						   # 					},
						   # 					:
						   # 					:
						   # 				]
						   # }

			PREFIX_URL = 'movies'

			SUFFIX_URL = 'comments'

			DEFAULT_OFFSET = 0

			DEFAULT_LIMIT = 10

			LOWER_LIMIT = 1

			UPPER_LIMIT = 50

			DEFAULT_SLICE_ID = 'none'

			def initialize movie_id, offset = DEFAULT_OFFSET, limit = DEFAULT_LIMIT, slice_id = DEFAULT_SLICE_ID
				@response = Hash.new
				param = Hash.new

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limitation range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}."
				end

				param['offset'] = offset
				param['limit'] = limit
				param['slice_id'] = slice_id unless slice_id == DEFAULT_SLICE_ID

				url = [BASE_URL, PREFIX_URL, movie_id, SUFFIX_URL].join('/') + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/movies/:movie_id/comments?offset=0&limit=10'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class PostComment
		end

		class DeleteComment
		end
	end
end
