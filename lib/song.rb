
require 'pry'

class Song
  attr_accessor :name
  attr_reader :artist, :genre

  @@all = []

  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if (artist)
    self.genre = genre if (genre)
  end

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    song = Song.new(name)
    song.save
    song
  end

  def self.find_by_name(name)
    self.all.find do |song|
      song.name == name
    end
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end

  def self.new_from_filename(filename)
    name = filename.gsub(".mp3","").split(" - ")
    song = Song.new(name[1])
    song.artist = Artist.find_or_create_by_name(name[0])
    song.genre = Genre.find_or_create_by_name(name[2])
    song
  end

  def self.create_from_filename(filename)
    name = filename.gsub(".mp3","").split(" - ")
    song = self.find_or_create_by_name(name[1])
    song.artist = Artist.find_or_create_by_name(name[0])
    song.genre = Genre.find_or_create_by_name(name[2])
    song
  end

  def save
    self.class.all << self
  end

  def artist=(name)
    @artist = name
    @artist.add_song(self) unless @artist.songs.include?(self)
  end

  def genre=(name)
    @genre = name
    name.songs << self unless name.songs.include?(self)
  end
end
