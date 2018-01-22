require 'spec_helper'

RSpec.describe TwicasStream::Category do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetCategories' do
		subject :categories do
			api.response
		end

		let :api do
			TwicasStream::Category::GetCategories.new(lang)
		end

		describe 'language is' do
			context 'japanese' do
				let :lang do
					'ja'
				end

				it '' do
					expect(categories.keys).to eq([:categories])
				end
			end

			context 'english' do
				let :lang do
					'en'
				end

				it '' do
					expect(categories.keys).to eq([:categories])
				end
			end

			context 'chinese' do
				let :lang do
					'ch'
				end

				it '' do
					expect(categories.keys).to eq([:categories])
				end
			end

			context 'number' do
				let :lang do
					'123'
				end

				it '' do
					expect(categories.keys).to eq([:error])
				end
			end

			context 'empty string' do
				let :lang do
					''
				end

				it '' do
					expect(categories.keys).to eq([:error])
				end
			end
		end
	end
end
