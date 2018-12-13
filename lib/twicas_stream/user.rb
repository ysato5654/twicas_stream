#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/app')
require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/user')

module TwicasStream
	module User
		class GetUserInfo
			attr_reader :response
						   # {
						   # 	:supporter_count => 10,
						   # 	:supporting_count => 24,
						   # 	:user => {
						   # 				:id => "182224938",
						   # 				:screen_id => "twitcasting_jp",
						   # 				:name => "ツイキャス公式",
						   # 				:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
						   # 				:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページ:ttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
						   # 				:level => 24,
						   # 				:last_movie_id => "466324920",
						   # 				:is_live => false,
						   # 				:supporter_count => 0,
						   # 				:supporting_count => 0,
						   # 				:created => 0
						   # 			}
						   # }

			PREFIX_URL = 'users'

			def initialize user_id
				@response = Hash.new

				url = [BASE_URL, PREFIX_URL, user_id].join('/')
				# => 'https://apiv2.twitcasting.tv/users/:user_id'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class VerifyCredentials
			attr_reader :response
						   # {
						   # 	:app => {
						   # 				:client_id => "182224938.d37f58350925d568e2db24719fe86f11c4d14e0461429e8b5da732fcb1917b6e",
						   # 				:name => "サンプルアプリケーション",
						   # 				:owner_user_id => "182224938"
						   # 		},
						   # 	:supporter_count => 10,
						   # 	:supporting_count => 24,
						   # 	:user => {
						   # 				:id => "182224938",
						   # 				:screen_id => "twitcasting_jp",
						   # 				:name => "ツイキャス公式",
						   # 				:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
						   # 				:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページ:ttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
						   # 				:level => 24,
						   # 				:last_movie_id => "466324920",
						   # 				:is_live => false,
						   # 				:supporter_count => 0,
						   # 				:supporting_count => 0,
						   # 				:created => 0
						   # 			}
						   # }

			PREFIX_URL = 'verify_credentials'

			def initialize
				@response = Hash.new

				url = [BASE_URL, PREFIX_URL].join('/')
				# => 'https://apiv2.twitcasting.tv/verify_credentials'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
