require "pry"
class DogQuestion
    @@question_numbers = []
    
    def self.question_numbers=(array)
        @@question_numbers = array
    end
        
    def self.question_numbers
        @@question_numbers
    end
    

    def self.q0
        date = random_date
        v1 = User.current.venues.all.sample
        puts "🗣 📞: Bark, bark bark. Bark bark blood oath bark bark bark. Bark?"
        artist = treat_input_as_artist
        a = check_artist_genre_is_right_for_venue(artist, v1)
        if a == 1 
            puts "🗣 📞: BARK BARK! BARK!🤬"
            subtract_points
        elsif a == 2 
            puts "🗣 📞: Bark! Bark bark bark!"
            add_points
            local_booking = create_booking(artist, v1, date)
        elsif a == 3 
            puts "🗣 📞: ...Bark bark, bark."
            subtract_points
        end
    end

    def self.q1 
        v1 = User.current.venues.all.sample
        
        puts "🗣 📞: Bark, bark bark. Bark bark bark bark?" 
        puts "Please input Y/N"
        user_response = gets.chomp.downcase
        until user_response == "y" || user_response == "n"
        invalid_response
        user_response = gets.chomp
        end

        if user_response.downcase == "y"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie  
                puts  " 🗣 📞:  Baaaaaaaark! Bark bark bark."
                add_points
            else
                puts  " 🗣 📞:  Ugh, bark bark."
                subtract_points
            end
        elsif user_response.downcase == "n"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie 
                puts  " 🗣 📞:  Bark... bark bark."
                subtract_points
            else
                puts  " 🗣 📞 :  Bark bark bark?"
                puts  " 🗣 📞:  🧐🤔"
            end
        end
    end




    def self.q2 
        v1 = User.current.venues.all.sample
        puts " 🗣 📞 : BARK! BARK BARK?"
        artist = treat_input_as_artist
        a = check_artist_genre_is_right_for_venue(artist, v1)
    
    
        if a == 1 
            puts " 🗣 📞 : BARK!?!? 🤬"
            subtract_points
        elsif a == 2 
            date = random_date

            puts " 🗣 📞 : BAAAAAAAARK! ~EXTREME!~"
            add_points
            create_booking(artist, v1, date)
        elsif a == 3 
            puts " 🗣 📞 : BARK. BARK BARK."
            subtract_points
        end
    end

end