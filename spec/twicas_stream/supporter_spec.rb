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

		subject :target_user_info do
			api.response
		end

		let :api do
			TwicasStream::Supporter::GetSupportingStatus.new(user_id, target_user_id)
		end

		describe 'user id is' do
			let :target_user_id do
				DEFAULT_TARGET_USER_ID
			end

			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(target_user_info.keys).to eq([:is_supporting, :target_user])
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it '' do
					expect(target_user_info.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(target_user_info.keys).to eq([:error])
				end
			end
		end

		describe 'target user id is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'existing target user id' do
				let :target_user_id do
					DEFAULT_TARGET_USER_ID
				end

				it '' do
					expect(target_user_info.keys).to eq([:is_supporting, :target_user])
				end
			end

			context 'no existing target user id' do
				let :target_user_id do
					DEFAULT_TARGET_USER_ID + 'hogehoge'
				end

				it '' do
					expect(target_user_info.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :target_user_id do
					''
				end

				it '' do
					expect(target_user_info.keys).to eq([:error])
				end
			end
		end
	end

	describe 'SupportingList' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
			DEFAULT_OFFSET  = TwicasStream::Supporter::SupportingList::DEFAULT_OFFSET
			LOWER_OFFSET    = TwicasStream::Supporter::SupportingList::LOWER_OFFSET
			DEFAULT_LIMIT   = TwicasStream::Supporter::SupportingList::DEFAULT_LIMIT
			LOWER_LIMIT     = TwicasStream::Supporter::SupportingList::LOWER_LIMIT
			UPPER_LIMIT     = TwicasStream::Supporter::SupportingList::UPPER_LIMIT
		end

		subject :supporting do
			api.response
		end

		let :api do
			TwicasStream::Supporter::SupportingList.new(user_id, param[:offset], param[:limit])
		end

		describe 'user id is' do
			let :param do
				{
					:offset => DEFAULT_OFFSET, 
					:limit => DEFAULT_LIMIT
				}
			end

			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(supporting.keys).to eq([:total, :supporting])
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it '' do
					expect(supporting.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(supporting.keys).to eq([:error])
				end
			end
		end

		describe 'offset is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'within limitation' do
				context 'equal to lower offset' do
					let :param do
						{
							:offset => LOWER_OFFSET, 
							:limit => DEFAULT_LIMIT
						}
					end

					it '' do
						expect(supporting.keys).to eq([:total, :supporting])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower offset' do
					let :param do
						{
							:offset => LOWER_OFFSET - 1, 
							:limit => DEFAULT_LIMIT
						}
					end

					it '' do
						expect(supporting.keys).to eq([:error])
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
							:limit => LOWER_LIMIT
						}
					end

					it '' do
						expect(supporting.keys).to eq([:total, :supporting])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT
						}
					end

					it '' do
						expect(supporting.keys).to eq([:total, :supporting])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT - 1
						}
					end

					it '' do
						expect(supporting.keys).to eq([:error])
					end
				end

				context 'over upper limit: according to API document, upper limit is 20. but, it seems to be 51 correctly. in this test, we set by 51.' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => 51
						}
					end

					it '' do
						expect(supporting.keys).to eq([:error])
					end
				end
			end
		end
	end

	describe 'SupporterList' do
		before :context do
			DEFAULT_USER_ID = 'twitcasting_jp'
			DEFAULT_OFFSET  = TwicasStream::Supporter::SupporterList::DEFAULT_OFFSET
			LOWER_OFFSET    = TwicasStream::Supporter::SupporterList::LOWER_OFFSET
			DEFAULT_LIMIT   = TwicasStream::Supporter::SupporterList::DEFAULT_LIMIT
			LOWER_LIMIT     = TwicasStream::Supporter::SupporterList::LOWER_LIMIT
			UPPER_LIMIT     = TwicasStream::Supporter::SupporterList::UPPER_LIMIT
		end

		subject :supporters do
			api.response
		end

		let :api do
			TwicasStream::Supporter::SupporterList.new(user_id, param[:offset], param[:limit], param[:sort])
		end

		describe 'user id is' do
			let :param do
				{
					:offset => DEFAULT_OFFSET, 
					:limit => DEFAULT_LIMIT, 
					:sort => 'new'
				}
			end

			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it '' do
					expect(supporters.keys).to eq([:total, :supporters])
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it '' do
					expect(supporters.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it '' do
					expect(supporters.keys).to eq([:error])
				end
			end
		end

		describe 'offset is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'within limitation' do
				context 'equal to lower offset' do
					let :param do
						{
							:offset => LOWER_OFFSET, 
							:limit => DEFAULT_LIMIT, 
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:total, :supporters])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower offset' do
					let :param do
						{
							:offset => LOWER_OFFSET - 1, 
							:limit => DEFAULT_LIMIT, 
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:error])
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
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:total, :supporters])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT, 
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:total, :supporters])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT - 1, 
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:error])
					end
				end

				context 'over upper limit: according to API document, upper limit is 20. but, it seems to be 51 correctly. in this test, we set by 51.' do
					let :param do
						{
							:offset => DEFAULT_OFFSET, 
							:limit => 51, 
							:sort => 'new'
						}
					end

					it '' do
						expect(supporters.keys).to eq([:error])
					end
				end
			end
		end

		describe 'sort is' do
			let :user_id do
				DEFAULT_USER_ID
			end

			context 'new' do
				let :param do
					{
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:sort => 'new'
					}
				end

				it '' do
					expect(supporters.keys).to eq([:total, :supporters])
				end
			end

			context 'ranking' do
				let :param do
					{
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:sort => 'ranking'
					}
				end

				it '' do
					expect(supporters.keys).to eq([:total, :supporters])
				end
			end

			context 'old' do
				let :param do
					{
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:sort => 'old'
					}
				end

				it '' do
					expect(supporters.keys).to eq([:error])
				end
			end
		end
	end
end
