# Bot2ch

## Usage

    football = Bot2ch::Menu.get_board("football")
    thread = football.threads.find{ |thread| thread.title =~ /nanika/ }
    puts thread.title
    thread.posts.each do |post|
      puts post.plain # or post.block
      if post.has_replies?
        post.replies.each do |reply|
          puts "\t#{reply.plain}"
        end
      end
    end

    Bot2ch.enable_downloader
    thread.images.each_with_index{ |image, idx| image.download("#{idx}.jpg") }

## Command

    bot2ch show http://hoge.2ch.net/test/read.cgi/fuga/8098092/
    bot2ch download http://hoge.2ch.net/test/read.cgi/fuga/8098092/ save_dir
    bot2ch download http://hoge.2ch.net/test/read.cgi/fuga/8098092/ --override
    bot2ch download http://hoge.2ch.net/test/read.cgi/fuga/8098092/ --wait 30
    bot2ch download http://hoge.2ch.net/test/read.cgi/fuga/8098092/ --thread 5

## Default options

~/.bot2ch

    wait: 3
    thread: 5
    override: false
    save_to: /path/to/save_dir

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
