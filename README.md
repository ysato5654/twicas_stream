[![Gem Version](https://badge.fury.io/rb/twicas_stream.svg)](https://badge.fury.io/rb/twicas_stream)
[![Build Status](https://travis-ci.org/ysato5654/twicas_stream.svg?branch=master)](https://travis-ci.org/ysato5654/twicas_stream)
[![Coverage Status](https://coveralls.io/repos/github/ysato5654/twicas_stream/badge.svg?branch=master)](https://coveralls.io/github/ysato5654/twicas_stream?branch=master)

# twicas_stream

[twicas_stream](https://rubygems.org/gems/twicas_stream) provides simple Ruby access to [TwitCasting](https://twitcasting.tv/) APIv2(β).

## Installation

```rb
$ gem install twicas_stream
```

## Documentation / Help

- [Developer API](https://twitcasting.tv/indexapi.php)
- [API Documentation (APIv2)](http://apiv2-doc.twitcasting.tv/)

## Preparation before using

Before using twicas_stream, we need to get access token in order to access TwitCasting API (APIv2).
Flow is as below.

1. Registration  
Create new application, getting access token need 'ClientID' and 'ClientSecret'.
2. Get Access Token  
TwitCasting API (APIv2) provides two types of authorization flow.
For more information, please refer to API Documentation (APIv2).

## Usage

### Get Movie Info

Get comments of movie id which you set

```rb
# (*) following data are just example

TwicasStream.configure do |request_header|
	#request_header.api_version
	# => default is '2.0'
	#request_header.accept_encoding
	# => default is 'application/json'
	# Above value don't need to change, default setting must be enough.

	request_header.access_token = 'xxx'
	# => you must set access token before using.
end

movie_id = '189037369'
api = TwicasStream::Movie::GetMovieInfo.new(movie_id)
movie_info = api.response[:movie]

p movie_info[:title]
# => 'ライブ #189037369'
p movie_info[:subtitle]
# => 'ライブ配信中！'
p movie_info[:current_view_count]
# => 20848
p movie_info[:total_view_count]
# => 20848
p api.response[:tags]
# => ['人気', 'コンティニュー中', 'レベル40+', '初見さん大歓迎', 'まったり', '雑談']
```

### Get Comments

Get comments of movie id which you set

```rb
# (*) following data are just example

TwicasStream.configure do |request_header|
	request_header.access_token = 'xxx'
end

movie_id = '189037369'
api = TwicasStream::Comment::GetComments.new(movie_id)
comments = api.response[:comments]

p comments.first[:from_user][:name]
# => 'ツイキャス公式'
p comments.first[:from_user][:screen_id]
# => 'twitcasting_jp'
p comments.first[:message]
# => 'モイ！'
p comments.first[:created]
# => 1479579471
# (**) unix timestamp
```

For more usage, please refer to 'examples' directory.
There are some example source code in there, and help you to understand more.

## Support Request List

Current version supports following requests.

| Classification | Request                  | Support |
|:---------------|:-------------------------|:------------:|
| User           | Get User Info            | Support |
|                | Verify Credentials       | Support |
| Live Thumbnail | Get Live Thumbnail Image | Support |
| Movie          | Get Movie Info           | Support |
|                | Get Movies by User       | Not Support |
|                | Get Current Live         | Not Support |
| Comment        | Get Comments             | Support |
|                | Post Comment             | Not Support (*) |
|                | Delete Comment           | Not Support (*) |
| Supporter      | Get Supporting Status    | Support |
|                | Support User             | Not Support (*) |
|                | Unsupport User           | Not Support (*) |
|                | Supporting List          | Support |
|                | Supporter List           | Support |
| Category       | Get Categories           | Support |
| Search         | Search Users             | Support |
|                | Search Live Movies       | Support |

(*) 'POST/DELETE/PUT' HTTP method. Current version supports 'GET' method only.

## Response Data Structure

Response data of 'Get User Info' is as below.

```rb
{
	:supporter_count => 10,
	:supporting_count => 24,
	:user => {
		:id => "182224938",
		:screen_id => "twitcasting_jp",
		:name => "ツイキャス公式",
		:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
		:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
		:level => 24,
		:last_movie_id => "189037369",
		:is_live => false,
		:supporter_count => 0,
		:supporting_count => 0,
		:created => 0
	}
}
```

'Get Movie Info' is as below.

```rb
{
	:movie => {
		:id => "189037369",
		:user_id => "182224938",
		:title => "ライブ #189037369",
		:subtitle =>  "ライブ配信中！",
		:last_owner_comment =>  "もいもい",
		:category =>  "girls_jcjk_jp",
		:link => "http://twitcasting.tv/twitcasting_jp/movie/189037369",
		:is_live => false,
		:is_recorded => false,
		:comment_count => 2124,
		:large_thumbnail => "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1.jpg",
		:small_thumbnail => "http://202-230-12-92.twitcasting.tv/image3/image.twitcasting.tv/image55_1/39/7b/0b447b39-1-s.jpg",
		:country => "jp",
		:duration => 1186,
		:created => 1438500282,
		:is_collabo => false,
		:is_protected => false,
		:max_view_count => 1675,
		:current_view_count => 20848,
		:total_view_count => 20848,
		:hls_url => "http://twitcasting.tv/twitcasting_jp/metastream.m3u8/?video=1"
	},
	:broadcaster => {
		:id => "182224938",
		:screen_id => "twitcasting_jp",
		:name => "ツイキャス公式",
		:image => "http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
		:profile => "ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページ:ttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
		:level => 24,
		:last_movie_id => "189037369",
		:is_live => true,
		:supporter_count => 0,
		:supporting_count => 0,
		:created => 0
	},
	:tags => ["人気", "コンティニュー中", "レベル40+", "初見さん大歓迎", "まったり", "雑談"]
}
```

For others response data structure, please refer to [API Documentation (APIv2)](http://apiv2-doc.twitcasting.tv/).

---

## Development

Here is for developer

[![Build Status](https://travis-ci.org/ysato5654/twicas_stream.svg?branch=develop)](https://travis-ci.org/ysato5654/twicas_stream)
[![Coverage Status](https://coveralls.io/repos/github/ysato5654/twicas_stream/badge.svg?branch=develop)](https://coveralls.io/github/ysato5654/twicas_stream?branch=develop)

### Preparation before developing

Before develop twicas_stream, we need to prepare as below.
Because example srouce code and test code need access

1. Create '/config' directory
2. Create 'access_token.txt' in there
3. Write your access token in that file

### twicas_stream

```rb
module TwicasStream
	module TwicasApiObject
		class App
		end

		class User
		end

		class Movie
		end

		class Comment
		end

		class SupporterUser
		end

		class Category
		end

		class SubCategory
		end
	end

	module User
		class GetUserInfo
		end

		class VerifyCredentials
		end
	end

	module LiveThumbnail
		class GetLiveThumbnailImage
		end
	end

	module Movie
		class GetMovieInfo
		end

		class GetMoviesbyUser
		end

		class GetCurrentLive
		end
	end

	module Comment
		class GetComments
		end

		class PostComment
		end

		class DeleteComment
		end
	end

	module Supporter
		class GetSupportingStatus
		end

		class SupportUser
		end

		class UnsupportUser
		end

		class SupportingList
		end

		class SupporterList
		end
	end

	module Category
		class GetCategories
		end
	end

	module Search
		class SearchUsers
		end

		class SearchLiveMovies
		end
	end
end
```

### Twicas API Object

- App
- User
- Movie
- Comment
- SupporterUser
- Category
- SubCategory
- Error

### Directory Structure

```
/										  
├─	/bin								  
├─	/config								  
│	└─	access_token.txt				  
├─	/examples							  
│	├─	get_categories.rb				  
│	├─	get_comments.rb					  
│	├─	get_movie_info.rb				  
│	├─	get_user_info.rb				  
│	├─	search_live_movies.rb			  
│	├─	search_users.rb					  
│	└─	verify_credentials.rb			  
├─	/lib								  
│	├─	/twicas_stream					  
│	│	├─	/twicas_api_object			  
│	│	│	├─	app.rb					  
│	│	│	├─	user.rb					  
│	│	│	├─	movie.rb				  
│	│	│	├─	comment.rb				  
│	│	│	├─	supporter_user.rb		  
│	│	│	├─	category.rb				  
│	│	│	└─	sub_category.rb			  
│	│	├─	category.rb					  
│	│	├─	comment.rb					  
│	│	├─	live_thumbnail.rb			  
│	│	├─	movie.rb					  
│	│	├─	request_header.rb			  
│	│	├─	search.rb					  
│	│	├─	supporter.rb				  
│	│	├─	user.rb						  
│	│	└─	version.rb					  
│	└─	twicas_stream.rb				  
├─	/pkg								  
├─	/spec								  
│	├─	/twicas_stream					  
│	│	├─	category_spec.rb			  
│	│	├─	comment_spec.rb				  
│	│	├─	live_thumbnail_spec.rb		  
│	│	├─	movie_spec.rb				  
│	│	├─	search_spec.rb				  
│	│	├─	supporter_spec.rb			  
│	│	└─	user_spec.rb				  
│	└─	spec_helper.rb					  
│	└─	twicas_stream_spec.rb			  
├─	LICENSE								  
└─	README.md							  
```

