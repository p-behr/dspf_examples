# INDARA

These days there isn't much need for numbered indicators (IN01 - IN99) in our RPG programs.  Unfortunately, display files still use numbered indicators for all sorts of conditional logic (i.e. turning on/off certain display attributes) and RPG programs communicate with display files using indicators.  Fret not, however, because we can use the indicator data area (INDARA).  The INDARA is a special data structure of indicators that can be used to send indicators between the RPG program and the display file.  

In the DSPF you must use the INDARA keyword (it's a file-level keyword).
In the RPG you create a data structure of indicators (the name doesn't matter, but I always call it "dspf_inds").  
Then you add the INDDS keyword to the F-Spec for the display file and point it to the data structure:
`dcl-f  MYDSPF  workstn  indds(dspf_inds)`

