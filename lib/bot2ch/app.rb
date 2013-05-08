module Bot2ch
  class App
    def execute(subdir)
      root_dir = File.dirname(__FILE__)
      image_dir = "#{root_dir}/images"
      log_dir = "#{root_dir}/log"
      FileUtils.mkpath(image_dir) unless File.exists?(image_dir)
      FileUtils.mkpath(log_dir) unless File.exists?(log_dir)

      db = YAML::Store.new("#{log_dir}/thread.db")
      menu = Menu.new
      board = menu.get_board(subdir)
      threads = board.get_threads
      puts "total: #{threads.length} threads"
      threads.each do |thread|
        images = thread.get_images rescue next
        next if images.empty?
        parent_dir = "#{image_dir}/#{thread.dat_no}" 
        Dir.mkdir(parent_dir) unless File.exists?(parent_dir)
        puts "#{thread.title}: #{images.length} pics"
        downloaded = db.transaction { db[thread.dat_no] } || 0
        images.each_with_index do |image, index|
          next if index < downloaded
          image.download("#{parent_dir}/#{index}.jpg") rescue next
          sleep(0.2)
        end
        db.transaction { db[thread.dat_no] = images.length }
      end
    end
  end
end
