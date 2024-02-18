; -------------------------------------------------------------------------------------------
; (c) 2024 by Jens Kallup <kallup-dev@web.de>
; all rights reserved.
; -------------------------------------------------------------------------------------------

    global fpc_initializeunits
    global fpc_libinitializeunits
    
    global FINALIZE$_$OBJPAS
    
    global FPC_DONEEXCEPTION
    global FPC_EMPTYMETHOD
    
    global INIT$_$FPINTRES
    global INIT$_$SYSTEM
    
    global SYSTEM$_$TOBJECT_$__$$_CREATE$$TOBJECT
    global SYSTEM$_$TOBJECT_$__$$_DISPATCH$formal
    global SYSTEM$_$TOBJECT_$__$$_DISPATCHSTR$formal
    global SYSTEM$_$TOBJECT_$__$$_EQUALS$TOBJECT$$BOOLEAN
    global SYSTEM$_$TOBJECT_$__$$_FREE
    global SYSTEM$_$TOBJECT_$__$$_FREEINSTANCE
    global SYSTEM$_$TOBJECT_$__$$_GETHASHCODE$$INT64
    global SYSTEM$_$TOBJECT_$__$$_SAFECALLEXCEPTION$TOBJECT$POINTER$$HRESULT
    GLOBAL SYSTEM$_$TOBJECT_$__$$_TOSTRING$$ANSISTRING
    global SYSTEM$_$TOBJECT_$__$$_NEWINSTANCE$$TOBJECT
    
    
    global RTTI_$QT_OBJECT_$$_QOBJECT
    global RTTI_$SYSTEM_$$_TOBJECT$indirect
    
    global THREADVARLIST_$SYSTEM$indirect

    global VMT_$QT_OBJECT_$$_QOBJECT
    global VMT_$SYSTEM_$$_TOBJECT$indirect
    
    section .text
fpc_initializeunits:
fpc_libinitializeunits:

FPC_EMPTYMETHOD:
FPC_DONEEXCEPTION:

SYSTEM$_$TOBJECT_$__$$_DISPATCH$formal:
SYSTEM$_$TOBJECT_$__$$_DISPATCHSTR$formal:

SYSTEM$_$TOBJECT_$__$$_EQUALS$TOBJECT$$BOOLEAN:

SYSTEM$_$TOBJECT_$__$$_FREE:
SYSTEM$_$TOBJECT_$__$$_FREEINSTANCE:
SYSTEM$_$TOBJECT_$__$$_GETHASHCODE$$INT64:

INIT$_$FPINTRES:
INIT$_$SYSTEM:

SYSTEM$_$TOBJECT_$__$$_SAFECALLEXCEPTION$TOBJECT$POINTER$$HRESULT:
SYSTEM$_$TOBJECT_$__$$_TOSTRING$$ANSISTRING:
SYSTEM$_$TOBJECT_$__$$_NEWINSTANCE$$TOBJECT:

RTTI_$QT_OBJECT_$$_QOBJECT:
RTTI_$SYSTEM_$$_TOBJECT$indirect:

FINALIZE$_$OBJPAS:

THREADVARLIST_$SYSTEM$indirect:
VMT_$SYSTEM_$$_TOBJECT$indirect:

VMT_$QT_OBJECT_$$_QOBJECT:
    ret
