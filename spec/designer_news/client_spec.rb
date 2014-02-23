require 'spec_helper'

describe 'The API client' do
  context 'Authentication' do
    before do
      DesignerNews.reset!
      @client = DesignerNews.client
    end

    it 'accepts an access token for authentication' do
      @client.access_token = '32efabc231238'
      expect(@client).to be_token_authenticated
    end
  end
end