# Subfile
Subfiles are used to display lists of data to the user (much like a spreadsheet or a "Grid" in a web application).  The subfile is made up of two parts: the subfile (SFL) which contains the definition for each row, and the associated subfile control (SFLCTL) which defines the number of rows available, which rows to display, and which function keys are available among other things.

There are lots of special keywords that we're about to introduce.  Most of this is boilerplate code, though, so once you have a working subfile it's pretty easy to create another.


## Using a subfile

### The display file
* Add a subfile (a record format with the SFL keyword) to the DSPF.  The fields to be included in each subfile record are defined in this record format.  You only define the subfile record once even though there may be many subfile records displayed (each subfile record will use this same definition). A single subfile record can take up more than one row on the display.
    ```
     A          R SFL1                      SFL
     A            SFL_FIELD1    10A  O  5  4
     A            SFL_FIELD2    10A  O  6  4
    ```

* Add the subfile control record format, using the SFLCTL keyword to associate the subfile control with the subfile.
    ```
     A          R CTL1                      SFLCTL(SFL1)
    ```

* SFLSIZ and SFLPAG keywords  
These are used to define the size of the subfile.  There can be a maximum of 9999 subfile records.  The SFLSIZ is the size of the subfile (the number of records), and the SFLPAG is the number of subfile records to display on the screen at one time.  If the SFLSIZ is larger than the SFLPAG, the subfile size will grow automatically as you write records to it (this is the easy way to do it, but be sure not to go over the max size).  
    ```
     A          R CTL1                      SFLCTL(SFL1)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
    ```

* SFLDSP and SFLDSPCTL keywords  
These keywords control whether or not to display the subfile and/or subfile control when you write the subfile control.  You do not want to display the subfile if there are no subfile records, so you would want to turn off the SFLDSP. You do not want to display the subfile control when you are just trying to clear the subfile (and there may be other reason) so you would turn off the SFLDSPCTL

    ```
     A          R CTL1                      SFLCTL(SFL1)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A  01                                  SFLDSP
     A  02                                  SFLDSPCTL
    ```


* SFLCLR keyword  
The SFLCLR keyword is used to clear existing records from the subfile. If you WRITE the subfile control in your program with SFLCLR turned on, the subfile will be cleared.  This is typically done just prior to loading data into the subfile.  We don't want to clear the subfile when we display it, and don't want to display the subfile when we clear it, so we can use the same indicator for both functions. Remember the "N" before the conditioning indicator means "NOT", so if IN02 is on it will display and not clear, and if IN02 is off it will clear and not display

    ```
     A          R CTL1                      SFLCTL(SFL1)
     A                                      SFLSIZ(0011)
     A                                      SFLPAG(0010)
     A  01                                  SFLDSP
     A  02                                  SFLDSPCTL
     A N02                                  SFLCLR
    ```

* SFLEND keyword
This will let the user know if there are additional subfile pages available.  If this keyword is activated the system will add a small "+" symbol, or the text "More..." at the bottom of the subfile when there are additional pages (so that the user knows they can page down for the next page).  I usually use "N03" for this, and just never turn IN03 on (the default state for an indicator is *OFF).
    ```
    A          R CTL1                      SFLCTL(SFL1)
    A                                      SFLSIZ(0011)
    A                                      SFLPAG(0010)
    A  01                                  SFLDSP
    A  02                                  SFLDSPCTL
    A N02                                  SFLCLR
    A N03                                  SFLEND(*MORE)
    ```

* SFLRCDNBR keyword  
This is a hidden field that tells the subfile control to display a certain page.  You provide a numeric field (S1RCDNBR in this example) to use with this keyword.  You update that field to indicate which subfile record you want to display (you use the subfile record number, not the page number) and the subfile control will automatically display the page that contains that subfile record. 
    ```
    A          R CTL1                      SFLCTL(SFL1)
    A                                      SFLSIZ(0011)
    A                                      SFLPAG(0010)
    A  01                                  SFLDSP
    A  02                                  SFLDSPCTL
    A N02                                  SFLCLR
    A N03                                  SFLEND(*MORE)
    A            S1RCDNBR       4S 0H      SFLRCDNBR
    ```

* Your subfile control can contain other fields
    ```
    A          R CTL1                      SFLCTL(SFL1)
    A                                      SFLSIZ(0011)
    A                                      SFLPAG(0010)
    A  01                                  SFLDSP
    A  02                                  SFLDSPCTL
    A N02                                  SFLCLR
    A N03                                  SFLEND(*MORE)
    A            S1RCDNBR       4S 0H      SFLRCDNBR
    A            C1POSITION     4Y 0B  2 17EDTCDE(4)
    A                                      COLOR(YLW)
    ```

### The RPG program

* Define the subfile(s) on the display file definition  
You must identify each subfile by name in the file declaration, and associate the subfile with a numeric variable (this variable is used as the relative record number of the subfile records)
    ```
    dcl-f  EXSFLDSPF   workstn
                       sfile( sfl1 : rrn1 );
    dcl-s  rrn1   uns(5);
    ```

* Add the subfile control keywords to the indicator data structure
    ```
    dcl-ds  dspf_inds;
        S1_Dsp      ind  pos(1);
        S1_DspCtl   ind  pos(2);
        S1_End      ind  pos(3);
    end-ds;
    ```
* Clear existing records from the subfile  
We clear the subfile by turning off SFLDSP and SFLDSPCTL and then writing the subfile control record.
    ```
        s1_dsp = *off;
        s1_dspCtl = *off;
        write  CTL1;
        s1_dspCtl = *on;
        s1_dsp = *on;
    ```

* Load data into the subfile.  
Set the subfile fields, increment the relative record number, and then write the subfile  
    ```
        S1_TXTFLD = 'This is a subfile field';
        rrn1 += 1;
        write SFL;
    ```

* Indicate which page to display  
If you have the SFLRCDNBR in your subfile display, do not forget to set the value!  If you forget, and that value is zero, your display file will have an error.  In fact, if you are seeing "session or device error" messages this is one of the first thing you should check.
    ```
        S1RCDNBR = 1;
    ```

* Display the subfile  
You display the subfile by EXFMT the subfile control
    ```
        exfmt CTL1;
    ```
