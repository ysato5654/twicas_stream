#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/request_header')

require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/user')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/live_thumbnail')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/movie')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/comment')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/supporter')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/category')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/search')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/version')

require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/twicas_api_object/error')

require 'active_support/inflector'
require 'curb'
require 'json'
require 'open-uri'

module TwicasStream
	extend RequestHeader

	BASE_URL = 'https://apiv2.twitcasting.tv'

	class << self
		def parse result
			response = Hash.new

			response_code = response_code(result)
			body = body(result)
			header = header(result)

			body.each{ |key, value|
				# special if statement for the key into following method
				# * 'movies' key of 'SearchLiveMovies' method
				# * 'movies' key of 'GetMoviesbyUser' method
				if key == 'movies'
					# 'SearchLiveMovies'
					if is_TwicasApiObject?(value.first.keys.first)
						response[key.to_sym] = value.map{ |i|
							child_response = Hash.new

							i.each{ |child_key, child_value| child_response[child_key.to_sym] = parse_deep(child_key, child_value) }

							child_response
						}
					# 'GetMoviesbyUser'
					else
						response[key.to_sym] = value.map{ |i| parse_deep(key, i) }
					end

				# special if statement for 'SupporterUser' as TwicasApiObject into 'SupportingList' and 'SupporterList' method, because these keys are is_TwicasApiObject?(key) = false
				# * 'supporting' key of 'SupportingList' method
				# * 'supporters' key of 'SupporterList' method
				elsif key == 'supporting' or key == 'supporters'
					response[key.to_sym] = value.map{ |i| parse_deep('SupporterUser', i) }

				# plural form
				# * 'users' key of 'SearchUsers' method
				# * 'categories' key of 'GetCategories' method
				# * 'comments' key of 'GetComments' method
				elsif (key != key.singularize) and is_TwicasApiObject?(key)
					response[key.to_sym] = value.map{ |i| parse_deep(key, i) }

				# singular form, and others
				else
					response[key.to_sym] = parse_deep(key, value)

				end
			}

			response
		end

		def response_code result
			result[:response_code]
		end

		def body result
			result[:body]
		end

		def header result
			result[:header]
		end

		def get url
			c = Curl.get(url) do |curl|
				TwicasStream.configure do |request_header|
					curl.headers['X-Api-Version'] = request_header.api_version
					curl.headers['Accept'] = request_header.accept_encoding
					curl.headers['Authorization'] = 'Bearer ' + request_header.access_token
				end
			end

			response, *headers = c.header_str.split(/[\r\n]+/).map(&:strip)
			headers = Hash[headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]

			{ :header => headers, :body => JSON.parse(c.body_str), :response_code => c.response_code }
		end

		def get_image url, path
			c = Curl.get(url)

			response, *headers = c.header_str.split(/[\r\n]+/).map(&:strip)
			headers = Hash[headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]

			save_image(path, headers['Location'])
		end

		def make_query_string options
			query = "?"
			options.each do |key, value|
				query += "#{key}=#{value.to_s.gsub(" ", "+")}&"
			end

			query[0...-1]
		end

		private
		def parse_deep key, value
			if is_TwicasApiObject?(key)
				str = [self.to_s, 'TwicasApiObject', key.singularize.camelize].join('::')
				api = Object.const_get(str).new(value)

				return api.object

			# called by 'GetMovieInfo' or 'GetSupportingStatus' method
			elsif key == 'broadcaster' or key == 'target_user'
				str = [self.to_s, 'TwicasApiObject', 'User'].join('::')
				api = Object.const_get(str).new(value)

				return api.object

			else
				return value

			end
		end

		private
		def is_TwicasApiObject? str
			TwicasApiObject.constants.include?(str.singularize.camelize.to_sym)
			# TwicasApiObject.constants
			# => [:App, :User, :Movie, :Comment, :SupporterUser, :SubCategory, :Category, :Error]
		end

		private
		def save_image path, image_url
			begin
				filepath = path + File.basename(image_url)
			rescue Exception => e
				STDERR.puts "#{__FILE__}:#{__LINE__}:Error: #{e.message}"
				filepath = ''
			else
				File.open(filepath, 'wb') do |file|
					open(image_url) do |data|
						file.write(data.read)
					end
				end
			end

			filepath
		end
	end
end
