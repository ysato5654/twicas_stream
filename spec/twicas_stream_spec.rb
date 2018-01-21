require 'spec_helper'

RSpec.describe TwicasStream do
	it 'has a version number' do
		expect(TwicasStream::VERSION).not_to be nil
	end
end
