import socket, time
import sys
from colorama import Style, Fore


def __main__():

    host = input("[!] Re - Enter HOST : "+Fore.CYAN+Fore.RESET)
    port = input("[!] Re - Enter PORT : "+Fore.CYAN+Fore.RESET)
    msg = input("[!] Enter a Message to Send them : "+Fore.CYAN+Fore.RESET)

    

    conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        print("[+] Connecting...")
        conn.connect((host, int(port)))
        print("[+] Connected!")
        print("[+] Will Save Recived Data to File rcv.data")
        print("[+] Sending Message Spam. Press CTRL+C to exit and Break the Connection..")
        while True:
            try:
                data = conn.recv(99999)
                file = open("rcv.data", "wb")
                file.write(data)
                file.close()
                conn.send(msg.encode)
            except KeyboardInterrupt as e:
                print(Fore.YELLOW+"[+] Keyboard Interrupt Detected.")
                pass
            
        print("[+] Done! Returning back to Ruby in 5 Seconds.")
        time.sleep(5)
        print("[!] OK")

    except ConnectionError as e:
        print("[-] Error : "+Fore.RED, e)
    

if __name__ == '__main__':
    __main__()
