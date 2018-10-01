Umbrellio forum
======
Dummy SaaS app built for tech interview.

[Demo on heroku](https://umbrellio-forum.herokuapp.com/api/posts)

Actions
------
#### GET /api/posts
List top 10 posts based on their average rating:

[https://umbrellio-forum.herokuapp.com/api/posts](https://umbrellio-forum.herokuapp.com/api/posts)

```
curl -H "Content-Type: application/json" -X GET https://umbrellio-forum.herokuapp.com/api/posts
```

#### POST /api/posts
Creates a new post. Also creates an author, if it doesn't exist already, and keeps track of ips. Requires ip passed as an argument: it doesn't gather them from `remote_request`.

```
curl -H "Content-Type: application/json" -X POST -d '{ "header": "Lorem", "content": "Ipsum", "ip": "8.8.8.8", "login": "me" }' https://umbrellio-forum.herokuapp.com/api/posts
```

#### POST /api/rate
Rates a post by id. Value can be between 1 and 5.

```
curl -H "Content-Type: application/json" -X POST -d '{"post_id": "3", "value": "3"}' https://umbrellio-forum.herokuapp.com/api/rate
```

#### GET /api/list_trolls
Lists all ip addresses which were used by several authors. With said authors logins.
```
curl -H "Content-Type: application/json" -X GET https://umbrellio-forum.herokuapp.com/api/users/list_trolls
```

Try locally
------
### Prerequisites
* Postgresql 9+
* Ruby 2.4.1
* Bundler

### Setup
```
git clone git@github.com:SteveRedka/umbrellio_forum.git
cd umbrellio_forum
bundle
rake db:setup
rails server
```
