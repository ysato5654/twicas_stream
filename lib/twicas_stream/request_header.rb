#! /opt/local/bin/ruby
# coding: utf-8

module TwicasStream
	module RequestHeader
		REQUEST_HEADER = [
							:accept_encoding,
							:api_version,
							:access_token
						].freeze

		DEFAULT_API_VERSION = '2.0'

		DEFAULT_ACCEPT_ENCODING = 'application/json'

		DEFAULT_ACCESS_TOKEN = ''

		attr_accessor(*REQUEST_HEADER)

		def self.extended(base)
			base.reset
		end

		def configure
			yield self
		end

		def reset
			self.api_version     = DEFAULT_ACCEPT_ENCODING
			self.accept_encoding = DEFAULT_API_VERSION
			self.access_token    = DEFAULT_ACCESS_TOKEN
			self
		end
	end
end
