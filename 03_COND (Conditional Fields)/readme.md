# Conditional Fields

You can use indicators to conditionally show or hide fields or constants in your display file (you should use the [indicator data area](../02_INDARA%20(Indicators)/readme.md), of course!).  

### Using conditional fields

* You should use the indicator data area in your display file
    ```
        A                                      DSPSIZ(*DS3)
        A                                      INDARA
    ```
* Define the indicator data structure in the RPG
    ```
    dcl-ds  dspf_inds;
        showFields    ind   pos(1);
    end-ds;    
    ```
* Put the indicator number in columns 9-10 to condition the field/constant.  The field will only display when that indicator is on
    * Adding an "N" to column 8 will cause the field to display if the indicator if off
    ```
     A  01                              5  3'Press F11 again to hide'
     A N01                             22 13'F11=Show'
     A  01                             22 13'F11=Hide'
    ```
