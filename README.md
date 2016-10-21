<!--
Creator: Matt Laguardia
Market: SF
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# React on Rails

*This lab is important because:*

React is a front-end library that we use to manipulate the DOM, but we are full-stack developers and should be able to serve up these files on a server.

### What are the objectives?

*After this workshop, developers will be able to:*

* Create and serve up React components from a rails server
* Make a full-stack React app

### Where we should be now?

*Before this workshop, developers should already be able to:*

* Write full-stack ruby-on-rails applications that render views: ERB / HAML
* Deeper Knowledge of build tools, and their importance
* Some ES6 and JSX code

# Introduction and Instructions:

In this lab we are going to be creating a React app that has a rails backend. What we will be doing with rails is setting our app to serve up API endpoints and have React manipulate data that is found on those endpoints.

# Setting Up a Basic Rails API:

This is something new to rails 5 where we are able to have our rails application only render JSON. We are not going to render any views like we usually do when we do a generate. This is awesome... JavaScript is awesome.

## How do we create a new rails app?

<details>
<summary>Solution</summary>
```rails new react_clock_blog```
</details>

### Now, lets create our Model. How do we do this in rails?

<details>
<summary>Solution</summary>
```rails g model Post title:string description:text

  rails db:migrate
```
</details>

### Lets add some data to our DB. How should we do this?

<details><summary>Solution</summary>
``` 10.times { Post.create!(title: "Blog Posting All Dayyy", description: "Lorem what... Lazy Lazy Lazy Lazy Cool we'll delete these laterzzz!") }

rails db:seed
```
</details>

### Now lets move onto our controllers

With us creating a JSON only view for rails we need to bring in some helper gems to convert / or parse code for us. This is similar to body-parser in express.

```
gem 'responders'
```

Lets add this to our gem file and bundle.


## New Concepts in Rails 5

Here we are going to edit our controllers to just send us JSON objects to the view.

In our application controller:
```ruby
class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
end
```

*Null_session is going to stop sending us a view and will just respond with JSON*

### Now lets create our API controllers

We are going to make a new directory in our controllers file and call it api with a couple of files in it.

In terminal we can use these commands:
```
mkdir app/controllers/api

touch app/controllers/api/base_controller.rb

touch app/controllers/api/posts_controller.rb
```

Now we need to tell our base controller that we are going send JSON to our front-end.

```ruby
class Api::BaseController < ApplicationController
  respond_to :json
end
```

*respond_to is from our gem*

Now we can build our crud actions in our items_controller

<details><summary>Solution Code</summary>
```ruby
class Api::PostsController < Api::BaseController
  def index
    respond_with Post.all
  end

  def create
    respond_with :api, Post.create(post_params)
  end

  def destroy
    respond_with Post.destroy(params[:id])
  end

  def update
    post = Post.find(params["id"])
    post.update_attributes(post_params)
    respond_with post, json: item
  end

  private

  def post params
    params.require(:post).permit(:id, :title, :description)
  end
end
```
</details>

And our routes are going to look a little different since we are going one directory deeper.

Check this code out:

```ruby
Rails.application.routes.draw do
  namespace :api do
    resources :posts, only: [:index, :create, :destroy, :update]
  end
end
```

Check out what you've made so far!
localhost:3000/api/posts.json

If you see JSON you're good to go!

### Now comes React

We'll first build a controller where React is going to live

```
rails g controller pages index
```


And we'll set this as our root route
```ruby
Rails.application.routes.draw do
  root 'pages#index'

```

Let's add our react gem!

```
gem 'react-rails'

bundle

rails g react:install
```

Take a moment and see where React installed to... Our front-end assets.

### Creating our first React component in rails

Lets make our view for React

and add to index view

```
<%= react_component 'Main' %>
```

In your components folder lets make our first JSX file in rails:
```
  touch app/assets/javascripts/components/_main.js.jsx
```

And lets make a Man component that returns Hello World (try to do this on your own) Hint we need to use React.createClass in rails.

<details><summary>Solution Code:</summary>
```js
const Main = React.createClass ({
  render () {
    return (
      <div>
        <h1>Hello, World!</h1>
      </div>
    )
  }
})
```
</details>

Lets spin up those severs and see if hello world has come through!

## And we are set up!
Now try to mess around with nyan cat and our components. I have a challenge below if you would like to try it...

### Challenge:

Try to get our posts in our database to show up with setting state and mounting our components.
