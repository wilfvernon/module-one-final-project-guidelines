require_relative '../config/environment'
require 'rest_client'
require "pry"
require "text-table"
### API Methods ###
def get_artist_name(artist, id)
    name = artist
    response = RestClient.get "https://api.discogs.com/artists/#{id}"
    results_hash = JSON.parse(response)
    if results_hash['name']
        name = results_hash['name']
    end
    name
 end     

def format_artist_name_for_html(name)
    name.tr(' ', '+')
end
3
def get_discogs_id(artist)
    i = 0
    formatted_name = format_artist_name_for_html(artist)
    response = RestClient.get "https://api.discogs.com/database/search?q=#{formatted_name}&key=RQiVIFhlSQUaqhURPhaW&secret=VHJtTwzPjtlEZUmGvUvdoAHlLaBzsqQv"
    results_hash = JSON.parse(response)
    if results_hash["results"] == []
        nil
    else
        until results_hash["results"][i]["type"] == 'artist'
          i += 1
        end
        results_hash["results"][i]["id"]
    end
end
def get_genre(artist, id)
    response = RestClient.get "https://api.discogs.com/artists/#{id}/releases"
    results_hash = JSON.parse(response)
    response2 = RestClient.get results_hash['releases'][0]['resource_url']
    results_hash2 = JSON.parse(response2)
    genre = results_hash2["genres"][0]
    genre
end
def get_band_members(artist, id)
    return_array = []
    response = RestClient.get "https://api.discogs.com/artists/#{id}"
    results_hash = JSON.parse(response)
    if results_hash['members']
        active_array = results_hash['members'].select{|member|member["active"] == true}
        member_array = active_array.map{|member|member["name"]}
        member_array.map!{|member|member.tr('()0-9', '').strip}
        member_array.map{|member|member.split(/ |\_/).map(&:capitalize).join(" ")}
    elsif results_hash['realname']
        name = results_hash['realname']
        return_array << name.split(/ |\_/).map(&:capitalize).join(" ")
    elsif results_hash['aliases']
        name = results_hash['aliases'][0]['name']
        return_array << name.split(/ |\_/).map(&:capitalize).join(" ")
    else 
        name = artist.split(/ |\_/).map(&:capitalize).join(" ")
        return_array << name
    end 
end
###start up###
def create_new_user(name)
    user = User.create(name: name, dollars: 50.00)
end
def new_game
    puts "Please enter your name"
    user = gets.chomp
    while User.names.include?(user.downcase)
        puts 'Sorry, that name is already taken, please enter another'
        user = gets.chomp
    end
    User.current = create_new_user(user.downcase)
end
def start_menu
    puts 'Type the number for what you want to do!'
    puts '*' * 25
    puts '1 - New Game'
    puts '2 - Load Save File'
    puts '3 - Delete Save File'
    input = gets.chomp  
    until input == '1' || input == '2' || input == '3'
        puts 'Please enter 1, 2 or 3'
        input = gets.chomp
    end
    if input == '1'
        new_game
    elsif input == '2'
        load_game
    elsif input == '3'
        delete_save
    end
end
def load_game
    puts "Please enter your name"
    user = gets.chomp
    unless User.names.include?(user.downcase)
        puts 'Sorry, that save file does not exist'
        start_menu
    else
        User.current = User.all.find_by name: user.downcase
        puts "Welcome back, #{User.current.formatted_name}"
    end
end
def delete_save
    puts "Are you sure you want to delete your save file?"
    puts "Type 'y' or 'n'"
    input = gets.chomp
    until input == 'y' || input == 'n'
        puts "Invalid response"
        puts "Are you sure you want to delete your save file?"
        puts "Type 'y' or 'n'"
        input = gets.chomp
    end
    if input == 'y'
        puts "Please enter the name of the file you would like to destroy"
        input2 = gets.chomp
        unless User.names.include?(input2.downcase)
            puts 'Sorry, that save file does not exist'
            start_menu
        else
            user = User.all.find_by name: input2.downcase
            User.destroy(user.id)
            puts "#{user.name.split(/ |\_/).map(&:capitalize).join(" ")}'s save file has been deleted"
            start_menu
        end
    elsif input == 'n'
        start_menu
    end
end
### Populate Data ###
def hire_act
    act = gets.chomp
    artists_names = User.current.artists.map{|artist|artist.name}
    while artists_names.include?(act.split(/ |\_/).map(&:capitalize).join(" "))
        puts 'You are already managing that act. Please input another one'
        act = gets.chomp
    end

    act_id = get_discogs_id(act)
    puts 'Searching for Artist...'
    while act_id == nil
        puts 'Artist could not be found. Please check your spelling.'
        act = gets.chomp
        act_id = get_discogs_id(act)
    end
    puts 'Artist found. Getting Data...'
    act_genre = get_genre(act, act_id)
    new_artist = Artist.create(name: act.split(/ |\_/).map(&:capitalize).join(" "), genre: act_genre, user_id: User.current.id)
    Genre.create(name: act_genre, user_id: User.current.id)
    add_band_members(new_artist, act_id)
    User.current.save
    new_artist
end
def add_band_members(artist, id)
    band_members = get_band_members(artist.name, id)
    band_members.each do |member|
        BandMember.create(name: member, artist_id: artist.id)
    end
end
def new_venue_name_checker
    name = VenueName.names.sample
    if User.current.venues.any?{|venue| venue.name == name} == true
        while User.current.venues.any?{|venue| venue.name == name} == true
            name = VenueName.names.sample
        end
    end
    name
end
def generate_venue
    venue_name = new_venue_name_checker
    new_venue = Venue.create(name: venue_name, user_id: User.current.id)
    add_genre_to_venue(new_venue)
    new_venue
end
def add_genre_to_venue(venue)
    genre = User.current.genres.last
    genre.venue_id = venue.id
    genre.save
end
def create_booking(artist, venue, date=random_date)
    Booking.create(artist_id: artist.id, venue_id: venue.id, date: date, user_id: User.current.id)
end
## Initialize ##
         
def seed_data   
    puts "Input a band/artist you'd like to manage."
    hire_act
    generate_venue
    puts "Input another band/artist you'd like to manage."
    hire_act
    generate_venue
    puts "Input another band/artist you'd like to manage."
    hire_act
    generate_venue
end
def welcome_message
    puts " "
    puts "Welcome to EXTREME BAND MANAGER, #{User.current.formatted_name}!" 
    sleep(1)
    puts " "
    puts "Your task is to get rich by managing as many bands as you possibly can...or die trying!"
    sleep(1)
    puts " "
    puts "Remember who's in your bands and what their genres are, which venues like which genres, and who gets booked at each venue for each night."
    puts " "
    puts "Between rounds, you'll have the chance to spend your money to look at a cheat sheet, but be careful:"
    puts " "
    puts "If you run out of money, its GAME OVER!!!"
end
### Tables ###
def display_artists_information
    puts "Here are all of your artists:"
    puts User.current.artist_table
end
def display_venue_information
    puts "Here are all the venues in town:"
    puts User.current.venue_table
end
def display_bookings_information
    puts "Here are all of your artists' bookings:"
    puts User.current.booking_table
end
## User inputs artist ##
def treat_input_as_artist
    puts "Please enter an artist"
    input = gets.chomp.downcase.split(/ |\_/).map(&:capitalize).join(" ")
    Artist.find_by name: input, user_id: User.current.id
end
def check_artist_genre_is_right_for_venue(artist, venue)
    if artist == nil
        1 ##User has no artists with the same name as input##
    else
        genre_names = venue.genres.map{|genre|genre.name}
        if genre_names.include?(artist.genre)
            2 ##Correct Answer##
        else 
            3 ##Artist does not have correct genre##
        end
    end
end
def fire_act(artist)
    Artist.destroy(input.id)
end
def check_band_member_is_in_band(artist, band_member)
    if artist == nil
        1 ##User has no artists with the same name as input##
    else
        if artist.band_members.include?(band_member)
            2 ##Correct Answer##
        else
            3 ##Artist does not have this band member##
        end
    end
end
def check_artist_is_right_for_date(artist, venue, date)
    if artist == nil
        1 ##User has no artists with the same name as input##
    else
        bookings_on_date = artist.bookings.select{|booking|booking.date == date}
        if bookings_on_date.length > 0
            if bookings_on_date.map{|booking|booking.venue_id}.include?(venue.id)
                2 ##Correct Answer##
            else
                3 ##venue is not booked for artist on that date##
            end
        else
            4 ##artist has no bookings at that date##
        end
    end
end
def check_artist_is_booked_at_venue(venue, artist)
    if artist == nil
        1 ##User has no artists with the same name as input##
    else
        if artist.bookings.any?{|booking|booking.venue_id == venue.id}
            2 ## Correct Answer ##
         else
            3 ##Artist has no bookings at venue##
        end
    end
end
##User inputs venue##
def treat_input_as_venue
    input = gets.chomp.downcase.split(/ |\_/).map(&:capitalize).join(" ")
    Venue.find_by name: input, user_id: User.current.id
end
def check_artist_is_booked_at_venue(venue, artist)
    if venue == nil
        1 ##User has no artists with the same name as input##
    else
        if artist.bookings.any?{|booking|booking.venue_id == venue.id}
            2 ## Correct Answer ##
         else
            3 ##Artist has no bookings at venue##
        end
    end
end
def check_venue_is_right_for_date(venue, artist, date)
    if venue == nil
        1 ##Save file has no venues with the same name as input##
    else
        bookings_on_date = venue.bookings.select{|booking|booking.date == date}
        if bookings_on_date.length > 0
            if bookings_on_date.map{|booking|booking.artist_id}.include?(artist.id)
                2 ##Correct Answer##
            else
                3 ##Artist is not booked at venue on that date##
            end
        else
            4 ##Venue has no bookings at that date##
        end
    end
end
## Misc ##
def random_date
    (Date.today+rand(25)).asctime[0..9]
end
    puts "HELLO WORLD"
#################
def break_menu
    puts 'Type the number for what you want to do!'
    puts '*' * 25
    puts '1 - Spend money to see your info'
    puts '2 - Continue'
    puts '3 - Save and Quit'
    input = gets.chomp
    until input == '1' || input == '2' || input == '3'
        puts 'Please enter 1, 2 or 3'
        input = gets.chomp
    end
    if input == '1'
        1
    elsif input == '2'
        2
    elsif input == '3'
        pid = fork{ exec 'killall', 'afplay' }
        abort
    end
end

def end_break
    puts "Input anything to continue..."
        gets.chomp
end

def shop_menu
    puts 'Type the number for what you want to do!'
    puts '*' * 25
    puts '1 - See all venues - $20.00'
    puts '2 - See your artists - $30.00'
    puts '3 - See your bookings - $35.00'
    puts '4 - Back'
    input = gets.chomp
    until input == '1' || input == '2' || input == '3' || input == '4'
        puts 'Please enter 1, 2, 3 or 4'
        input = gets.chomp
    end
    if input == '1'
        display_venue_information
        subtract_points(20.00)
        end_break
        screen_clear
    elsif input == '2'
        display_artists_information
        subtract_points(num=30.00)
        end_break
        screen_clear
    elsif input == '3'
        display_bookings_information
        subtract_points(35.00)
        end_break
        screen_clear
    end
end
def add_points(num=10.00)
    User.current.dollars += num
    User.current.save
    puts "**********"
    puts "+ $#{num}"
    puts "**********" 
    puts "You now have $#{User.current.dollars}"
end
def subtract_points(num=10.00)
    User.current.dollars -= num
    User.current.save
    puts "**********"
    puts "- $#{num}"
    puts "**********" 
    puts "You now have $#{User.current.dollars}"
    if User.current.dollars <= 0
        sleep(3)
        screen_clear
        puts "You have run out of money. Maybe you should think about a new career."
        puts "GAME OVER!!!"
        pid = fork{ exec 'killall', "afplay" }
        abort
    end
end
def invalid_response
    puts "*****INVALID RESPONSE*****"
    puts "Please enter Y/N"
    puts "*****INVALID RESPONSE*****"
end
#####################
def break_time
    var = 0
    until var == 2
        var = break_menu
        if var == 1
            screen_clear
            shop_menu
        end
    end
    screen_clear
end


def format_user_date(input)
    if input.length < 10
        user_date[7] = "  "
    end
end