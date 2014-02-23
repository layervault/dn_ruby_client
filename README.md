# Designer News Ruby API Client

[![Travis CI](https://travis-ci.org/layervault/dn_ruby_client.png?branch=master)](https://travis-ci.org/layervault/dn_ruby_client)

This is the Ruby client library that wraps the [Designer News API](http://developers.news.layervault.com). It assumes you have used another oAuth 2 library to obtain and manage a valid access token. It is based on
the [Ruby gem for the LayerVault API](https://github.com/layervault/layervault_ruby_client).

## Installation

Put this in your Gemfile and smoke it:

```ruby
gem 'dn'
```

Or install it:

```shell
$ gem install dn
```

## Supported oAuth flows

Currently only [Resource Owner Credentials](https://github.com/applicake/doorkeeper/wiki/Using-Resource-Owner-Password-Credentials-flow) and [Client Credentials](https://github.com/applicake/doorkeeper/wiki/Client-Credentials-flow) are supported.

## Requesting an Access Token

0. Please send an email to news@layervault.com to request your API credentials. Please include your callback URL. One day, this might be automated.
0. Receive a friendly note back from the LayerVault staff with your application credentials.
0. Note your ```client_id``` and ```client_secret```.
0. Try the example Access Token request below.

```
curl -i https://api-news.layervault.com/oauth/token \
  -F grant_type="password" \
  -F username="<username_goes_here>" \
  -F password="<password_goes_here>" \
  -F client_id="<client_id_goes_here>" \
  -F client_secret="<client_secret_goes_here>"
```
3. You now have an access token. You can make API requests by calling via CURL like so:

```
curl -H 'Authorization: Bearer <your access token>' \
  'https://api-news.layervault.com/api/v1/me'
```

## Initializing the Client

You can initialize the client via Environment Variables or by passing configurations options into the client when you create it, like this:

``` ruby
@client = DesignerNews::Client.new({
  access_token: 'your_access_token',
  api_endpoint: 'your_api_endpoint'
})
```

Or you can also say:

``` ruby
DesignerNews.client.access_token = 'access_token'
DesignerNews.client.api_endpoint = 'api_endpoint'
```

### Environment Variables

``` ruby
# You Designer News API access token
ENV['DESIGNER_NEWS_ACCESS_TOKEN']

# The API Endpoint you wish to target calls against (defaults to https://api-news.layervault.com/api/v1/)
ENV['DESIGNER_NEWS_API_ENDPOINT']

# Defaults to Designer News Ruby Gem #{DesignerNews::VERSION}
ENV['DESIGNER_NEWS_USER_AGENT']
```

### The User Agent

You should set the User agent to include your email address so that in the event your client does something wrong we can contact you.

## Making API calls

You can use the `DesignerNews.client.<api_operation>` methods to call the API to perform actions. Alternatively, each API object has simple object model that allows you to say:

``` ruby
DesignerNews.client.access_token = 'access_token'
p = DesignerNews::Organization.for('layervault')
p.create_project('my new project')
```

And so on.

### Simple Object Model

There's a very simple object model provided by classes that implement [Hashie](https://github.com/intridea/hashie) objects that wrap the JSON responses from the ```DesignerNews.client``` interface. The objects mostly all follow a ```.for``` pattern that accepts the appropriate number of arguments for the level of nesting the object represents.

#### Associations

When using the simple object model, associations will be hydrated into the correct child objects for the immediate child relationships only, allowing a simple level of traversal down the object model hierarchy. There is no lazy loding support that will automatically hydrated any deeper associations - you must perform new queries.

## Local Development

Coming soon.

## Client Methods Summary

#### User Info

```
#me
```

#### Stories

```
#story(story_id)
#stories(page_number=1)
#recent_stories(page_number=1)
#search_stories(query)
#upvote_story(story_id)
#reply_to_story(story_id, comment)
```

#### Comments

```
#comment(comment_id)
#upvote_comment(comment_id)
#reply_to_comment(comment_id, comment)
```

#### MOTDs

```
#motd
#upvote_motd
#downvote_motd
```
