#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/user')
require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/movie')

module TwicasStream
	module Search
		class SearchUsers
			attr_reader :response
						# => {
						   # 	:users => [
						   # 				{
						   # 					:id => "182224938",
						   # 					:screen_id => "twitcasting_jp",
						   # 					:name => "ツイキャス公式",
						   # 					:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
						   # 					:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
						   # 					:level => 24,
						   # 					:last_movie_id => "189037369",
						   # 					:is_live => true,
						   # 					:supporter_count =>  10,
						   # 					:supporting_count =>  24,
						   # 					:created => 1282620640
						   # 				},
						   # 				{
						   # 					:id => "2880417757",
						   # 					:screen_id => "twitcasting_pr",
						   # 					:name => "ツイキャス運営事務局",
						   # 					:image => "http://202-234-44-61.moi.st/image3s/pbs.twimg.com/profile_images/740857980137050112/4sIEkzV8_normal.jpg",
						   # 					:profile => "モイ！ ツイキャスを運営しているモイ株式会社広報担当のアカウントです。公式アカウントはこちら！　@twitcasting_jp",
						   # 					:level => 24,
						   # 					:last_movie_id => "323387579",
						   # 					:is_live => false,
						   # 					:supporter_count =>  10,
						   # 					:supporting_count =>  24,
						   # 					:created => 1414474646
						   # 				},
						   # 				:
						   # 				:
						   # 			]
						   # }

			PREFIX_URL = 'search'

			SUFFIX_URL = 'users'

			DEFAULT_LIMIT = 10

			LOWER_LIMIT = 1

			UPPER_LIMIT = 50

			LANG_LIMITATION = ['ja']

			def initialize words, limit = DEFAULT_LIMIT, lang
				@response = Hash.new
				param = Hash.new

				if words.empty?
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: no word."
				end

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limitation range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}."
				end

				unless LANG_LIMITATION.include?(lang)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. currently support language is '#{LANG_LIMITATION.join("', '")}' only."
				end

				param['words'] = words.split(' ').join('+')
				param['limit'] = limit
				param['lang'] = lang

				url = BASE_URL + '/' + PREFIX_URL + '/' + SUFFIX_URL + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/search/users?words=ツイキャス+公式&limit=10&lang=ja'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class SearchLiveMovies
			attr_reader :response
						# => {
						   # 	:movies => [
						   # 					{
						   # 						:movie => {
						   # 									:id => "189037369",
						   # 									:user_id => "182224938",
						   # 									:title => "ライブ #189037369",
						   # 										:
						   # 										:
						   # 								},
						   # 						:broadcaster => {
						   # 									:id => "182224938",
						   # 									:screen_id => "twitcasting_jp",
						   # 									:name => "ツイキャス公式",
						   # 										:
						   # 										:
						   # 								},
						   # 						:tags => ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"]
						   # 					},
						   # 					{
						   # 						:movie => {
						   # 									:id => "323387579",
						   # 									:user_id => "2880417757",
						   # 									:title => "ライブ #323387579",
						   # 										:
						   # 										:
						   # 								},
						   # 						:broadcaster => {
						   # 									:id => "2880417757",
						   # 									:screen_id => "twitcasting_pr",
						   # 									:name => "ツイキャス運営事務局",
						   # 										:
						   # 										:
						   # 								},
						   # 						:tags => ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"]
						   # 					},
						   # 					:
						   # 					:
						   # 				]
						   # }

			PREFIX_URL = 'search'

			SUFFIX_URL = 'lives'

			DEFAULT_LIMIT = 10

			LOWER_LIMIT = 1

			UPPER_LIMIT = 100

			#TYPE_LIMITATION = ['tag', 'word', 'category', 'new', 'recommend']
			TYPE_LIMITATION = ['recommend']

			LANG_LIMITATION = ['ja']

			def initialize limit = DEFAULT_LIMIT, type, context, lang
				@response = Hash.new

				param = Hash.new

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limitation range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}"
				end

				unless TYPE_LIMITATION.include?(type)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. support types is '#{TYPE_LIMITATION.join("', '")}' only."
				end

				unless LANG_LIMITATION.include?(lang)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. currently support language is '#{LANG_LIMITATION.join("', '")}' only."
				end

				param['limit'] = limit
				param['type'] = type
=begin
				if type == 'tag' or type == 'word'
					param['context'] = context.split(' ').join('+')
				elsif type == 'category'
					param['context'] = context
				#else
				# => tag is 'new' or 'recommend', then don't need 'context'
				end
=end
				param['lang'] = lang

				url = BASE_URL + '/' + PREFIX_URL + '/' + SUFFIX_URL + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/search/lives?limit=10&type=recommend&lang=ja'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
