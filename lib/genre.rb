class Genre
  extend Concerns::Findable
  
  attr_accessor :name, :songs
  @@all = []

#========= INSTANCE METHODS ===========#

  def initialize(name)
    @name = name
    @songs = []
  end

  def save
    self.class.all << self
  end

  def artists
    songs.collect(&:artist).uniq
  end

#========= CLASS METHODS ============#

  def self.all
    @@all
  end

  def self.destroy_all
    self.all.clear
  end

  def self.create(name)
    genre = Genre.new(name)
    genre.save
    genre
  end
end
