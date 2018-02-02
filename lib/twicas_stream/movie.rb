#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/movie')
require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/user')

module TwicasStream
	module Movie
		class GetMovieInfo
			attr_reader :response
						# => {
						   # 	:movie => {
						   # 					:id => "189037369",
						   # 					:user_id => "182224938",
						   # 					:title => "ライブ #189037369",
						   # 					:subtitle =>  "ライブ配信中！",
						   # 					:last_owner_comment =>  "もいもい",
						   # 					:category =>  "girls_jcjk_jp",
						   # 					:link => "http://twitcasting.tv/twitcasting_jp/movie/189037369",
						   # 					:is_live => false,
						   # 					:is_recorded => false,
						   # 					:comment_count => 2124,
						   # 					:large_thumbnail => "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1.jpg",
						   # 					:small_thumbnail => "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1-s.jpg",
						   # 					:country => "jp",
						   # 					:duration => 1186,
						   # 					:created => 1438500282,
						   # 					:is_collabo => false,
						   # 					:is_protected => false,
						   # 					:max_view_count => 1675,
						   # 					:current_view_count => 20848,
						   # 					:total_view_count => 20848,
						   # 					:hls_url => "http://twitcasting.tv/twitcasting_jp/metastream.m3u8/?video=1"
						   # 			},
						   # 	:broadcaster => {
						   # 						:id => "182224938",
						   # 						:screen_id => "twitcasting_jp",
						   # 						:name => "ツイキャス公式",
						   # 						:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
						   # 						:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページ:ttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
						   # 						:level => 24,
						   # 						:last_movie_id => "189037369",
						   # 						:is_live => true,
						   # 						:supporter_count =>  10,
						   # 						:supporting_count =>  24,
						   # 						:created => 1282620640
						   # 					},
						   # 	:tags => ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"]
						   # }

			PREFIX_URL = 'movies'

			def initialize movie_id
				@response = Hash.new

				url = [BASE_URL, PREFIX_URL, movie_id].join('/')
				# => 'https://apiv2.twitcasting.tv/movies/:movie_id'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class GetMoviesbyUser
		end

		class GetCurrentLive
		end
	end
end
