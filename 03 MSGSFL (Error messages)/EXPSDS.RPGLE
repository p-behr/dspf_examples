**free

/IF DEFINED(PSDS)
    /EOF
/ENDIF
/DEFINE PSDS

dcl-ds PSDS PSDS;
    PS_PgmNam     *PROC;                // Module or main procedure name
    PS_Status     *STATUS;              // Status code
    PS_SrcStmt    char(8)   pos(21);    // Source statement number
    PS_Parms      *PARMS;               // Number of parms passed to program
    PS_Except     char(7)   pos(40);    // Exception (Type + Number)
    PS_PgmLib     char(10)  pos(81);    // Program library
    PS_ExData     char(80)  pos(91);    // Exception data
    PS_FileNam    char(10)  pos(175);   // File name
    PS_FileSts    char(35)  pos(209);   // File status info
    PS_JobNam     char(10)  pos(244);   // Job name
    PS_JobUsr     char(10)  pos(254);   // Job user
    PS_JobNbr     zoned(6)  pos(264);   // Job number
    PS_JobDate    zoned(6)  pos(270);   // Job started date
    PS_CurUsr     char(10)  pos(358);   // Current user
    PS_JobId      char(16)  pos(380);   // Job ID (used by work management APIs)
    PS_SysNam     char(8)   pos(396);   // System name
end-ds;
