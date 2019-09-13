def level_1
    Question.question_numbers = [0, 1, 2, 3, 4]
    3.times do
        screen_clear
        q_index = rand(Question.question_numbers.length-1)
        Question.send("q#{Question.question_numbers[q_index]}")
        Question.question_numbers.delete_at(q_index)
        end_break
       end
       screen_clear
    puts "Congrats on your new EXTREME job! You've had a pretty easy start. Why don't you hire some more artists?"
    puts "Enter an artist/band you'd like to hire."
    hire_act
    puts "Awesome. Take a quick second to recall all the information you've given out. Here comes your next round..."   
    end_break
end

def level_2
    Question.q2
    end_break
    Question.question_numbers = [5, 6, 7, 8]
    3.times do 
        screen_clear
        q_index = rand(Question.question_numbers.length-1)
        Question.send("q#{Question.question_numbers[q_index]}")
        Question.question_numbers.delete_at(q_index)
        end_break
       end
    puts "Ok bossman..hire some more artists. 🤑"
    hire_act
    puts "Here comes your next round..."
    end_break
    
end
def level_3
    Question.question_numbers = [9, 10, 11]
    3.times do screen_clear
        q_index = rand(Question.question_numbers.length-1)
        Question.send("q#{Question.question_numbers[q_index]}")
        Question.question_numbers.delete_at(q_index)
        end_break
       end
    end_message
end 