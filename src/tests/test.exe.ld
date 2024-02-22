/* ----------------------------------------------------------------- */
/* File:   test.exe.ld - linker script for executable files          */
/* Author: (c) 2024 Jens Kallup - paule32                            */
/* All rights reserved                                               */
/*                                                                   */
/* only for education, and non-profit usage !                        */
/* ----------------------------------------------------------------- */
ENTRY(PASCALMAIN)

SEARCH_DIR(".\units\fpc-sys")
SEARCH_DIR(".\units\fpc-win")
SEARCH_DIR(".\units\fpc-rtl")
SEARCH_DIR(".\units\fpc-qt")
SEARCH_DIR(".\tests\units")
INPUT(
.\units\test1.o
.\units\fpcinit.o
.\units\system.o
.\units\RTL_Utils.o
)
GROUP(
.\units\libimpsystem.a
)
OUTPUT_FORMAT(pei-x86-64)
SECTIONS
{
  . = SIZEOF_HEADERS;
  . = ALIGN(__section_alignment__);
  .text  __image_base__ + ( __section_alignment__ < 0x1000 ? . : __section_alignment__ ) :
  {
    __text_start__ = . ;
    mainCRTstartup = . ;
    *(.init)
    *(.text .stub .text.* .gnu.linkonce.t.*)
    *(SORT(.text$*))
    *(.glue_7t)
    *(.glue_7)
    . = ALIGN(8);
     ___CTOR_LIST__ = .; __CTOR_LIST__ = . ;
    LONG (-1);
    LONG (-1);
    *(.ctors); *(.ctor); *(SORT(.ctors.*));  LONG (0);
    LONG (0);
     ___DTOR_LIST__ = .; __DTOR_LIST__ = . ;
    LONG (-1);
    LONG (-1);
    *(.dtors); *(.dtor); *(SORT(.dtors.*));  LONG (0);
    LONG (0);
     *(.fini)
    PROVIDE (etext = .);
    *(.gcc_except_table)
  }
  .data BLOCK(__section_alignment__) :
  {
    __data_start__ = . ;
    *(.data .data.* .gnu.linkonce.d.* .fpc*)
    *(.data2)
    *(SORT(.data$*))
    *(.jcr)
    PROVIDE (_tls_index = .);
    LONG (0);
    __data_end__ = . ;
    *(.data_cygwin_nocopy)
  }
  .rdata BLOCK(__section_alignment__) :
  {
    *(.rdata)
    *(.rdata.*)
    *(.rodata .rodata.* .gnu.linkonce.r.*)
    *(SORT(.rdata$*))
    *(.eh_frame)
    ___RUNTIME_PSEUDO_RELOC_LIST__ = .;
    __RUNTIME_PSEUDO_RELOC_LIST__ = .;
    *(.rdata_runtime_pseudo_reloc)
    ___RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
    __RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
  }
  .pdata BLOCK(__section_alignment__) : { *(.pdata) }
  .bss BLOCK(__section_alignment__) :
  {
    __bss_start__ = . ;
    *(.bss .bss.* .gnu.linkonce.b.*)
    *(SORT(.bss$*))
    *(COMMON)
    __bss_end__ = . ;
  }
  .edata BLOCK(__section_alignment__) : { *(.edata) }
  .idata BLOCK(__section_alignment__) :
  {
    SORT(*)(.idata$2)
    SORT(*)(.idata$3)
  }
  
    /* ---------------------------- */
    /* important for future usage ! */
    /* ---------------------------- */
    .import BLOCK(__section_alignment__) : {
        def__import_table_version = 19560719 ;
        def__import_table_start   = . ;
        def__import_table_end     = . ;
    }
  
  .CRT BLOCK(__section_alignment__) :
  {
    ___crt_xc_start__ = . ;
    *(SORT(.CRT$XC*))  /* C initialization */
    ___crt_xc_end__ = . ;
    ___crt_xi_start__ = . ;
    *(SORT(.CRT$XI*))  /* C++ initialization */
    ___crt_xi_end__ = . ;
    ___crt_xl_start__ = . ;
    *(SORT(.CRT$XL*))  /* TLS callbacks */
    /* ___crt_xl_end__ is defined in the TLS Directory support code */
    PROVIDE (___crt_xl_end__ = .);
    ___crt_xp_start__ = . ;
    *(SORT(.CRT$XP*))  /* Pre-termination */
    ___crt_xp_end__ = . ;
    ___crt_xt_start__ = . ;
    *(SORT(.CRT$XT*))  /* Termination */
    ___crt_xt_end__ = . ;
  }
  .tls BLOCK(__section_alignment__) :
  {
    ___tls_start__ = . ;
    *(.tls .tls.*)
    *(.tls$)
    *(SORT(.tls$*))
    ___tls_end__ = . ;
  }
  .rsrc BLOCK(__section_alignment__) :
  {
    *(.rsrc)
    *(SORT(.rsrc$*))
  }
/*  .reloc BLOCK(__section_alignment__) : { *(.reloc) }*/
}
