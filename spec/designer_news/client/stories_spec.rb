require 'spec_helper'

describe 'Stories', :vcr do
  let(:story_id) { 123 }
  let(:query) { "Steve Jobs" }
  let(:comment) { "Thanks for sharing this, I really appreciate it." }

  before do
    DesignerNews.reset!
    @client = DesignerNews::Client.new
  end

  context '.story' do
    it 'returns the User info as JSON' do
      @client.story(story_id)
      assert_requested :get, designer_news_url("stories/#{story_id}")
    end
  end

  context '.search' do
    it 'returns the matching Story objects' do
      pending
      @client.search_stories(query)
      assert_requested :get, designer_news_url("stories/search?query=#{query}")
    end
  end

  context '.stories' do
    it 'returns the frontpage' do
      @client.stories
      assert_requested :get, designer_news_url("stories?page=1")
    end

    it 'returns the second page' do
      @client.stories(2)
      assert_requested :get, designer_news_url("stories?page=2")
    end
  end

  context '.recent_stories' do
    it 'returns the most recent stories' do
      @client.recent_stories
      assert_requested :get, designer_news_url("stories/recent?page=1")
    end

    it 'returns the second most recent stories' do
      @client.recent_stories(2)
      assert_requested :get, designer_news_url("stories/recent?page=2")
    end
  end

  context '.upvote_story' do
    it 'upvotes a story' do
      @client.upvote_story(story_id)
      assert_requested :post, designer_news_url("stories/#{story_id}/upvote")
    end
  end

  context '.reply_to_story' do
    it 'replies to a story' do
      @client.reply_to_story(story_id, comment)
      assert_requested :post, designer_news_url("stories/#{story_id}/reply")
    end
  end

end