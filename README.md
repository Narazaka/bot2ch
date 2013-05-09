# Bot2ch

## Usage

    football = Bot2ch::Menu.get_board("football")
    thread = football.threads.first
    puts thread.title
    thread.posts.each do |post|
      puts post.plain
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
