
require 'pry'
class MusicLibraryController
  attr_reader :path, :music_importer

  def initialize(path = "./db/mp3s")
    @path = path
    @music_importer = MusicImporter.new(path)
    @music_importer.import
  end

  def music_files
    self.music_importer.files
  end

  def call
    prompt = gets.chomp.downcase

    case prompt
    when "list songs"
      music_files.each_with_index do |file, index|
        puts "#{index += 1}. #{file.gsub(".mp3","")}"
      end
    when "list artists"
      music_files.each do |file|
        puts "#{file.split(" - ")[0]}"
      end
    when "list genres"
      music_files.each do |file|
        puts "#{file.split(" - ")[2].gsub("mp3","")}"
      end
    when "play song"
      number = gets.chomp.to_i
      music_files.each_with_index do |file, idx|
        if (number == (idx += 1))
          puts "Playing #{file.gsub(".mp3","")}"
        end
      end
    when "list artist"
      artist = gets.chomp
      music_files.each do |file|
        if (file.split(" - ")[0] == artist)
          puts "#{file.gsub("mp3","")}"
        end
      end
    when "list genre"
      genre = gets.chomp
      music_files.each do |file|
        if (file.gsub(".mp3","").split(" - ")[2] == genre)
          puts "#{file.gsub(".mp3","")}"
        end
      end
    end
    call unless (prompt == "exit")
  end
end
