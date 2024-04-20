;extern QString_Create

section .text

global SYSTEM$_$QSTRING_$__$$_CREATE$$QSTRING
SYSTEM$_$QSTRING_$__$$_CREATE$$QSTRING:
    push    rbp             ; save current stack value
    mov     rbp, rsp        ; update rbp to show to new function body
    sub     rsp, 8 * 3      ; reserve 24 (8 * 3) Bytes
    
    ;mov    rcx, 42         ; first parameter (Windows ABI)
    ;mov    rdx, 75         ; second parameter ...
    ;mov    r8, 100         ; third parameter  ...
    
    ;call    QString_Create

    add     rsp, 24         ; reset the stack
    mov     rsp, rbp        ; set rsp value to rbp to reset stack
    pop     rbp             ; get the last value of rbp
    ret                     ; return to caller
