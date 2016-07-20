class MusicImporter
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def files
    mp3s = Dir.entries(path)
    mp3s.slice(2, mp3s.size)
  end

  def import
    self.files.each do |file|
      Song.create_from_filename(file)
    end
  end
end
