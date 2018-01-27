#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module LiveThumbnail
		class GetLiveThumbnailImage
			attr_reader :filepath

			PREFIX_URL = 'users'

			INFIX_URL = 'live'

			SUFFIX_URL = 'thumbnail'

			DEFAULT_SIZE = 'small'

			SIZE_LIMITATION = ['large', 'small']

			DEFAULT_POSITION = 'latest'

			POSITION_LIMITATION = ['beginning', 'latest']

			def initialize path, user_id, size = DEFAULT_SIZE, position = DEFAULT_POSITION
				@filepath = ''
				param = Hash.new

				unless File.exists?(path)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Error: no such file or directory - #{path}"
					return
				end

				unless File::ftype(path) == 'directory'
					STDERR.puts "#{__FILE__}:#{__LINE__}:Error: not directory - #{path}"
					return
				end

				unless SIZE_LIMITATION.include?(size)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. support size are '#{SIZE_LIMITATION.join("' or '")}'."
				end

				unless POSITION_LIMITATION.include?(position)
					STDERR.puts "#{__FILE__}:#{__LINE__}:Warning: out of limitation. support position are '#{POSITION_LIMITATION.join("' or '")}'."
				end

				param['size'] = size
				param['position'] = position

				url = BASE_URL + '/' + PREFIX_URL + '/' + user_id + '/' + INFIX_URL + '/' + SUFFIX_URL + TwicasStream.make_query_string(param)
				# => 'https://apiv2.twitcasting.tv/users/twitcasting_jp/live/thumbnail?size=small&position=latest'

				@filepath = TwicasStream.get_image(url, path)
			end
		end
	end
end
