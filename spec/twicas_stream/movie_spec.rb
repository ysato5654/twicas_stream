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

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetMovieInfo.new(movie_id)
		end

		describe '#new(movie_id)' do
			context 'when movie_id is existence' do
				let :movie_id do
					DEFAULT_MOVIE_ID
				end

				subject :movie do
					response[:movie]
				end

				subject :broadcaster do
					response[:broadcaster]
				end

				subject :tags do
					response[:tags]
				end

				it '' do
					expect(response.keys).to eq([:movie, :broadcaster, :tags])

					expect(movie.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
					expect(broadcaster.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					expect(tags).to be_kind_of(Array)
				end
			end

			context 'when movie_id is no existence' do
				let :movie_id do
					DEFAULT_MOVIE_ID + 'hogehoge'
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

			context 'when movie_id is empty' do
				let :movie_id do
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

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetMoviesbyUser.new(param[:user_id], param[:offset], param[:limit], param[:slice_id])
		end

		describe '#new(user_id, offset, limit, slice_id)' do
			describe '' do
				let :param do
					{
						:user_id => user_id, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when user_id is existence' do
					let :user_id do
						DEFAULT_USER_ID
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
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
			end

			describe '' do
				let :param do
					{
						:user_id => DEFAULT_USER_ID, 
						:offset => offset, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when offset is equal to lower limit (within limitation)' do
					let :offset do
						LOWER_OFFSET
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end
=begin
				context 'when offset is equal to upper limit (within limitation)' do
					let :offset do
						UPPER_OFFSET
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end
=end
				context 'when offset is less than lower limit (out of limitation)' do
					let :offset do
						LOWER_OFFSET - 1
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["offset"]).to eq(['min'])
					end
				end

				context 'when offset is over upper limit (out of limitation)' do
					let :offset do
						UPPER_OFFSET + 1
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["offset"]).to eq(['max'])
					end
				end
			end

			describe '' do
				let :param do
					{
						:user_id => DEFAULT_USER_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => limit, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end

				context 'when limit is less than lower limit (out of limitation)' do
					let :limit do
						LOWER_LIMIT - 1
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["limit"]).to eq(['min'])
					end
				end

				context 'when limit is over upper limit (out of limitation)' do
					let :limit do
						UPPER_LIMIT + 1
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["limit"]).to eq(['max'])
					end
				end
			end

			describe '' do
				let :param do
					{
						:user_id => DEFAULT_USER_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => slice_id
					}
				end
=begin
				context 'when slice_id is equal to lower limit (within limitation)' do
					let :slice_id do
						LOWER_SLICE_ID
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end
=end
				context 'when slice_id is less than lower limit (out of limitation)' do
					let :slice_id do
						LOWER_SLICE_ID - 1
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["slice_id"]).to eq(['min'])
					end
				end

				context 'when slice_id is none (default)' do
					let :slice_id do
						DEFAULT_SLICE_ID
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
				end

				context 'when slice_id is incorrect string' do
					let :slice_id do
						DEFAULT_SLICE_ID + 'hogehoge'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["slice_id"]).to eq(['intVal', 'min'])
					end
				end

				context 'when slice_id is empty (Although invalid parameter, API responses correctly.)' do
					let :slice_id do
						''
					end

					subject :movies do
						response[:movies]
					end

					subject :total_count do
						response[:total_count]
					end

					it '' do
						expect(response.keys).to eq([:movies, :total_count])

						expect(movies.first.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(movies.last.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
						expect(total_count).to be_kind_of(Integer)
					end
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

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Movie::GetCurrentLive.new(user_id)
		end

		describe '#new(user_id)' do
			context 'when user_id is existence' do
				let :user_id do
					@movies.first[:broadcaster][:id]
				end

				subject :movie do
					response[:movie]
				end

				subject :broadcaster do
					response[:broadcaster]
				end

				subject :tags do
					response[:tags]
				end

				it '' do
					expect(response.keys).to eq([:movie, :broadcaster, :tags])

					expect(movie.keys).to eq([:id, :user_id, :title, :subtitle, :last_owner_comment, :category, :link, :is_live, :is_recorded, :comment_count, :large_thumbnail, :small_thumbnail, :country, :duration, :created, :is_collabo, :is_protected, :max_view_count, :current_view_count, :total_view_count, :hls_url])
					expect(broadcaster.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					expect(tags).to be_kind_of(Array)
				end
			end

			context 'when user_id is existence (not live now)' do
				let :user_id do
					DEFAULT_USER_ID
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

			context 'when user_id is no existence' do
				let :user_id do
					@movies.first[:broadcaster][:id] + 'hogehoge'
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
		end
	end
end
