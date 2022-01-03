**free
/IF DEFINED(MSGCPY)
    /EOF
/ENDIF
/DEFINE MSGCPY

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
