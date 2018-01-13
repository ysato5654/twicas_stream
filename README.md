# twicas_stream

twicas_stream provides simple Ruby access to [TwitCasting](https://twitcasting.tv/) API.

## Rreparation before installation

1. Registration
2. Get Access Token

## Installation
```rb
```

## Usage

```rb
```

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

