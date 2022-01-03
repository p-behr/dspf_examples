# Message Subfile

The message subfile is a way of communicating messages to the user (more sophisticated than just an output field).  
The hard part is that you need to send program messages in order to load the message subfile.  
Don't forget to WRITE the message subfile control before you EXFMT, and since your record format will be on top of the message subfile you want to use the OVERLAY keyword too.

The nice thing about the error subfile is that you can send multiple messages to the user at once.  You can only see 1 line at a time, and you put the cursor on the message subfile and page-down to view additional messages. 
