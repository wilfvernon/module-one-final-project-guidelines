require "pry"
class Question
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
        puts "🗣 📞: Hey, it's #{v1.name}. Our #{v1.genres.map do |genre| genre.name end.join(" and ") } bands have taken a blood oath and can't perform on #{date}. Who have you got for us?"
        artist = treat_input_as_artist
        a = check_artist_genre_is_right_for_venue(artist, v1)
        if a == 1 
            puts "🗣 📞: I know for a fact you're not their manager!!! Go back to SoundCloud!🤬"
            subtract_points
        elsif a == 2 
            puts "🗣 📞: Wow. You are the best band manager. I'll book you in for #{date}! DON'T FORGET THE DATE! ~EXTREME!~"
            add_points
            local_booking = create_booking(artist, v1, date)
        elsif a == 3 
            puts "🗣 📞: They're not the right genre, doofus."
            subtract_points
        end
    end

    def self.q1 
        v1 = User.current.venues.all.sample
        
        puts "🗣 📞: Hey, it's #{v1.name}. The owner spent too much time on the internet and only allows us to play #{v1.genres.map do |genre| genre.name end.join(" and ") }. He says that only 'plebs' listen to anything else, whatever that means. For future reference, do you manage any of thse types of artists?" 
        puts "Please input Y/N"
        user_response = gets.chomp.downcase
        until user_response == "y" || user_response == "n"
        invalid_response
        user_response = gets.chomp.downcase
        end

        if user_response.downcase == "y"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie  
                puts  " 🗣 📞:  Sweeeeeet! I'll call you when I need to book a band. Here's your matching fee."
                add_points
            else
                puts  " 🗣 📞:  I asked around, you don't mananage any #{v1.genres.map do |genre| genre.name end.join(" or ") } artists. I'm spreading the word about your mediocoreness."
                subtract_points
            end
        elsif user_response.downcase == "n"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie 
                puts  " 🗣 📞:  I asked around, you do have them. Liar. I'm never booking from you, ever."
                subtract_points
            else
                puts  " 🗣 📞 :  Maybe you should consider getting them?"
                puts  " 🗣 📞:  🧐🤔"
            end
        end
    end




    def self.q2 
        v1 = User.current.venues.all.sample
        puts " 🗣 📞 : Hey, it's #{v1.name}. We're looking to build our reputation back up ever since our Vapor-Wave phase. We're gonna need to play some #{v1.genres.map do |genre| genre.name end.join(" or ") }. Who can you give us?"
        artist = treat_input_as_artist
        a = check_artist_genre_is_right_for_venue(artist, v1)
    
    
        if a == 1 
            puts " 🗣 📞 : You don't actually manage them, do you? 🤬"
            subtract_points
        elsif a == 2 
            date = random_date

            puts " 🗣 📞 : Wow. You are the best band manager. I'll book you in for #{date}! DON'T FORGET THE DATE! ~EXTREME!~"
            add_points
            create_booking(artist, v1, date)
        elsif a == 3 
            puts " 🗣 📞 : They're not the right genre, doofus."
            subtract_points
        end
    end

    def self.q3 
        v1 = User.current.venues.all.sample
        puts " 🗣 📞 : Hey, it's #{v1.name}. We mostly play #{v1.genres.map do |genre| genre.name end.join(" and ") }. Who have you got for us?"
        artist = treat_input_as_artist
        a = check_artist_genre_is_right_for_venue(artist, v1)
    
        if a == 1 
            puts " 🗣 📞 : You don't actually manage them, do you? 🤬"
            subtract_points
        elsif a == 2 
            date = random_date

            puts " 🗣 📞 : Wow. You are the best band manager. I'll book you in for #{date}! DON'T FORGET THE DATE! ~EXTREME!~"
            add_points
            create_booking(artist, v1, date)
        elsif a == 3 
            puts " 🗣 📞 : They're not the right genre, doofus."
            subtract_points
        end
    end

    def self.q4 
        v1 = User.current.venues.all.sample
        
        puts " 🗣 📞 : Hey, it's #{v1.name}. Our K-Pop shows didn't turn out a revenue. Seems like no one knows what good music is anymore. For future reference, do you have any #{v1.genres.map do |genre| genre.name end.join(" or ") } bands?"
        puts "Please enter Y/N"
        user_response = gets.chomp.downcase

        until user_response == "y" || user_response == "n"
            invalid_response
            user_response = gets.chomp.downcase
        end

        if user_response.downcase == "y"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie  
                puts " 🗣 📞 : Sweeeeeet. I'll save your number and call you when I need to book a band."
                add_points
            else
                puts " 🗣 📞 : I asked around, you don't have these genres"
                subtract_points
            end
        elsif user_response.downcase == "n"
            boolie = User.current.genres.include?(v1.genres[0])
            if boolie 
                puts " 🗣 📞 : I asked around, you do have them. Liar. I'm never booking from you, ever."
                subtract_points
            else
                puts " 🗣 📞 : Maybe you should consider getting them?"
                puts " 🗣 📞 : 🧐🤔"
            end
        end
    end


    def self.q5 ##Venue calls to ask about which artists have been booked##
        b1 = User.current.bookings.sample
        v1 = Venue.all.find_by id: b1.venue_id
            puts " 🗣 📞 : Hey, just calling from #{v1.name} again. Can you just remind me if we've booked any of your acts?"
            puts "Type 'y' or 'n'."
            answer = gets.chomp.downcase
            until answer == 'y' || answer == 'n'
                invalid_response
                answer = gets.chomp.downcase
            end

            if answer == 'y'
                puts " 🗣 📞 : Super. And which act was that?"
                artist = treat_input_as_artist
                a = check_artist_is_booked_at_venue(v1, artist)
                if a == 1
                    puts " 🗣 📞 : Wait, but you don't manage anyone called that..."
                    subtract_points(20.00)
                elsif a == 2
                    puts " 🗣 📞 : Ah yeah that's right. Thanks a bunch #{User.current.formatted_name}"
                    add_points(20.00)
                elsif a == 3
                    puts " 🗣 📞 : Umm.... nope we don't have them playing at all..."
                    puts " 🗣 📞 : Are you sure you have your head screwed on straight?"
                    subtract_points(20.00)
                end
            elsif answer == 'n'
                puts " 🗣 📞 : Is that supposed to be a joke?"
                    subtract_points(20.00)
                
            end
    end


    def self.q6 ##person calls to ask about which artists have been booked##
        b1 = User.current.bookings.sample
        v1 = Venue.all.find_by id: b1.venue_id
        puts " 🗣 📞 : Hi! I've got tickets for #{v1.name}, but I'm not sure who's playing... Could you tell me?"
        artist = treat_input_as_artist
        a = check_artist_is_booked_at_venue(v1, artist)
        if a == 1
            puts " 🗣 📞 : Who? I've never heard of them in my life..."
            subtract_points(20.00)
        elsif a == 2
            puts " 🗣 📞 : No way! #{artist.name}? That's amazing!!"
            add_points(20.00)
        elsif a == 3
            puts " 🗣 📞 : As if #{artist.name} are close to good enough to get booked at #{v1.name}!"
            puts " 🗣 📞 : Get a clue!"
            subtract_points(20.00)
        end
    end

    def self.q7 ##person calls to ask about which artists have been booked##
        b1 = User.current.bookings.sample
        v1 = Venue.all.find_by id: b1.venue_id
        puts " 🗣 📞 : Yo. I found a ticket for #{v1.name}. Is it worth my time or should I just sell it? Who's playing?"
        artist = treat_input_as_artist
        a = check_artist_is_booked_at_venue(v1, artist)
        if a == 1
            puts " 🗣 📞 : I'm just going to sell it."
            subtract_points(20.00)
        elsif a == 2
            puts " 🗣 📞 : Lit! #{artist.name} is swagtastic!!"
            add_points(20.00)
        elsif a == 3
            puts " 🗣 📞 : Pffft. #{artist.name}? At #{v1.name}? Now I know why this was on the ground 🤣"
            subtract_points(20.00)
        end
    end

     
    def self.q8
        b1 = User.current.bookings.sample
        v1 = Venue.all.find_by id: b1.venue_id
        puts " 🗣 📞 : Hey, its #{v1.name}. We have #{b1.artist.name} booked but we can't remember when. Can you remind us?"
        puts "Please enter in 'day, month, date' format (only 3 letters for the day)"
        puts "For example, your input could be 'Thu Oct 25'"
        input = gets.chomp.downcase
        format_user_date(input)
        if input == b1.date.downcase
            puts " 🗣 📞 : Wow, I can't believe you knew that off the top of your head. You're the most EXTREME, RADICAL band manager ever."
            add_points
        else
            puts " 🗣 📞 : Maybe you should consider a different career path. Or none at all. Have you considered finsihing the third grade?"
            subtract_points
        end
    end

    def self.q9
        b = User.current.artists.sample
        bm = b.band_members.map {|member| member.name.downcase}
        puts " 🗣 📞 : Yo, #{User.current.name}, its #{b.name} calling. I know you're just in this for the money. If you're not, prove to me you really know us. Enter the full name of someone in this group."
        input = gets.chomp
        if bm.include?(input.downcase)
            puts " 🗣 📞 : Wow... You're getting a raise!"
            add_points
        else
            puts " 🗣 📞 : You're done in this town."
            subtract_points(50.00)
        end

    end

    def self.q10
        b = User.current.bookings.sample
        a = b.artist
        v = b.venue
        bm = a.band_members.sample
        puts " 🗣 📞 : Hey boss, its #{bm.name}. I don't know why I've been out of the loop, but I haven't heard about any of the gigs we're playing."
        puts "Can you tell me at least one venue we're playing at?"
        input = gets.chomp
        if input.downcase == v.name.downcase
            puts "#{v.name}, huh? Good job boss."
            add_points
        else 
            puts "Who on earth has heard of #{input}?"
            puts "You're on thin ice, #{User.current.name}"
            subtract_points(30.00)
        end
    end
    
    def self.q11
        b1 = User.current.bookings.sample
        v1 = Venue.all.find_by id: b1.venue_id
        puts " 🗣 📞 : Hi. My daughter and her friends want to go see #{b1.artist.name}. Where are they booked?"
        input = gets.chomp
        if input.downcase == v1.name.downcase
            puts "Great! What date would that be?"
            input = gets.chomp.downcase
            format_user_date(input)
            if input == b1.date.downcase
                puts " 🗣 📞 : You're the best, thanks."
                add_points
            else
                puts "* a few days later * 🗣 📞 : The date was wrong. We showed up to the venue and instead of #{b1.artist.name}, it was Lil Pump. I hope you can live with yourself."
            end
        else
            puts "* a few days later * 🗣 📞 : We showed up to the venue and instead of #{b1.artist.name}, it was Lil Pump. I hope you can live with yourself. "
            subtract_points(35)
        end
    end

end #END OF CLASS


