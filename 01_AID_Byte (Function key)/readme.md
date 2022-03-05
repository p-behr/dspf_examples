# AID Byte

The AID Byte is a 1-character in the file information data structure.  It contains a hex value which tells you which button was pressed by the user in an interactive program (i.e. "F1" - "F24", "Enter", "Page-Up", etc.).  You can see the hex values for the function keys (F1-F24) in the example program (see EXFKEY.RPGLE in the remaining examples for a more complete list).  

### Using the AID byte

* Define a data structure with a 1-character field in position 369
    * The names doesn't matter but I always call them "dspf_info" and "keyPressed"  
    ```
    dcl-ds  dspf_info;
       keyPressed    char(1)  pos(369);
    end-ds;
    ```

* Add the INFDS keyword to the dispay file definition
    ```
    dcl-f  MYDSPF  workstn  infds(dspf_info)
    ```
