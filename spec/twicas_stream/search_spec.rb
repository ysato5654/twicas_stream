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
			DEFAULT_WORDS = 'ツイキャス 公式'
			DEFAULT_LIMIT = TwicasStream::Search::SearchUsers::DEFAULT_LIMIT
			LOWER_LIMIT   = TwicasStream::Search::SearchUsers::LOWER_LIMIT
			UPPER_LIMIT   = TwicasStream::Search::SearchUsers::UPPER_LIMIT
			DEFAULT_LANG  = 'ja'
		end

		subject :search_users do
			api.response
		end

		let :api do
			TwicasStream::Search::SearchUsers.new(param[:words], param[:limit], param[:lang])
		end

		describe 'word is' do
			context 'two words' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => DEFAULT_LANG
					}
				end

				it '' do
					expect(search_users.keys).to eq([:users])
				end
			end

			context 'one word' do
				let :param do
					{
						:words => 'ツイキャス', 
						:limit => DEFAULT_LIMIT, 
						:lang => DEFAULT_LANG
					}
				end

				it '' do
					expect(search_users.keys).to eq([:users])
				end
			end

			context 'no word' do
				let :param do
					{
						:words => '', 
						:limit => DEFAULT_LIMIT, 
						:lang => DEFAULT_LANG
					}
				end

				it '' do
					expect(search_users.keys).to eq([:error])
				end
			end
		end

		describe 'limit is' do
			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:words => DEFAULT_WORDS, 
							:limit => LOWER_LIMIT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_users.keys).to eq([:users])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:words => DEFAULT_WORDS, 
							:limit => UPPER_LIMIT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_users.keys).to eq([:users])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:words => DEFAULT_WORDS, 
							:limit => LOWER_LIMIT - 1, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_users.keys).to eq([:error])
					end
				end

				context 'over upper limit' do
					let :param do
						{
							:words => DEFAULT_WORDS, 
							:limit => UPPER_LIMIT + 1, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_users.keys).to eq([:error])
					end
				end
			end
		end

		describe 'language is' do
			context 'japanese' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => DEFAULT_LANG
					}
				end

				it '' do
					expect(search_users.keys).to eq([:users])
				end
			end

			context 'english' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => 'en'
					}
				end

				it '' do
					expect(search_users.keys).to eq([:error])
				end
			end

			context 'chinese' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => 'ch'
					}
				end

				it '' do
					expect(search_users.keys).to eq([:error])
				end
			end

			context 'number' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => '123'
					}
				end

				it '' do
					expect(search_users.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :param do
					{
						:words => DEFAULT_WORDS, 
						:limit => DEFAULT_LIMIT, 
						:lang => ''
					}
				end

				it '' do
					expect(search_users.keys).to eq([:error])
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

		subject :search_movies do
			api.response
		end

		let :api do
			TwicasStream::Search::SearchLiveMovies.new(param[:limit], param[:type], param[:context], param[:lang])
		end

		describe 'limit is' do
			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:limit => LOWER_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_movies.keys).to eq([:movies])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:limit => UPPER_LIMIT, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_movies.keys).to eq([:movies])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:limit => LOWER_LIMIT - 1, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_movies.keys).to eq([:error])
					end
				end

				context 'over upper limit' do
					let :param do
						{
							:limit => UPPER_LIMIT + 1, 
							:type => DEFAULT_TYPE, 
							:context => DEFAULT_CONTEXT, 
							:lang => DEFAULT_LANG
						}
					end

					it '' do
						expect(search_movies.keys).to eq([:error])
					end
				end
			end
		end
	end
end
