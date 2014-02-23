require 'spec_helper'

describe "The Designer News API client" do

  context "Creating the client" do
    it "instantiates a client with proper configuration" do
      DesignerNews.reset!
      expect(DesignerNews.client).to be_kind_of DesignerNews::Client
    end
  end

end