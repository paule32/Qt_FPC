; -------------------------------------------------------------------------------------------
; (c) 2022 by Jens Kallup <kallup-dev@web.de>
; all rights reserved.
; -------------------------------------------------------------------------------------------

    global fpc_initializeunits
    section .text
fpc_initializeunits:
    ret

    global FPC_EMPTYMETHOD
    section .text
FPC_EMPTYMETHOD:
    ret

    global SYSTEM$_$TOBJECT_$__$$_DESTROY
    section .text
SYSTEM$_$TOBJECT_$__$$_DESTROY:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_NEWINSTANCE$$TOBJECT
    section .text
SYSTEM$_$TOBJECT_$__$$_NEWINSTANCE$$TOBJECT:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_FREEINSTANCE
    section .text
SYSTEM$_$TOBJECT_$__$$_FREEINSTANCE:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_SAFECALLEXCEPTION$TOBJECT$POINTER$$HRESULT
    section .text
SYSTEM$_$TOBJECT_$__$$_SAFECALLEXCEPTION$TOBJECT$POINTER$$HRESULT:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_DISPATCH$formal
    section .text
SYSTEM$_$TOBJECT_$__$$_DISPATCH$formal:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_DISPATCHSTR$formal
    section .text
SYSTEM$_$TOBJECT_$__$$_DISPATCHSTR$formal:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_EQUALS$TOBJECT$$BOOLEAN
    section .text
SYSTEM$_$TOBJECT_$__$$_EQUALS$TOBJECT$$BOOLEAN:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_TOSTRING$$ANSISTRING
    section .text
SYSTEM$_$TOBJECT_$__$$_TOSTRING$$ANSISTRING:
    ret
    
    global RTTI_$SYSTEM_$$_TOBJECT$indirect
    section .text
RTTI_$SYSTEM_$$_TOBJECT$indirect:
    ret
    
    global FPC_DONEEXCEPTION
    section .text
FPC_DONEEXCEPTION:
    ret
    
    global VMT_$SYSTEM_$$_TOBJECT$indirect
    section .text
VMT_$SYSTEM_$$_TOBJECT$indirect:
    ret
    
    global SYSTEM$_$TOBJECT_$__$$_GETHASHCODE$$INT64
    section .text
SYSTEM$_$TOBJECT_$__$$_GETHASHCODE$$INT64:
    ret
    
    global RTTI_$QT_OBJECT_$$_QOBJECT
    section .text
RTTI_$QT_OBJECT_$$_QOBJECT:
    ret
    