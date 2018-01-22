require 'spec_helper'

RSpec.describe TwicasStream::Movie do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetMovieInfo' do
		before :context do
			DEFAULT_MOVIE_ID = '189037369'
		end

		subject :movie_info do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetMovieInfo.new(movie_id)
		end

		describe 'movie id is' do
			context 'existing movie id' do
				let :movie_id do
					DEFAULT_MOVIE_ID
				end

				it '' do
					expect(movie_info.keys).to eq([:movie, :broadcaster, :tags])
				end
			end

			context 'no existing movie id' do
				let :movie_id do
					DEFAULT_MOVIE_ID + 'hogehoge'
				end

				it '' do
					expect(movie_info.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :movie_id do
					''
				end

				it '' do
					expect(movie_info.keys).to eq([:error])
				end
			end
		end
	end
end
