
def level_1

    Question.question_numbers = [0, 1, 2, 3, 4, 5]
    3.times do
        screen_clear
        q_index = rand(Question.question_numbers.length-1)
        Question.send("q#{Question.question_numbers[q_index]}")
        Question.question_numbers.delete_at(q_index)
        end_break
       end
    puts "Congrats on your new EXTREME job! You've had a pretty easy start. Why don't you hire some more artists?"
    puts "Enter an artist/band you'd like to hire."
    hire_act
    puts "Awesome. Take a quick second to recall all the information you've given out. Here comes your next round...enter anything when you're ready."   
    end_break
end

def level_2
    screen_clear
    Question.q9
    end_break
    
end
def level_3
    screen_clear
    Question.q6
end