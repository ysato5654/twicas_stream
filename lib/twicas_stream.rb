#! /opt/local/bin/ruby
# coding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/user')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/live_thumbnail')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/movie')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/comment')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/supporter')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/category')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/search')
require File.expand_path(File.dirname(__FILE__) + '/twicas_stream/version')

require 'active_support/inflector'
require 'curb'
require 'json'

module TwicasStream
	BASE_URL = 'https://apiv2.twitcasting.tv'

	API_VERSION = '2.0'

	ACCEPT_ENCODING = 'application/json'

	ACCESS_TOKEN = File.read(File.expand_path(File.dirname(__FILE__) + '/../config/access_token.txt'))

	class << self
		def parse result
			hash = Hash.new

			response = response(result)
			return hash unless response == 200

			body = body(result)

			body.each{ |key, value|
				# here is the plural form of TwicasStream
				if (key != key.singularize) and is_TwicasApiObject?(key)
					if key == 'movies'
						array = Array.new
						value.each{ |e|
							tmp = Hash.new

							e.each{ |child_key, child_value|
								tmp[child_key.to_sym] = parse_deep(child_key, child_value)
							}

							array.push tmp
						}

						hash[key.to_sym] = array

					else
						hash[key.to_sym] = value.map{ |e| parse_deep(key, e) }

					end

				# here is a singular form of TwicasApiObject, also others are here
				else
					hash[key.to_sym] = parse_deep(key, value)

				end
			}

			hash
		end

		def response result
			result[:response]
		end

		def body result
			result[:body]
		end

		def get url
			c = Curl.get(url) do |curl|
				curl.headers['Accept'] = ACCEPT_ENCODING
				curl.headers['X-Api-Version'] = API_VERSION
				curl.headers['Authorization'] = 'Bearer ' + ACCESS_TOKEN
			end

			{ :body => JSON.parse(c.body_str), :response => c.response_code }
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
				str = [self.to_s, 'TwicasApiObject', key.singularize.capitalize].join('::')
				api = Object.const_get(str).new(value)

				return api.object

			# called by 'GetMovieInfo' method
			elsif key == 'broadcaster'
				str = [self.to_s, 'TwicasApiObject', 'User'].join('::')
				api = Object.const_get(str).new(value)

				return api.object

			else
				return value

			end
		end

		private
		def is_TwicasApiObject? str
			TwicasApiObject.constants.include?(str.singularize.capitalize.to_sym)
			# TwicasApiObject.constants
			# => [:App, :User, :Movie, :Comment, :SupporterUser, :SubCategory, :Category]
		end
	end
end
