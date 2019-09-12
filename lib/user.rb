require 'text-table'
class User < ActiveRecord::Base
  
    has_many :bookings
    has_many :artists
    has_many :venues
    has_many :genres
    
    def self.current
        @@current
    end

    def self.current=(user)
        @@current = user
    end
    
    def artist_table
        user = self.reload
        table = Text::Table.new
        table.head = ["Artist", "Genre", "Band Members"]
        table.rows = [[user.artists[0].name, user.artists[0].genre, (user.artists[0].band_members[0..6].map{|member|member.name}).join(', ')]]
        i = 1
        (user.artists.size - 1).times do
            table.rows << [user.artists[i].name, user.artists[i].genre, (user.artists[i].band_members[0..6].map{|member|member.name}).join(', ')]
            i += 1
        end
        table.to_s
    end

    def venue_table
        user = self.reload
        table = Text::Table.new
        table.head = ["Venue", "Genres"]
        table.rows = [[user.venues[0].name, user.venues[0].genres.map{|genre| genre.name}.join(', ')]]
        i = 1
        (user.venues.size - 1).times do
            table.rows << [user.venues[i].name, user.venues[i].genres.map{|genre| genre.name}.join(', ')]
            i += 1
        end
        table.to_s
    end

    def booking_table
        user = self.reload
        table = Text::Table.new
        table.head = ["Artist", "Venue", "Date"]
        table.rows = [[user.bookings[0].artist.name, user.bookings[0].venue.name, user.bookings[0].date]]
        i = 1
        (user.bookings.size - 1).times do
            table.rows << [user.bookings[i].artist.name, user.bookings[i].venue.name, user.bookings[i].date]
            i += 1
        end
        table.to_s
    end

    def self.names
        self.all.pluck(:name)
    end
   

    def formatted_name
        self.name.downcase.split(/ |\_/).map(&:capitalize).join(" ")
    end
end