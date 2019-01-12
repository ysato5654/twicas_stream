require 'spec_helper'

RSpec.describe TwicasStream::Category do
	before :each do
		TwicasStream.reset
		TwicasStream.configure do |request_header|
			request_header.access_token = File.read(File.expand_path(File.dirname(__FILE__) + '/../../config/access_token.txt'))
		end
	end

	describe 'GetCategories' do
		subject :response do
			api.response
		end

		let :api do
			TwicasStream::Category::GetCategories.new(lang)
		end

		describe '#new(lang)' do
			context 'when lang is japanese' do
				let :lang do
					'ja'
				end

				subject :sub_categories do
					categories.first[:sub_categories]
				end

				subject :categories do
					response[:categories]
				end

				it '' do
					expect(response.keys).to eq([:categories])

					expect(categories.first.keys).to eq([:id, :name, :sub_categories])
					expect(categories.last.keys).to eq([:id, :name, :sub_categories])

					expect(sub_categories.first.keys).to eq([:id, :name, :count])
					expect(sub_categories.last.keys).to eq([:id, :name, :count])
				end
			end

			context 'when lang is english' do
				let :lang do
					'en'
				end

				subject :sub_categories do
					categories.first[:sub_categories]
				end

				subject :categories do
					response[:categories]
				end

				it '' do
					expect(response.keys).to eq([:categories])

					expect(categories.first.keys).to eq([:id, :name, :sub_categories])
					expect(categories.last.keys).to eq([:id, :name, :sub_categories])

					expect(sub_categories.first.keys).to eq([:id, :name, :count])
					expect(sub_categories.last.keys).to eq([:id, :name, :count])
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
