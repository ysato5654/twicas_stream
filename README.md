# twicas_stream

twicas_stream provides simple Ruby access to [TwitCasting](https://twitcasting.tv/) API.

## Installation
```rb
```

## Documentation / Help

- [Developer API](https://twitcasting.tv/indexapi.php)
- [API Documentation (APIv2)](http://apiv2-doc.twitcasting.tv/)

## Rreparation before using

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

movie_id = '189037369'
api = TwicasStream::Movie::GetMovieInfo.new(movie_id)
movie_info = api.response

p movie_info[:movie][:title]
# => 'ライブ #189037369'
p movie_info[:movie][:subtitle]
# => 'ライブ配信中！'
p movie_info[:movie][:current_view_count]
# => 20848
p movie_info[:movie][:total_view_count]
# => 20848
p movie_info[:tags]
# => ['人気', 'コンティニュー中', 'レベル40+', '初見さん大歓迎', 'まったり', '雑談']
```

### Get Comments

Get comments of movie id which you set

```rb
# (*) following data are just example

movie_id = '189037369'
api = TwicasStream::Comment::GetComments.new(movie_id)
comments = api.response

p comments[:comments].first[:from_user][:name]
# => 'ツイキャス公式'
p comments[:comments].first[:from_user][:screen_id]
# => 'twitcasting_jp'
p comments[:comments].first[:message]
# => 'モイ！'
p comments[:comments].first[:created]
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
| Live Thumbnail | Get Live Thumbnail Image | Not Support |
| Movie          | Get Movie Info           | Support |
|                | Get Movies by User       | Not Support |
|                | Get Current Live         | Not Support |
| Comment        | Get Comments             | Support |
|                | Post Comment             | Not Support |
|                | Delete Comment           | Not Support |
| Supporter      | Get Supporting Status    | Not Support |
|                | Support User             | Not Support |
|                | Unsupport User           | Not Support |
|                | Supporting List          | Not Support |
|                | Supporter List           | Not Support |
| Category       | Get Categories           | Support |
| Search         | Search Users             | Support |
|                | Search Live Movies       | Support |

---

## Appendix

Here is for developer of twicas_stream

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

### Directory Structure

```
/										  
├─	/config								  
│	└─	access_token.txt				  
├─	/examples							  
│	├─	get_categories.rb				  
│	├─	get_comments.rb					  
│	├─	get_movie_info.rb				  
│	├─	get_user_info.rb				  
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
│	│	├─	search.rb					  
│	│	├─	support.rb					  
│	│	├─	user.rb						  
│	│	└─	version.rb					  
│	└─	twicas_stream.rb				  
├─	/test								  
│	├─	/category						  
│	│	├─	test_category.rb			  
│	│	└─	test_get_categories.rb		  
│	├─	/comment						  
│	│	├─	test_comment.rb				  
│	│	└─	test_get_comments.rb		  
│	├─	/live_thumbnail					  
│	│	└─	test_live_thumbnail.rb		  
│	├─	/movie							  
│	│	├─	test_get_movie_info.rb		  
│	│	└─	test_movie.rb				  
│	├─	/search							  
│	│	├─	test_search.rb				  
│	│	├─	test_search_live_movies.rb	  
│	│	└─	test_search_users.rb		  
│	├─	/support						  
│	│	└─	test_support.rb				  
│	├─	/user							  
│	│	├─	test_get_user_info.rb		  
│	│	└─	test_user.rb				  
│	└─	test.rb							  
├─	/tmp								  
├─	LICENSE								  
└─	README.md							  
```

### Test

#### execution of all test

```rb
ruby Test.rb
```

#### execution of each test

```rb
ruby TestUser.rb
```

