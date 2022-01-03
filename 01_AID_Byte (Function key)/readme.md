#AID Byte

The AID Byte is a 1-character in the file information data structure.  It contains a hex value which tells you which button was pressed by the user in an interactive program (i.e. "F1" - "F24", "Enter", "Page-Up", etc.).

You must define a data structure (the name doesn't matter but I always call it "dspf_info").
Then you add the INFDS keyword to the F-Spec for the display file and point it to the data structure:
`dcl-f  MYDSPF  workstn  infds(dspf_info)`
