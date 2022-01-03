**free

ctl-opt  option(*srcstmt: *nodebugio) dftactgrp(*no) actgrp('PBTEST');

dcl-f  EXMSGDSPF   workstn
                   infds(dspf_info)  indds(dspf_inds);

dcl-ds  dspf_info;
  keyPressed    char(1)  pos(369);
end-ds;

dcl-ds  dspf_inds;
    R01_Errors     char(1)    pos(50);
       R1Msg_ERR       ind    pos(50);
end-ds;

/include *LIBL/EXAMPLES,EXFKEY
/include *LIBL/EXAMPLES,EXPSDS


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


 //========================================================================
 dcl-proc  SendProgramMessage;
     dcl-pi  *n;
         in_message  varchar(80) const;
     end-pi;

     dcl-pr  SendMessage  extpgm('QMHSNDPM');
         msgId            char(7)  const;
         msgFile          char(20) const;
         msgData          char(80) const;
         msgLength        int(10)  const;
         msgType          char(10) const;
         stackEntry       char(10) const;
         stackCounter     int(10)  const;
         msgKey           char(4);
         errorDs          likeds(errorDs);
     end-pr;

     dcl-ds  errorDs;
         bytesProvided    int(10) inz(16);
         bytesAvailable   int(10);
         exceptionId      char(7);
     end-ds;
     dcl-s msgKey   char(4);

     SendMessage( 'CPF9898'
                : 'QCPFMSG   QSYS'
                : in_message
                : %len(in_message)
                : '*INFO'
                : PS_PgmNam
                : 0
                : msgKey
                : errorDS
                );

 end-proc  SendProgramMessage;


 //========================================================================
 dcl-proc  ClearProgramMessages;

     dcl-pr  RemoveMessage  extpgm('QMHRMVPM');
         stackEntry       char(10) const;
         stackCount       int(10)  const;
         msgKey           char(4)  const;
         toRemove         char(10) const;
         errorDs          likeds(errorDs);
     end-pr;

     dcl-ds  errorDs;
         bytesProvided    int(10) inz(16);
         bytesAvailable   int(10);
         exceptionId      char(7);
     end-ds;
     dcl-s msgKey   char(4);

     RemoveMessage( '*'
                  : 1
                  : ' '
                  : '*ALL'
                  : errorDS
                  );

 end-proc  ClearProgramMessages;
