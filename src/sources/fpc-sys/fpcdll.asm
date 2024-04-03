; ----------------------------------------------------------------------------
; file:   fpcdll.asm
; author: (c) 2024 Jens Kallup - paule32
; all rights reserved
;
; only for education, and non-profit usage !
; ----------------------------------------------------------------------------

;;extern def__import_table_version    ; important for future usage !
;;extern def__import_table_start
;;extern def__import_table_end

; ----------------------------------------------------------------------------
; import function/name offset table:
; ----------------------------------------------------------------------------
;;global def__FPC_move
;;extern      FPC_move

;;section .import
;;    dd def__import_table_version    ; magic cokkie + version => 1
;;    dd def__import_table_start
    ;
;;    dd def__FPC_move
    ;
;;    dd def__import_table_end


;;section .data
;;def__FPC_move:
;;    dd  FPC_move
;;    dd  str__FPC_move

; ----------------------------------------------------------------------------
; import data .idata string table:
; ----------------------------------------------------------------------------
;;str__FPC_move:
;;    db "FPC_move", 0

