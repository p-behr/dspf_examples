**free

ctl-opt  option(*srcstmt: *nodebugio) actgrp('EXAMPLES');


dcl-f  EXAIDDSPF   workstn
                   infds(dspf_info);

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;
dcl-s  fkey     zoned(2);

dcl-ds  *n;
    F1   char(1)  inz(x'31');
    F2   char(1)  inz(x'32');
    F3   char(1)  inz(x'33');
    F4   char(1)  inz(x'34');
    F5   char(1)  inz(x'35');
    F6   char(1)  inz(x'36');
    F7   char(1)  inz(x'37');
    F8   char(1)  inz(x'38');
    F9   char(1)  inz(x'39');
    F10  char(1)  inz(x'3A');
    F11  char(1)  inz(x'3B');
    F12  char(1)  inz(x'3C');
    F13  char(1)  inz(x'B1');
    F14  char(1)  inz(x'B2');
    F15  char(1)  inz(x'B3');
    F16  char(1)  inz(x'B4');
    F17  char(1)  inz(x'B5');
    F18  char(1)  inz(x'B6');
    F19  char(1)  inz(x'B7');
    F20  char(1)  inz(x'B8');
    F21  char(1)  inz(x'B9');
    F22  char(1)  inz(x'BA');
    F23  char(1)  inz(x'BB');
    F24  char(1)  inz(x'BC');
    functionKeys  char(1)  dim(24)  pos(1);
end-ds;


dou R1MSG = 'EXIT';

    exfmt R01;

    if R1MSG = 'EXIT';
        leave;
    endif;

    fkey = %lookup(keyPressed : functionKeys);
    if fkey > 0;
        R1MSG = 'You pressed F' + %char(fkey);
    else;
        R1MSG = 'You pressed something other than F1 - F24';
    endif;

enddo;

*inlr = *on;
return;
