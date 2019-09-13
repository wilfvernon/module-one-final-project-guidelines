require 'colorize'
require 'colorized_string'
require 'text-table'

def output_money
    puts "                      ____________________________"
    puts "                     | Your bank account has $#{User.current.dollars} |"
    puts "---------------------------------------------------------------------------------"
end


def design_1
    design1 = <<-'EOF'
                        
    ______________  __________________ ________________  _____________
    ___  ____/__  |/ /___  __/___  __ \___  ____/___   |/  /___  ____/
    __  __/   __    / __  /   __  /_/ /__  __/   __  /|_/ / __  __/   
    _  /___   _    |  _  /    _  _, _/ _  /___   _  /  / /  _  /___   
    /_____/   /_/|_|  /_/     /_/ |_|  /_____/   /_/  /_/   /_____/   
                                                                    
    
                ________ _______ _____   __________     
                ___  __ )___    |___  | / /___  __ \    
                __  __  |__  /| |__   |/ / __  / / /    
                _  /_/ / _  ___ |_  /|  /  _  /_/ /     
                /_____/  /_/  |_|/_/ |_/   /_____/      
                                        
    
    ______  __________ _____   _________ ___________________________ 
    ___   |/  /___    |___  | / /___    |__  ____/___  ____/___  __ \
    __  /|_/ / __  /| |__   |/ / __  /| |_  / __  __  __/   __  /_/ /
    _  /  / /  _  ___ |_  /|  /  _  ___ |/ /_/ /  _  /___   _  _, _/ 
    /_/  /_/   /_/  |_|/_/ |_/   /_/  |_|\____/   /_____/   /_/ |_|  
                                            
EOF
puts design1.colorize(:cyan)
end

def intro
 pid = fork{ exec 'afplay', "media/welcome.wav" }
 pid = fork{ exec 'afplay', 'media/peaches_loop.wav' }
puts "Welcome to..."
design_1
end





def screen_clear
system "clear"
design_1
output_money
end