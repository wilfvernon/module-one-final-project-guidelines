def dog_game
    dog_intro
    sleep(5)
    dog_start_menu
    unless User.current.artists.size > 0
        dog_welcome_message
        seed_data
        dog_screen_clear
        dog_display_artists_information
        dog_display_venue_information
        end_break
    end

    dog_screen_clear
    DogQuestion.q0
    end_break
    dog_screen_clear
    DogQuestion.q1
    end_break
    dog_screen_clear
    DogQuestion.q2
    end_break
    dog_screen_clear
    puts "THANK YOU FOR PLAYING DOG GAME!"
    end_break
    abort
end
