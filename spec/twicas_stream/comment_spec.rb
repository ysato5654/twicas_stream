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
			DEFAULT_LIMIT    = TwicasStream::Comment::GetComments::DEFAULT_LIMIT
			LOWER_LIMIT      = TwicasStream::Comment::GetComments::LOWER_LIMIT
			UPPER_LIMIT      = TwicasStream::Comment::GetComments::UPPER_LIMIT
			DEFAULT_SLICE_ID = TwicasStream::Comment::GetComments::DEFAULT_SLICE_ID
		end

		subject :comments do
			api.response
		end

		let :api do
			TwicasStream::Comment::GetComments.new(param[:movie_id], param[:offset], param[:limit], param[:slice_id])
		end

		describe 'movie id is' do
			context 'existing movie id' do
				let :param do
					{
						:movie_id => DEFAULT_MOVIE_ID, 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				it '' do
					expect(comments.keys).to eq([:movie_id, :all_count, :comments])
				end
			end

			context 'no existing movie -> Not Found (code: 404)' do
				let :param do
					{
						:movie_id => 'abc', 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				it '' do
					expect(comments.keys).to eq([:error])
				end
			end

			context 'empty string -> Not Found (code: 404)' do
				let :param do
					{
						:movie_id => '', 
						:offset => DEFAULT_OFFSET, 
						:limit => DEFAULT_LIMIT, 
						:slice_id => DEFAULT_SLICE_ID
					}
				end

				it '' do
					expect(comments.keys).to eq([:error])
				end
			end
		end

		describe 'limit is' do
			context 'within limitation' do
				context 'equal to lower limit' do
					let :param do
						{
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(comments.keys).to eq([:movie_id, :all_count, :comments])
					end
				end

				context 'equal to upper limit' do
					let :param do
						{
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(comments.keys).to eq([:movie_id, :all_count, :comments])
					end
				end
			end

			context 'out of limitation' do
				context 'less than lower limit' do
					let :param do
						{
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => LOWER_LIMIT - 1, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(comments.keys).to eq([:error])
					end
				end

				context 'over upper limit: according to API document, upper limit is 50. but, it seems to be 100 correctly. in this test, we set by 101.' do
					let :param do
						{
							:movie_id => DEFAULT_MOVIE_ID, 
							:offset => DEFAULT_OFFSET, 
							:limit => UPPER_LIMIT + UPPER_LIMIT + 1, 
							:slice_id => DEFAULT_SLICE_ID
						}
					end

					it '' do
						expect(comments.keys).to eq([:error])
					end
				end
			end
		end
	end
end
