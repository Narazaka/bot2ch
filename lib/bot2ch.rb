require 'open-uri'

require "bot2ch/version"
require "bot2ch/menu"
require "bot2ch/board"
require "bot2ch/thread"
require "bot2ch/post"
require "bot2ch/thread"

module Bot2ch
  module_function
  def enable_downloader
    require "bot2ch/downloader/downloader"
    require "bot2ch/downloader/normal_image_downloader"
    require "bot2ch/downloader/imepita_downloader"
  end
end
