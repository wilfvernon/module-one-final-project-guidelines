def dog_start_menu
    puts 'Type the number for what you want to do!'
    puts '*' * 25
    puts '1 - New Dog'
    puts '2 - Load Dog'
    puts '3 - Delete Dog'
    input = gets.chomp  
    until input == '1' || input == '2' || input == '3'
        puts 'Please enter 1, 2 or 3'
        input = gets.chomp
    end
    if input == '1'
        new_dog_game
    elsif input == '2'
        load_dog_game
    elsif input == '3'
        delete_dog_save
    end
end

def new_dog_game
    puts "Please enter your dog"
    user = gets.chomp
    while User.names.include?(user.downcase)
        puts 'Sorry, that dog is already taken, please enter another'
        user = gets.chomp
    end
    User.current = create_new_user(user.downcase)
end

def load_dog_game
    puts "Please enter your dog"
    user = gets.chomp
    unless User.names.include?(user.downcase)
        puts 'Sorry, that dog does not exist'
        start_menu
    else
        User.current = User.all.find_by name: user.downcase
        puts "Welcome back, #{User.current.formatted_name}"
    end
end

def delete_dog_save
    puts "Are you sure you want to delete your dog?"
    puts "Type 'y' or 'n'"
    input = gets.chomp
    until input == 'y' || input == 'n'
        puts "Invalid response"
        puts "Are you sure you want to delete your dog?"
        puts "Type 'y' or 'n'"
        input = gets.chomp
    end
    if input == 'y'
        puts "Please enter the name of the dog you would like to destroy"
        input2 = gets.chomp
        unless User.names.include?(input2.downcase)
            puts 'Sorry, that dog does not exist'
            start_menu
        else
            user = User.all.find_by name: input2.downcase
            User.destroy(user.id)
            puts "Dog has been deleted"
            start_menu
        end
    elsif input == 'n'
        start_menu
    end
end

def dog_welcome_message
    puts " "
    puts "Bark bark BARK BARK BARK, #{User.current.formatted_name}!" 
    sleep(1)
    puts " "
    puts "Bark bark bark bark bark bark bark bark bark bark bark bark bark bark bark...or die trying!"
    sleep(1)
    puts " "
    puts "Bark bark bark bark bark and bark bark bark bark, bark bark bark bark bark, bark bark bark bark bark bark bark bark bark bark."
    puts " "
    puts "Bark bark, bark bark bark bark bark bark bark bark bark bark bark bark bark bark, but be careful:"
    puts " "
    puts "Bark bark bark bark bark bark, GAME OVER!!!"
end

def dog_display_artists_information
    puts "Bark bark bark:"
    puts User.current.dog_artist_table
end
def dog_display_venue_information
    puts "Bark bark bark bark:"
    puts User.current.dog_venue_table
end
def dog_display_bookings_information
    puts "BARK BARK, BARK BARK:"
    puts User.current.dog_booking_table
end