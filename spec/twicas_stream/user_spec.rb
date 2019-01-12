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

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::User::GetUserInfo.new(user_id)
		end

		describe '#new(user_id)' do
			context 'when user_id is existence' do
				let :user_id do
					DEFAULT_USER_ID
				end

				subject :user_info do
					response[:user]
				end

				it '' do
					expect(response.keys).to eq([:supporter_count, :supporting_count, :user])

					expect(user_info.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
				end
			end

			context 'when user_id is no existence' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				subject :error do
					response[:error]
				end

				it '' do
					expect(response.keys).to eq([:error])

					expect(error[:code]).to eq(404)
					expect(error[:message]).to eq('Not Found')
				end
			end

			context 'when user_id is empty' do
				let :user_id do
					''
				end

				subject :error do
					response[:error]
				end

				it '' do
					expect(response.keys).to eq([:error])

					expect(error[:code]).to eq(404)
					expect(error[:message]).to eq('Not Found')
				end
			end

			context 'when user_id is nil' do
				let :user_id do
					nil
				end

				subject :error do
					response[:error]
				end

				it '' do
					expect(response.keys).to eq([:error])

					expect(error[:code]).to eq(404)
					expect(error[:message]).to eq('Not Found')
				end
			end
		end
	end

	describe 'VerifyCredentials' do
		let :api do
			TwicasStream::User::VerifyCredentials.new
		end

		subject :response do
			api.response
		end

		it '' do
			expect(response.keys).to eq([:app, :supporter_count, :supporting_count, :user])

			expect(response[:app].keys).to eq([:client_id, :name, :owner_user_id])
			expect(response[:user].keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
		end
	end
end
