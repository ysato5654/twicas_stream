#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/user')
require File.expand_path(File.dirname(__FILE__) + '/twicas_api_object/supporter_user')

module TwicasStream
	module Supporter
		class GetSupportingStatus
			attr_reader :response

			PREFIX_URL = 'users'

			SUFFIX_URL = 'supporting_status'

			def initialize user_id, target_user_id
				@response = Hash.new
				param = Hash.new

				param['target_user_id'] = target_user_id

				url = [BASE_URL, PREFIX_URL, user_id, SUFFIX_URL].join('/') + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/users/:user_id/supporting_status?target_user_id=casma_jp'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class SupportUser
		end

		class UnsupportUser
		end

		class SupportingList
			attr_reader :response

			PREFIX_URL = 'users'

			SUFFIX_URL = 'supporting'

			DEFAULT_OFFSET = 0

			LOWER_OFFSET = 0

			DEFAULT_LIMIT = 20

			LOWER_LIMIT = 1

			UPPER_LIMIT = 20

			def initialize user_id, offset = DEFAULT_OFFSET, limit = DEFAULT_LIMIT
				@response = Hash.new
				param = Hash.new

				if offset < LOWER_OFFSET
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. offset should be over than #{LOWER_OFFSET}."
				end

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limit range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}."
				end

				param['offset'] = offset
				param['limit'] = limit

				url = [BASE_URL, PREFIX_URL, user_id, SUFFIX_URL].join('/') + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/users/twitcasting_jp/supporting?offset=10&limit=20'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end

		class SupporterList
			attr_reader :response

			PREFIX_URL = 'users'

			SUFFIX_URL = 'supporters'

			DEFAULT_OFFSET = 0

			LOWER_OFFSET = 0

			DEFAULT_LIMIT = 20

			LOWER_LIMIT = 1

			UPPER_LIMIT = 20

			SORT_LIMITATION = ['new', 'ranking']

			def initialize user_id, offset = DEFAULT_OFFSET, limit = DEFAULT_LIMIT, sort
				@response = Hash.new
				param = Hash.new

				if offset < LOWER_OFFSET
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. offset should be over than #{LOWER_OFFSET}."
				end

				unless limit >= LOWER_LIMIT and limit <= UPPER_LIMIT
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. limit range is #{LOWER_LIMIT} ~ #{UPPER_LIMIT}."
				end

				unless SORT_LIMITATION.include?(sort)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. sort is '#{SORT_LIMITATION.join("' or '")}'."
				end

				param['offset'] = offset
				param['limit'] = limit
				param['sort'] = sort

				url = [BASE_URL, PREFIX_URL, user_id, SUFFIX_URL].join('/') + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/users/twitcasting_jp/supporting?offset=10&limit=20'

				@response = TwicasStream.parse(TwicasStream.get(url))
			end
		end
	end
end
