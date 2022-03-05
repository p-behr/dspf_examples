# INDARA

These days there isn't much need for numbered indicators (IN01 - IN99) in our RPG programs.  Unfortunately, display files still use numbered indicators for all sorts of conditional logic (i.e. turning on/off certain display attributes) and so our RPG programs must communicate with display files using indicators.  Fret not, however, because we can use the indicator data area (INDARA).  The INDARA is a special data structure of indicators, distinct from IN(*), that can be used to send indicator values between the RPG program and the display file.  

### Using the INDARA

* In the DSPF you must use the INDARA keyword (it's a file-level keyword)
    ```
        A                                      DSPSIZ(*DS3)
        A                                      INDARA
    ```
* In the RPG you create a data structure of indicators
    * The name of the data structure doesn't matter, but I always call it "dspf_inds"
    * Give the indicators meaningful names (depends on your application)
    ```
    dcl-ds  dspf_inds;
        red       ind  pos(1);
        white     ind  pos(2);
        blue      ind  pos(3);
    end-ds;    
    ```
* Add the INDDS keyword to the dispay file definition
    ```
    dcl-f  MYDSPF  workstn  indds(dspf_inds)
    ```

