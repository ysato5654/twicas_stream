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
						   # 						:supporter_count => 0,
						   # 						:supporting_count => 0,
						   # 						:created => 0
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
			attr_reader :response

			PREFIX_URL = 'users'

			SUFFIX_URL = 'movies'

			DEFAULT_OFFSET = 0

			LOWER_OFFSET = 0

			UPPER_OFFSET = 1000

			DEFAULT_LIMIT = 20

			LOWER_LIMIT = 1

			UPPER_LIMIT = 50

			DEFAULT_SLICE_ID = 'none'

			LOWER_SLICE_ID = 1

			def initialize user_id, offset = DEFAULT_OFFSET, limit = DEFAULT_LIMIT, slice_id = DEFAULT_SLICE_ID
				@response = Hash.new
				param = Hash.new

				unless offset >= LOWER_OFFSET and offset <= UPPER_OFFSET
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. offset range is #{LOWER_OFFSET} ~ #{UPPER_OFFSET}."
				end

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limit range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}."
				end

				if slice_id.kind_of?(Integer)
					if slice_id < LOWER_SLICE_ID
						STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. slice id (comment id) should be over than #{LOWER_SLICE_ID}."
					end
				else
					unless slice_id == DEFAULT_SLICE_ID
						STDERR.puts "#{__FILE__}:#{__LINE__}:Error: invalid parameter. default is '#{DEFAULT_SLICE_ID}'."
					end
				end

				param['offset'] = offset
				param['limit'] = limit
				param['slice_id'] = slice_id unless slice_id == DEFAULT_SLICE_ID

				url = [BASE_URL, PREFIX_URL, user_id, SUFFIX_URL].join('/') + TwicasStream.make_query_string(param)
				#url = BASE_URL + '/' + PREFIX_URL + '/' + user_id + '/' + SUFFIX_URL + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/users/:user_id/movies?offset=0&limit=20'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class GetCurrentLive
			attr_reader :response

			PREFIX_URL = 'users'

			SUFFIX_URL = 'current_live'

			def initialize user_id
				@response = Hash.new

				#url = [BASE_URL, PREFIX_URL, user_id, SUFFIX_URL].join('/')
				url = BASE_URL + '/' + PREFIX_URL + '/' + user_id + '/' + SUFFIX_URL
				# => 'https://apiv2.twitcasting.tv/users/:user_id/current_live'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
