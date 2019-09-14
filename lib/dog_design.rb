require 'colorize'
require 'colorized_string'
require 'text-table'

def dog_design
    dog_design = <<-EOF

                            ;\ 
                            |' \ 
         _                  ; : ; 
        / `-.              /: : |              CHILL
       |  ,-.`-.          ,': : | 
       \  :  `. `.       ,'-. : | 
        \ ;    ;  `-.__,'    `-.|     IT WORKS, JAMES                  BE COOL
         \ ;   ;  :::  ,::'`:.  `.      
          \ `-. :  `    :.    `.  \                     
           \   \    ,   ;   ,:    (\             BRAH
            \   :., :.    ,'o)): ` `-. 
           ,/,' ;' ,::"'`.`---'   `.  `-._                                    SUP
         ,/  :  ; '"      `;'          ,--`.        
        ;/   :; ;             ,:'     (   ,:)           PEACE
          ,.,:.    ; ,:.,  ,-._ `.     \""'/ 
          '::'     `:'`  ,'(  \`._____.-'"' 
             ;,   ;  `.  `. `._`-.  \\              THATS JUST LIKE, YOUR OPINION, MAN
             ;:.  ;:       `-._`-.\  \`. 
              '`:. :        |' `. `\  ) \ 
                 ` ;:       |    `--\__,' 
                   '`      ,' 
                        ,-'


EOF
puts dog_design.colorize(:cyan)
end

def dog_intro
    pid = fork{ exec 'afplay', 'media/dogsong.wav' }
   dog_design
end
   
   
   
   
   
def dog_screen_clear
    system "clear"
    dog_design
    output_money
end
   