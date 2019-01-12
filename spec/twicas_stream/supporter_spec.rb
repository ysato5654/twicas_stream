require 'spec_helper'

RSpec.describe TwicasStream::Supporter do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetSupportingStatus' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
			DEFAULT_TARGET_USER_ID = 'casma_jp'
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Supporter::GetSupportingStatus.new(param[:user_id], param[:target_user_id])
		end

		describe '#new(user_id, target_user_id)' do
			describe '' do
				let :param do
					{
						:user_id => user_id, 
						:target_user_id => DEFAULT_TARGET_USER_ID
					}
				end

				context 'when user_id is existence' do
					let :user_id do
						DEFAULT_USER_ID
					end

					subject :is_supporting do
						response[:is_supporting]
					end

					subject :target_user do
						response[:target_user]
					end

					it '' do
						expect(response.keys).to eq([:is_supporting, :target_user])

						expect(is_supporting).to eq(false)
						expect(target_user.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
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
						:target_user_id => target_user_id
					}
				end

				context 'when target_user_id is existence' do
					let :target_user_id do
						DEFAULT_TARGET_USER_ID
					end

					subject :is_supporting do
						response[:is_supporting]
					end

					subject :target_user do
						response[:target_user]
					end

					it '' do
						expect(response.keys).to eq([:is_supporting, :target_user])

						expect(is_supporting).to eq(false)
						expect(target_user.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created])
					end
				end

				context 'when user_id is no existence' do
					let :target_user_id do
						DEFAULT_TARGET_USER_ID + 'hogehoge'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(400)
						expect(error[:message]).to eq('Bad Request')
					end
				end

				context 'when user_id is empty' do
					let :target_user_id do
						''
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["target_user_id"]).to eq(['length'])
					end
				end
			end
		end
	end

	describe 'SupportingList' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_dev'
			DEFAULT_OFFSET  = TwicasStream::Supporter::SupportingList::DEFAULT_OFFSET
			LOWER_OFFSET    = TwicasStream::Supporter::SupportingList::LOWER_OFFSET
			DEFAULT_LIMIT   = TwicasStream::Supporter::SupportingList::DEFAULT_LIMIT
			LOWER_LIMIT     = TwicasStream::Supporter::SupportingList::LOWER_LIMIT
			UPPER_LIMIT     = TwicasStream::Supporter::SupportingList::UPPER_LIMIT
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Supporter::SupportingList.new(param[:user_id], param[:offset], param[:limit])
		end

		describe '#new(user_id, offset, limit)' do
			describe '' do
				let :param do
					{
						:user_id => user_id, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT
					}
				end

				context 'when user_id is existence' do
					let :user_id do
						DEFAULT_USER_ID
					end

					subject :total do
						response[:total]
					end

					subject :supporting do
						response[:supporting]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporting])

						expect(total).to be_kind_of(Integer)
						expect(supporting.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporting.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
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
						:limit => DEFAULT_LIMIT
					}
				end

				context 'when offset is equal to lower limit (within limitation)' do
					let :offset do
						LOWER_OFFSET
					end

					subject :total do
						response[:total]
					end

					subject :supporting do
						response[:supporting]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporting])

						expect(total).to be_kind_of(Integer)
						expect(supporting.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporting.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

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
			end

			describe '' do
				let :param do
					{
						:user_id => DEFAULT_USER_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => limit
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :total do
						response[:total]
					end

					subject :supporting do
						response[:supporting]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporting])

						expect(total).to be_kind_of(Integer)
						expect(supporting.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporting.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :total do
						response[:total]
					end

					subject :supporting do
						response[:supporting]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporting])

						expect(total).to be_kind_of(Integer)
						expect(supporting.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporting.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
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

				context 'when limit is over upper limit (out of limitation): according to API document, upper limit is 20. but, it seems to be 51 correctly. in this test, we set by 51.' do
					let :limit do
						51
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
		end
	end

	describe 'SupporterList' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_dev'
			DEFAULT_OFFSET  = TwicasStream::Supporter::SupporterList::DEFAULT_OFFSET
			LOWER_OFFSET    = TwicasStream::Supporter::SupporterList::LOWER_OFFSET
			DEFAULT_LIMIT   = TwicasStream::Supporter::SupporterList::DEFAULT_LIMIT
			LOWER_LIMIT     = TwicasStream::Supporter::SupporterList::LOWER_LIMIT
			UPPER_LIMIT     = TwicasStream::Supporter::SupporterList::UPPER_LIMIT
			DEFAULT_SORT    = 'new'
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Supporter::SupporterList.new(param[:user_id], param[:offset], param[:limit], param[:sort])
		end

		describe '#new(user_id, offset, limit, sort)' do
			describe '' do
				let :param do
					{
						:user_id => user_id, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:sort => DEFAULT_SORT
					}
				end

				context 'when user_id is existence' do
					let :user_id do
						DEFAULT_USER_ID
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])
						p response
						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
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
						:sort => DEFAULT_SORT
					}
				end

				context 'when offset is equal to lower limit (within limitation)' do
					let :offset do
						LOWER_OFFSET
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])

						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

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
			end

			describe '' do
				let :param do
					{
						:user_id => DEFAULT_USER_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => limit, 
						:sort => DEFAULT_SORT
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])

						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])

						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
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

				context 'when limit is over upper limit (out of limitation): according to API document, upper limit is 20. but, it seems to be 51 correctly. in this test, we set by 51.' do
					let :limit do
						51
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
						:sort => sort
					}
				end

				context 'when sort is new' do
					let :sort do
						'new'
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])
						p response
						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

				context 'when sort is ranking' do
					let :sort do
						'ranking'
					end

					subject :total do
						response[:total]
					end

					subject :supporters do
						response[:supporters]
					end

					it '' do
						expect(response.keys).to eq([:total, :supporters])
						p response
						expect(total).to be_kind_of(Integer)
						expect(supporters.first.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
						expect(supporters.last.keys).to eq([:id, :screen_id, :name, :image, :profile, :level, :last_movie_id, :is_live, :supporter_count, :supporting_count, :created, :point, :total_point])
					end
				end

				context 'when sort is old' do
					let :sort do
						'old'
					end

					subject :error do
						response[:error]
					end

					it '' do
						expect(response.keys).to eq([:error])

						expect(error[:code]).to eq(1001)
						expect(error[:message]).to eq('Validation error')
						expect(error[:details]["sort"]).to eq(['in'])
					end
				end
			end
		end
	end
end
