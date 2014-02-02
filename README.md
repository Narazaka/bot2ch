# Bot2ch
[![Build Status](https://travis-ci.org/Manbo-/bot2ch.png)](https://travis-ci.org/Manbo-/bot2ch)

## Install
    $ git clone https://github.com/Manbo-/bot2ch.git
    $ cd ./bot2ch
    $ rake install

Unless you've already installed faraday-response-encoder, you have to install it.

    $ git clone https://github.com/Manbo-/faraday-response-encoder.git
    $ cd ./faraday-response-encoder
    $ rake install

## Usage
### 2ch

    require "bot2ch"

#### Menu

Return array of Bot2ch::Board

    Bot2ch::Menu.boards
    Bot2ch::Menu.boards("サッカー")
    Bot2ch::Menu.boards(/ball/)

Return Bot2ch::Board

    Bot2ch::Menu.board("海外サッカー")
    Bot2ch::Menu.board(/football/)

##### Category
    Bot2ch::Menu.categories # => ["地震", "おすすめ", "特別企画", ...]
    Bot2ch::Menu.category("ニュース") # => [Bot2ch::Board, Bot2ch::Board, Bot2ch::Board, ...]

#### Board
    football = Bot2ch::Menu.board("海外サッカー")
    football.threads # => [Bot2ch::Thread, Bot2ch::Thread, Bot2ch::Thread, ...]

#### Thread
    thread.title # => "TITLE_BODY (POSTS_COUNT)"
    thread.title_body
    thread.posts_count
    thread.ikioi
    thread.posts #=> [Bot2ch::Post, Bot2ch::Post, Bot2ch::Post, ...]

#### Post
     [:name, :email, :date, :body, :index, :id, :thread].each do |name|
       post.send(name)
     end

     post.replies # => [Bot2ch::Post, Bot2ch::Post, Bot2ch::Post, ...]

##### #plain
    1 : 名無しさん(sage) : 日付 ID:abcdefg
    <br>を\n、その他のHTMLタグを削除した本文

##### #block
    1 : 名無しさん(sage) : 日付 ID:abcdefg
    DATそのままの本文

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
