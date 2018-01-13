# twicas_stream

twicas_stream provides simple Ruby access to [TwitCasting](https://twitcasting.tv/) API.

## Installation
```rb
```

## Rreparation before using

Before using twicas_stream, we need to get access token in order to access TwitCasting API (APIv2).
Flow is as below.

1. Registration  
Create new application, getting access token need 'ClientID' and 'ClientSecret'.
2. Get Access Token  
TwitCasting API (APIv2) provides two types of authorization flow.
For more information, please refer to API Documentation (APIv2).

## Usage

### Verify Credentials

Verify access token and get user information

```rb
user = TwicasStream::User::VerifyCredentials.new
verify_credentials = user.response
# following data is brought from API Documentation (APIv2)
# => {
         "app":{
           "client_id": "182224938.d37f58350925d568e2db24719fe86f11c4d14e0461429e8b5da732fcb1917b6e",
           "name": "サンプルアプリケーション",
           "owner_user_id": "182224938"
         },
         "user":{
             "id":"182224938",
             "screen_id":"twitcasting_jp",
             "name":"ツイキャス公式",
             "image":"http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
             "profile":"ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
             "level":24,
             "last_movie_id":"189037369",
             "is_live":false,
             "supporter_count": 10,
             "supporting_count": 24,
             "created":1282620640
         }
     }
```

### Get Comments

Get comments of movie id which you set

```rb
movie_id = '189037369'
comment = TwicasStream::Comment::GetComments.new(movie_id)
comments = comment.response
# following data is brought from API Documentation (APIv2)
# => {
         "movie_id":"189037369",
         "all_count":2124,
         "comments":[
             {
                 "id":"7134775954",
                 "message":"モイ！",
                 "from_user":{
                     "id":"182224938",
                     "screen_id":"twitcasting_jp",
                     "name":"ツイキャス公式",
                     "image":"http://202-234-44-53.moi.st/image3s/pbs.twimg.com/profile_images/613625726512705536/GLlBoXcS_normal.png",
                     "profile":"ツイキャスの公式アカウントです。ツイキャスに関するお知らせなどを投稿します。なお、お問い合わせは https://t.co/4gCf7XVm7N までお願いします。公式Facebookページhttps://t.co/bxYVwpzTJB\n公式Instagram\nhttps://t.co/Bm2O2J2Kfs",
                     "level":24,
                     "last_movie_id":"189037369",
                     "is_live":false,
                     "supporter_count": 10,
                     "supporting_count": 24,
                     "created":1282620640
                 },
                 "created":1479579471
             },
           :
           :
         ]
     }
```

For more usage, please refer to 'examples' directory.
There are some example source code in there, and help you to understand more.

## Support Request List

Current version supports following requests.

| Classification | Method                   | Support |
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
| Search         | Search Users             | Not Support |
|                | Search Live Movies       | Not Support |

## References

- [Developer API](https://twitcasting.tv/indexapi.php)
- [API Documentation (APIv2)](http://apiv2-doc.twitcasting.tv/)

---

## for Developer

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
│	│	└─	test_category.rb			  
│	├─	/comment						  
│	│	└─	test_comment.rb				  
│	├─	/live_thumbnail					  
│	│	└─	test_live_thumbnail.rb		  
│	├─	/movie							  
│	│	└─	test_movie.rb				  
│	├─	/search							  
│	│	└─	test_search.rb				  
│	├─	/support						  
│	│	└─	test_support.rb				  
│	├─	/user							  
│	│	└─	test_user.rb				  
│	└─	test.rb							  
├─	/tmp								  
├─	LICENSE								  
└─	README.md							  
```

