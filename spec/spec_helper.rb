require 'rubygems'
require 'rspec'
require 'json'
require 'designer_news'
require 'vcr'
require 'webmock/rspec'

VCR.configure do |c|
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<DESIGNER_NEWS_LOGIN>") do
    ENV['DESIGNER_NEWS_LOGIN']
  end

  c.filter_sensitive_data("<DESIGNER_NEWS_PASSWORD>") do
    ENV['DESIGNER_NEWS_PASSWORD']
  end

  c.filter_sensitive_data("<<ACCESS_TOKEN>>") do
    ENV['DESIGNER_NEWS_ACCESS_TOKEN']
  end

  c.filter_sensitive_data("<DESIGNER_NEWS_CLIENT_ID>") do
    ENV['DESIGNER_NEWS_CLIENT_ID']
  end

  c.filter_sensitive_data("<DESIGNER_NEWS_CLIENT_SECRET>") do
    ENV['DESIGNER_NEWS_CLIENT_SECRET']
  end

  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true,
    :match_requests_on => [:method,
      VCR.request_matchers.uri_without_param(:md5, :key, :etag, :access_token, :remote_url)]
  }

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].gsub(/\//, "_").split(/\s+/, 2).join("/").gsub(/[^\w\/]+/, "_").downcase
    VCR.use_cassette(name) { example.call }
  end
end

def designer_news_url(url)
  url =~ /^http/ ? url : "#{ENV['DESIGNER_NEWS_API_ENDPOINT']}/#{url}"
end

def random_md5
  identifier = ""
  chars = "0123456789abcdef"
  32.times { identifier << chars[rand(chars.size)] }
  identifier
end

def fixture_path_for(filename)
  File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', filename)
end