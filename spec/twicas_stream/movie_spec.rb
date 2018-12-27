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

	describe 'GetMoviesbyUser' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
			DEFAULT_OFFSET   = TwicasStream::Movie::GetMoviesbyUser::DEFAULT_OFFSET
			LOWER_OFFSET     = TwicasStream::Movie::GetMoviesbyUser::LOWER_OFFSET
			UPPER_OFFSET     = TwicasStream::Movie::GetMoviesbyUser::UPPER_OFFSET
			DEFAULT_LIMIT    = TwicasStream::Movie::GetMoviesbyUser::DEFAULT_LIMIT
			LOWER_LIMIT      = TwicasStream::Movie::GetMoviesbyUser::LOWER_LIMIT
			UPPER_LIMIT      = TwicasStream::Movie::GetMoviesbyUser::UPPER_LIMIT
			DEFAULT_SLICE_ID = TwicasStream::Movie::GetMoviesbyUser::DEFAULT_SLICE_ID
			LOWER_SLICE_ID   = TwicasStream::Movie::GetMoviesbyUser::LOWER_SLICE_ID
		end

		subject :movie_info do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetMoviesbyUser.new(user_id, param[:offset], param[:limit], param[:slice_id])
		end

		describe 'user id is' do
			let :param do
				{
					:offset => DEFAULT_OFFSET, 
					:limit => DEFAULT_LIMIT, 
					:slice_id => DEFAULT_SLICE_ID
				}
			end

			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(movie_info.keys).to eq([:movies, :total_count])
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it '' do
					expect(movie_info.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(movie_info.keys).to eq([:error])
				end
			end
		end

		describe 'offset is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:offset => LOWER_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:movies, :total_count])
					end
				end
=begin
				context 'equal to upper limit' do
					let :param do
						{
							:offset => UPPER_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						#expect(movie_info.keys).to eq([:movies, :total_count])
						expect(movie_info.keys).to eq([:error])
					end
				end
=end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:offset => LOWER_OFFSET - 1, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:error])
					end
				end

				context 'over upper limit' do
					let :param do
						{
							:offset => UPPER_OFFSET + 1, 
							:limit => DEFAULT_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:error])
					end
				end
			end
		end

		describe 'limit is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:movies, :total_count])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:movies, :total_count])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT - 1, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:error])
					end
				end

				context 'over upper limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT + 1, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:error])
					end
				end
			end
		end

		describe 'slice id is' do
			let :user_id do
				DEFAULT_USER_ID
			end
=begin
			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET,
							:limit => DEFAULT_LIMIT,
							:slice_id => LOWER_SLICE_ID
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:movies, :total_count])
					end
				end
			end
=end
			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET,
							:limit => DEFAULT_LIMIT,
							:slice_id => LOWER_SLICE_ID - 1
						}
					end

					it '' do
						expect(movie_info.keys).to eq([:error])
					end
				end
			end

			context 'none (default)' do
				let :param do
					{
						:offset => DEFAULT_OFFSET,
						:limit => DEFAULT_LIMIT,
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				it '' do
					expect(movie_info.keys).to eq([:movies, :total_count])
				end
			end

			context 'incorrect string' do
				let :param do
					{
						:offset => DEFAULT_OFFSET,
						:limit => DEFAULT_LIMIT,
						:slice_id => DEFAULT_SLICE_ID + 'hogehoge'
					}
				end

				it '' do
					expect(movie_info.keys).to eq([:error])
				end
			end

			context 'empty string: invalid parameter. but, API responses correctly.' do
				let :param do
					{
						:offset => DEFAULT_OFFSET,
						:limit => DEFAULT_LIMIT,
						:slice_id => ''
					}
				end

				it '' do
					expect(movie_info.keys).to eq([:movies, :total_count])
				end
			end
		end
	end

	describe 'GetCurrentLive' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
		end

		before :context do
			#TwicasStream.reset
			#TwicasStream.configure do |request_header|
			#	request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
			#end

			limit   = TwicasStream::Search::SearchLiveMovies::DEFAULT_LIMIT
			type    = TwicasStream::Search::SearchLiveMovies::TYPE_LIMITATION.first # 'recommend'
			context = ''
			lang    = TwicasStream::Search::SearchLiveMovies::LANG_LIMITATION.first # 'ja'
			api = TwicasStream::Search::SearchLiveMovies.new(limit, type, context, lang)
			@movies = api.response[:movies]
		end

		subject :current_live do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetCurrentLive.new(user_id)
		end

		describe 'user id is' do
			context 'existing user id, and also is live now' do
				let :user_id do
					@movies.first[:broadcaster][:id]
				end

				it '' do
					expect(current_live.keys).to eq([:movie, :broadcaster, :tags])
				end
			end

			context 'existing user id, but is not live now' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(current_live.keys).to eq([:error])
				end
			end

			context 'no existing user id' do
				let :user_id do
					@movies.first[:broadcaster][:id] + 'hogehoge'
				end

				it '' do
					expect(current_live.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(current_live.keys).to eq([:error])
				end
			end
		end
	end
end
