require 'pry'
class Artist
  extend Concerns::Findable
  attr_accessor :name, :songs

  @@all = []

#========== INSTANCE METHODS =========#

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def add_song(name)
    @songs << name unless @songs.include?(name)
    name.artist = self unless name.artist == self
  end

  def genres
    songs.collect(&:genre).uniq
  end
#======== CLASS METHODS =========#

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    artist = Artist.new(name)
    artist.save
    artist
  end
end
