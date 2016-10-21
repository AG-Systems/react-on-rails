const Main = React.createClass ({
  getInitialState() {
    return { posts: []}
  },

  componentDidMount() {
    $.getJSON('/api/posts.json', (response) => { this.setState({ posts: response }) })
  },

  render () {
    var posts = this.state.posts.map((post) => {
      return (
        <div>
          {post.title}
        </div>
      )
    })
    return (
      <div>
        <h1>Hello, World!</h1>
        {posts}
      </div>
    )
  }
})
