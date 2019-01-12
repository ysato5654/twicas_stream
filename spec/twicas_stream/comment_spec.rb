require 'spec_helper'

RSpec.describe TwicasStream::Comment do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetComments' do
		before :context do
			DEFAULT_MOVIE_ID = '189037369'
			DEFAULT_OFFSET   = TwicasStream::Comment::GetComments::DEFAULT_OFFSET
			LOWER_OFFSET   = TwicasStream::Comment::GetComments::LOWER_OFFSET
			DEFAULT_LIMIT    = TwicasStream::Comment::GetComments::DEFAULT_LIMIT
			LOWER_LIMIT      = TwicasStream::Comment::GetComments::LOWER_LIMIT
			UPPER_LIMIT      = TwicasStream::Comment::GetComments::UPPER_LIMIT
			DEFAULT_SLICE_ID = TwicasStream::Comment::GetComments::DEFAULT_SLICE_ID
			LOWER_SLICE_ID   = TwicasStream::Comment::GetComments::LOWER_SLICE_ID
		end

		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Comment::GetComments.new(param[:movie_id], param[:offset], param[:limit], param[:slice_id])
		end

		describe '#new(movie_id, offset, limit, slice_id)' do
			describe '' do
				let :param do
					{
						:movie_id => movie_id, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when movie_id is existence' do
					let :movie_id do
						DEFAULT_MOVIE_ID
					end

					#subject :movie_id do
					#	response[:movie_id]
					#end
					# => multiple of movie_id

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(response[:movie_id]).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
					end
				end

				context 'when movie_id is no existence' do
					let :movie_id do
						'abc'
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

			describe '' do
				let :param do
					{
						:movie_id => DEFAULT_MOVIE_ID, 
						:offset => offset, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when offset is equal to lower limit (within limitation)' do
					let :offset do
						LOWER_OFFSET
					end

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
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
						:movie_id => DEFAULT_MOVIE_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => limit, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				context 'when limit is equal to lower limit (within limitation)' do
					let :limit do
						LOWER_LIMIT
					end

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
					end
				end

				context 'when limit is equal to upper limit (within limitation)' do
					let :limit do
						UPPER_LIMIT
					end

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
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

				context 'when limit is over upper limit (out of limitation): according to API document, upper limit is 50. but, it seems to be 100 correctly. in this test, we set by 101.' do
					let :limit do
						UPPER_LIMIT + UPPER_LIMIT + 1
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
						:movie_id => DEFAULT_MOVIE_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => slice_id
					}
				end

				context 'when slice_id is equal to lower limit (within limitation)' do
					let :slice_id do
						LOWER_SLICE_ID
					end

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
					end
				end

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

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
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

					subject :movie_id do
						response[:movie_id]
					end

					subject :all_count do
						response[:all_count]
					end

					#subject :comments do
					#	response[:comments]
					#end

					it '' do
						expect(response.keys).to eq([:movie_id, :all_count, :comments])

						expect(movie_id).to be_kind_of(String)
						expect(all_count).to be_kind_of(Integer)
						#expect(comments.first.keys).to eq([:id, :message, :from_user, :created])
					end
				end
			end
		end
	end
end
