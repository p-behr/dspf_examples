**free

ctl-opt  option(*srcstmt: *nodebugio) actgrp('EXAMPLES');

dcl-f  EXCNDDSPF   workstn
                   infds(dspf_info)
                   indds(dspf_inds);

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;
dcl-ds  dspf_inds;
  showFields    ind   pos(1);
end-ds;

dcl-c  F3            x'33';
dcl-c  F11           x'3B';

dou keyPressed = F3;

    exfmt R01;

    if keyPressed = F11;
        showFields = not showFields;
    endif;

enddo;

*inlr = *on;
return;
