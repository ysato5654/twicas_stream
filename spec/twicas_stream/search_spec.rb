require 'spec_helper'

RSpec.describe TwicasStream::Search do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'SearchUsers' do
		before :context do
			#DEFAULT_WORDS = 'ツイキャス 公式'
			DEFAULT_WORDS = 'twitcasting'
			DEFAULT_LIMIT = TwicasStream::Search::SearchUsers::DEFAULT_LIMIT
			LOWER_LIMIT   = TwicasStream::Search::SearchUsers::LOWER_LIMIT
			UPPER_LIMIT   = TwicasStream::Search::SearchUsers::UPPER_LIMIT
			DEFAULT_LANG  = 'ja'
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Search::SearchUsers.new(param[:words], param[:limit], param[:lang])
		end

		describe '#new(words, limit, lang)' do
			describe '' do
				let :param do
					{
						:words => words, 
						:limit => DEFAULT_LIMIT, 
						:lang => DEFAULT_LANG
					}
				end

				context 'when word is two word' do
					let :words do
						DEFAULT_WORDS + ' ' + 'jp'
					end

					subject :users do
						response[:users]
					end

					it '' do
						expect(response.keys).to eq([:users])

						expect(users.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
						expect(users.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					end
				end

				context 'when word is one word' do
					let :words do
						DEFAULT_WORDS
					end

					subject :users do
						response[:users]
					end

					it '' do
						expect(response.keys).to eq([:users])

						expect(users.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
						expect(users.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					end
				end

				context 'when word is no word' do
					let :words do
						''
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["words"]).to eq(['length'])
					end
				end
			end

			describe '' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => limit, 
						:lang => DEFAULT_LANG
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :users do
						response[:users]
					end

					it '' do
						expect(response.keys).to eq([:users])

						expect(users.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
						expect(users.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :users do
						response[:users]
					end

					it '' do
						expect(response.keys).to eq([:users])

						expect(users.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
						expect(users.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
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
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => lang
					}
				end

				context 'when lang is japanese' do
					let :lang do
						DEFAULT_LANG
					end

					subject :users do
						response[:users]
					end

					it '' do
						expect(response.keys).to eq([:users])

						expect(users.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
						expect(users.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					end
				end

				context 'when lang is english' do
					let :lang do
						'en'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is chinese' do
					let :lang do
						'ch'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is number' do
					let :lang do
						'123'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is empty' do
					let :lang do
						''
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end
			end
		end
	end

	describe 'SearchLiveMovies' do
		before :context do
			DEFAULT_LIMIT   = TwicasStream::Search::SearchLiveMovies::DEFAULT_LIMIT
			LOWER_LIMIT     = TwicasStream::Search::SearchLiveMovies::LOWER_LIMIT
			UPPER_LIMIT     = TwicasStream::Search::SearchLiveMovies::UPPER_LIMIT
			DEFAULT_TYPE    = 'recommend'
			DEFAULT_CONTEXT = '初心者'
			DEFAULT_LANG    = 'ja'
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Search::SearchLiveMovies.new(param[:limit], param[:type], param[:context], param[:lang])
		end

		describe '#new(limit, type, context, lang)' do
			describe '' do
				let :param do
					{
						:limit => limit, 
						:type => DEFAULT_TYPE, 
						:context => DEFAULT_CONTEXT, 
						:lang => DEFAULT_LANG
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :movies do
						response[:movies]
					end

					it '' do
						expect(response.keys).to eq([:movies])

						expect(movies.first.keys).to eq([:movie, :broadcaster, :tags])
						expect(movies.last.keys).to eq([:movie, :broadcaster, :tags])
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :movies do
						response[:movies]
					end

					it '' do
						expect(response.keys).to eq([:movies])

						expect(movies.first.keys).to eq([:movie, :broadcaster, :tags])
						expect(movies.last.keys).to eq([:movie, :broadcaster, :tags])
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
						:limit => DEFAULT_LIMIT, 
						:type => type, 
						:context => DEFAULT_CONTEXT, 
						:lang => DEFAULT_LANG
					}
				end

				context 'when type is recommend' do
					let :type do
						DEFAULT_TYPE
					end

					subject :movies do
						response[:movies]
					end

					it '' do
						expect(response.keys).to eq([:movies])

						expect(movies.first.keys).to eq([:movie, :broadcaster, :tags])
						expect(movies.last.keys).to eq([:movie, :broadcaster, :tags])
					end
				end

				context 'wrong string' do
					let :type do
						DEFAULT_TYPE + 'hogehoge'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["type"]).to eq(['in'])
					end
				end

				context 'when type is number' do
					let :type do
						'123'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["type"]).to eq(['in'])
					end
				end

				context 'when type is empty' do
					let :type do
						''
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["type"]).to eq(['in'])
					end
				end
			end

			describe '' do
				let :param do
					{
						:limit => DEFAULT_LIMIT, 
						:type => DEFAULT_TYPE, 
						:context => DEFAULT_CONTEXT, 
						:lang => lang
					}
				end

				context 'when lang is japanese' do
					let :lang do
						DEFAULT_LANG
					end

					subject :movies do
						response[:movies]
					end

					it '' do
						expect(response.keys).to eq([:movies])

						expect(movies.first.keys).to eq([:movie, :broadcaster, :tags])
						expect(movies.last.keys).to eq([:movie, :broadcaster, :tags])
					end
				end

				context 'when lang is english' do
					let :lang do
						'en'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is chinese' do
					let :lang do
						'ch'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is number' do
					let :lang do
						'123'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end

				context 'when lang is empty' do
					let :lang do
						''
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["lang"]).to eq(['in'])
					end
				end
			end
		end
	end
end
