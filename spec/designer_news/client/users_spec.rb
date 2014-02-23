require 'spec_helper'

describe 'Users', :vcr do

  before do
    DesignerNews.reset!
    @client = DesignerNews::Client.new
  end

  context '.me' do
    it 'returns the User info as JSON' do
      @client.me
      assert_requested :get, designer_news_url("me")
    end
  end
end