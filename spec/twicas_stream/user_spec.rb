require 'spec_helper'

RSpec.describe TwicasStream::User do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetUserInfo' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
		end

		subject :user_info do
			api.response
		end

		let :api do
			TwicasStream::User::GetUserInfo.new(user_id)
		end

		describe 'user id is' do
			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(user_info.keys).to eq([:user])
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it '' do
					expect(user_info.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(user_info.keys).to eq([:error])
				end
			end
		end
	end
end
