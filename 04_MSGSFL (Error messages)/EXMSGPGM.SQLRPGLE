**free

ctl-opt  option(*srcstmt: *nodebugio) dftactgrp(*no) actgrp('EXAMPLES');

dcl-f  EXMSGDSPF   workstn
                   infds(dspf_info)  indds(dspf_inds);

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;

dcl-ds  dspf_inds;
    R01_Errors     char(1)    pos(50);
       R1Msg_ERR       ind    pos(50);
end-ds;

/include EXFKEY
/include EXPSDS


SendProgramMessage('Program started...');

dou keyPressed = F3;

    clear R1MSG;

    write MSGSFLC;
    exfmt R01;

    ClearProgramMessages();
    clear R01_Errors;


    if keyPressed = Enter;
        if R1Msg = *blanks;
            SendProgramMessage('Message is required');
            R1Msg_ERR = *on;
        else;
            SendProgramMessage('In main: ' + %trim(R1Msg));
            Process(R1Msg);
        endif;
    endif;

enddo;

*inlr = *on;
return;


 dcl-proc  Process;
     dcl-pi  *n;
         in_message   char(50)  const;
     end-pi;

     SendProgramMessage('In Process(): ' + %trim(in_message));
     Process2(in_message);

     return;
 end-proc;


 dcl-proc  Process2;
     dcl-pi  *n;
         in_message   char(50)  const;
     end-pi;

     SendProgramMessage('In Process2(): ' + %trim(in_message));

     return;
 end-proc;


 // Copy the SendProgramMessage & ClearProgramMessages procedures
 /include EXMSGCPY

