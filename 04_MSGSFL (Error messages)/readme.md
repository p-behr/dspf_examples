# Message Subfile

Many display file programs use a simple output field for displaying messages to the user (most often used to show error messages).  While this method is incredibly simple, it forces your program to display one single error message at a time.  This usually means your program is only validating one field at a time, which forces the user to correct one field at a time (get error message, fix problem, press enter, get error message, fix next problem, press enter, get error message...).

A message subfile is a more sophisticated method of sending messages to the user.  It is more complicated than a simple output field, but it's not very difficult and allows your program to send multiple messages at the same time.  The user will only see 1 message line at a time, and you put the cursor on the message subfile and page-down/page-down to scroll through all the messages. 

While the message subfile is more complicated, once you have everything in place sending messages to the user is no harder than setting an error variable!


### Using message subfile

* Add the message subfile to the display file
    ```
      *===============================================================
      * MESSAGE SUBFILE
      *===============================================================
     A          R MSGSFL                    SFL
     A                                      SFLMSGRCD(23)
     A            MSGKEY                    SFLMSGKEY
     A            PS_PGMNAM                 SFLPGMQ
      *----------------------------------------------------------------
     A          R MSGSFLC                   SFLCTL(MSGSFL)
     A                                      SFLSIZ(0002)
     A                                      SFLPAG(0001)
     A                                      OVERLAY
     A                                      SFLDSP
     A                                      SFLDSPCTL
     A                                      SFLINZ
     A N98                                  SFLEND
     A            PS_PGMNAM                 SFLPGMQ

    ```

    * Decide which line you want the messages to show up on (usually 23 or 24).  That value goes in the SFLMSGRCD(xx) keyword.  I tend to use line 23 so that status messages can still be displayed on line 24.
    * The SFLPGMQ keywords (one in the subfile and one in the control) need to know the program name.  In this example we're using "PS_PGMNAM" from the Program Status Data Structure (PSDS) which we copy in from EXPSDS.RPGLE.

* Make sure that the other record formats in your DSPF use the OVERLAY keyword because they will be written on top of the message subfile
    ```
         A          R R01
         A                                      OVERLAY
    ```
    
* In your RPG program, include the PSDS (this is where we get the program name "PS_PGMNAM"). 
    ```
    /include EXPSDS
    ```
    * The program name, and many other things, are available in the PSDS
        ```
        dcl-ds PSDS PSDS;
            PS_PgmNam     *PROC;                // Module or main procedure name
            [...many other things here...]
        end-ds;
        ```
    * Check out the EXPSDS.RPGLE copybook to see what's available in the PSDS

* In your RPG program, include the procedures to send and remove program messages 
    ```
        // Copy the SendProgramMessage & ClearProgramMessages procedures
        /include EXMSGCPY
    ```
  
* To send a message to the user, you call the SendProgramMessage() procedure
    ```
        SendProgramMessage('This is a message');
    ```
    
* You can send multiple messages!
    ```
        SendProgramMessage('This is message #1');
        SendProgramMessage('This is message #2');
    ```
    * The example program sends multiple messages to the user, from the mainline and also from called procedures.


* In your RPG program, you WRITE the message subfile control before you EXFMT
    ```
        write MSGSFLC;
        exfmt R01;
    ```


* You should clear the message subfile after you EXFMT
    ```
        write MSGSFLC;
        exfmt R01;
        ClearProgramMessages();
    ```
  


