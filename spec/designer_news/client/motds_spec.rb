require 'spec_helper'

describe 'Comments', :vcr do
  before do
    DesignerNews.reset!
    @client = DesignerNews::Client.new
  end

  context '.motd' do
    it "fetches the motd" do
      @client.motd
      assert_requested :get, designer_news_url("motd")
    end
  end

  context '.upvote_motd' do
    it "fetches the motd" do
      @client.upvote_motd
      assert_requested :post, designer_news_url("motd/upvote")
    end
  end

  context '.downvote_motd' do
    it "fetches the motd" do
      @client.downvote_motd
      assert_requested :post, designer_news_url("motd/downvote")
    end
  end
end