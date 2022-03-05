**free

ctl-opt  option(*srcstmt: *nodebugio) dftactgrp(*no) actgrp('EXAMPLES');

dcl-f  EXSFLDSPF   workstn
                   extdesc('PBEHR/EXSFLDSPF') extfile(*extdesc)
                   infds(dspf_info)  indds(dspf_inds)
                   sfile( sfl1 : rrn1 );

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;

dcl-ds  dspf_inds;
    S1_Dsp      ind  pos(1);
    S1_DspCtl   ind  pos(2);
    S1_End      ind  pos(3);
end-ds;

dcl-s rrn1      int(10);

/include PBEHR/EXAMPLES,EXFKEY

LoadSubfile();
dou keyPressed = F3;

    clear C1POSITION;

    write KEY1;
    exfmt CTL1;

    select;

        when keyPressed = F3;
            leave;

        when keyPressed = F17;
            S1RCDNBR = 1;

        when keyPressed = F18;
            S1RCDNBR = RRN1;

        when C1POSITION > 0;
            S1RCDNBR = C1POSITION;

    endsl;

enddo;

*inlr = *on;
return;


//=========================================================
dcl-proc  LoadSubfile;

    s1_dsp = *off;
    s1_dspCtl = *off;
    write  CTL1;
    s1_dspCtl = *on;
    s1_dsp = *on;

    for rrn1 = 1 to 713;
        S1_ROWKEY = %char(rrn1);
        S1_DATFLD = %date + %days(rrn1);
        S1_NBRFLD = rrn1 + (rrn1 / 1000);
        S1_TXTFLD = 'This is row #' + %char(rrn1);
        write  SFL1;
    endfor;

    rrn1 -= 1;
    S1RCDNBR = 1;

end-proc  LoadSubfile;
