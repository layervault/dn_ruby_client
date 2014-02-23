require 'spec_helper'

describe 'Comments', :vcr do
  let(:story_id) { 123 }
  let(:comment_id) { 1234 }
  let(:comment) { "You bring up a set of good points. Thanks!" }

  before do
    DesignerNews.reset!
    @client = DesignerNews::Client.new
  end

  context '.upvote_comment' do
    it "upvotes a comment" do
      @client.upvote_comment(comment_id)
      assert_requested :post, designer_news_url("comments/#{comment_id}/upvote")
    end
  end

  context '.reply_to_comment' do
    it "replies to a comment" do
      @client.reply_to_comment(comment_id, comment)
      assert_requested :post, designer_news_url("comments/#{comment_id}/reply")
    end
  end

  context '.comment' do
    it "returns a comment with an id" do
      @client.comment(comment_id)
      assert_requested :get, designer_news_url("comments/#{comment_id}")
    end
  end
end