**free

ctl-opt  option(*srcstmt: *nodebugio) actgrp('EXAMPLES');


dcl-f  EXINDDSPF   workstn
                   infds(dspf_info)
                   indds(dspf_inds);

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;

dcl-ds  dspf_inds;
  colors  char(3)  pos(1);
    red       ind  pos(1);
    white     ind  pos(2);
    blue      ind  pos(3);
end-ds;

/include EXFKEY


dou keyPressed = F3;

    exfmt R01;

    clear colors;

    select;
        when R1MSG = 'WHITE';
            white = *ON;
        when R1MSG = 'RED';
            red = *ON;
        when R1MSG = 'BLUE';
            blue = *ON;
    endsl;

enddo;

*inlr = *on;
return;

