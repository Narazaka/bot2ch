require 'fileutils'

require "faraday"
require "faraday_middleware"
require "faraday/response/sjis_to_utf8"

require "bot2ch/client"
require "bot2ch/menu"
require "bot2ch/board"
require "bot2ch/thread"
require "bot2ch/post"
require "bot2ch/thread"
require "bot2ch/version"

module Bot2ch
  module_function
  def enable_downloader
    require "bot2ch/downloader/downloader"
    require "bot2ch/downloader/normal_image_downloader"
    require "bot2ch/downloader/imepita_downloader"
  end
end
