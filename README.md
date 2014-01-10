# Bot2ch
[![Build Status](https://travis-ci.org/Manbo-/bot2ch.png)](https://travis-ci.org/Manbo-/bot2ch)

## Install
    $ git clone https://github.com/Manbo-/bot2ch.git
    $ cd ./bot2ch
    $ rake install

## Usage
### 2ch

    football = Bot2ch::Menu.get_board("football")
    Bot2ch::Menu.response # => faraday response
    football.name # => "海外サッカー"
    thread = football.threads.find{ |thread| thread.title =~ /nanika/ }
    puts thread.title # title_body + posts_count
    puts thread.ikioi
    thread.posts.each do |post|
      puts post.plain # or post.block
      post.replies.each do |reply|
        puts "\t#{reply.plain}"
      end
    end

### したらば
    Bot2ch::Shitaraba::Board.new("http://jbbs.shitaraba.net/../..")

### ローカルファイル
    Bot2ch::Board.new("/path/to/file")
    Bot2ch::Thread.new("/path/to/file")

## See also
http://github.com/Manbo-/bot2ch-downloader

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
