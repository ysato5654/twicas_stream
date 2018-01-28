require 'spec_helper'

RSpec.describe TwicasStream::LiveThumbnail do
	before :each do
		TwicasStream.reset
	end

	describe 'GetLiveThumbnailImage' do
		before :context do
			DEFAULT_PATH = File.expand_path(File.dirname(__FILE__)) + '/'
			DEFAULT_USER_ID = 'twitcasting_jp'
			DEFAULT_SIZE = TwicasStream::LiveThumbnail::GetLiveThumbnailImage::DEFAULT_SIZE
			DEFAULT_POSITION = TwicasStream::LiveThumbnail::GetLiveThumbnailImage::DEFAULT_POSITION
		end

		after :context do
			File.delete(DEFAULT_PATH + 'screen-offline-320.jpg') if File.exist?(DEFAULT_PATH + 'screen-offline-320.jpg')
		end

		subject :filepath do
			api.filepath
		end

		let :api do
			TwicasStream::LiveThumbnail::GetLiveThumbnailImage.new(path, user_id, param[:size], param[:position])
		end

		describe 'path is' do
			let :user_id do
				DEFAULT_USER_ID
			end
			let :param do
				{
					:size => DEFAULT_SIZE, 
					:position => DEFAULT_POSITION
				}
			end

			context 'existing path' do
				let :path do
					DEFAULT_PATH
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'no existing path' do
				let :path do
					DEFAULT_PATH + 'hogehoge' + '/'
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end

			context 'empty string' do
				let :path do
					''
				end

				it 'no save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end

			context 'file is not direcotry' do
				let :path do
					DEFAULT_PATH + 'live_thumbnail_spec.rb'
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end
		end

		describe 'user id is' do
			let :path do
				DEFAULT_PATH
			end

			let :param do
				{
					:size => DEFAULT_SIZE, 
					:position => DEFAULT_POSITION
				}
			end

			context 'existing user id' do
				let :user_id do
					DEFAULT_USER_ID
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'no existing user id' do
				let :user_id do
					DEFAULT_USER_ID + 'hogehoge'
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'empty string' do
				let :user_id do
					''
				end

				it 'no save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end
		end

		describe 'size is' do
			let :path do
				DEFAULT_PATH
			end

			let :user_id do
				DEFAULT_USER_ID
			end

			context 'default (small)' do
				let :param do
					{
						:size => DEFAULT_SIZE, 
						:position => DEFAULT_POSITION
					}
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'large' do
				let :param do
					{
						:size => 'large', 
						:position => DEFAULT_POSITION
					}
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'else' do
				let :param do
					{
						:size => 'hogehoge', 
						:position => DEFAULT_POSITION
					}
				end

				it 'no save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end
		end

		describe 'position is' do
			let :path do
				DEFAULT_PATH
			end

			let :user_id do
				DEFAULT_USER_ID
			end

			context 'default (latest)' do
				let :param do
					{
						:size => DEFAULT_SIZE, 
						:position => DEFAULT_POSITION
					}
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'beginning' do
				let :param do
					{
						:size => DEFAULT_SIZE, 
						:position => 'beginning'
					}
				end

				it 'save image file' do
					expect(File.exist?(filepath)).to be true
				end
			end

			context 'else' do
				let :param do
					{
						:size => DEFAULT_SIZE, 
						:position => 'hogehoge'
					}
				end

				it 'no save image file' do
					expect(File.exist?(filepath)).to be false
				end
			end
		end
	end
end
