#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/app')
require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/user')

module TwicasStream
	module User
		class GetUserInfo
			attr_reader :response

			PREFIX_URL = 'users'

			def initialize user_id
				@response = Hash.new

				url = BASE_URL + '/' + PREFIX_URL + '/' + user_id
				# => 'https://apiv2.twitcasting.tv/users/:user_id'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class VerifyCredentials
			attr_reader :response

			PREFIX_URL = 'verify_credentials'

			def initialize
				@response = Hash.new

				url = BASE_URL + '/' + PREFIX_URL
				# => 'https://apiv2.twitcasting.tv/verify_credentials'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
