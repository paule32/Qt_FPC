// ---------------------------------------------------------------------------
// This file is part of RTL.
//
// (c) Copyright 2021 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$mode delphi}
unit system;

interface
// ---------------------------------------------------------------------------
// 64-bit data types
// ---------------------------------------------------------------------------
type Short_BYTE  =                 -128..127;
type Short_WORD  =               -32768..32767;
type Short_DWORD =          -2147483648..2147483647;
type Short_QWORD = -9223372036854775808..9223372036854775807;

type Long_BYTE   =  0..255;
type Long_WORD   =  0..65535;
type Long_DWORD  =  0..4294967295;
type Long_QWORD  =  0..18446744073709551615;

type DWord = Long_DWORD;

type Integer  =      QWord;
type Cardinal = Long_QWord;

function sizeByte : Byte; inline; //  1
function sizeChar : Byte; inline; //  2
function sizeWord : Byte; inline; //  4
function sizeDWord: Byte; inline; //  8
function sizeQWord: Byte; inline; // 16

type CodePointer  = Pointer;
type PShortString = ^ShortString;

// ---------------------------------------------------------------------------
// win32api constants, and variables ...
// ---------------------------------------------------------------------------
type THandle =  Long_DWord;     // onject handle
type PHandle = ^THandle;

type LCID    = Long_DWord;      // a local identifier
type LANGID  = Long_Word;       // a language identifier

type WPARAM  = Long_DWord;      // 32-bit message parameter
type LPARAM  = Long_DWord;      // 32-bit message parameter

type LRESULT = Long_DWord;      // 32-bit unsigned return value
type HRESULT = Short_DWord;     // 32-bit signed   return value

type HWND    = Long_DWord;      // a handle to a window
type ATOM    = Long_DWord;      // local/global atom index for a string

type HGLOBAL = THandle;         // a globally memory allocated handle

type UINT    =  Long_DWord;
type SIZE_T  =  Long_DWord;

const DLL_STR_kernel32 = 'kernel32.dll';

// ---------------------------------------------------------------------------
// win32api LocalAlloc, LocalReAlloc, and LocalFree:
// ---------------------------------------------------------------------------
const LMEM_MOVEABLE = $0002;
const LMEM_ZEROINIT = $0040;

const LHND = LMEM_MOVEABLE or LMEM_ZEROINIT;

type
	TMsgStrTable = record
		name: PShortString;			// Message name
		method: CodePointer;		// Method to call
	end;

type
	TStringMessageTable = record
		count: Long_DWord; 			// Number of messages in the string table.
		msgstrtable: array [0..0] of TMsgStrTable;
	end;

type
	PStringMessageTable = ^TStringMessageTable;

type
	PGuid = ^TGuid;
	TGuid = packed record
    case Integer of
        1 : (
            Data1 : Long_DWord;
            Data2 : word;
            Data3 : word;
            Data4 : array[0..7] of byte;
        );
        2 : (
            D1 : Long_DWord;
            D2 : word;
            D3 : word;
            D4 : array[0..7] of byte;
        );
        3 : ( { uuid fields according to RFC4122 }
            time_low : Long_DWord;
            time_mid : word;
            time_hi_and_version : word;
            clock_seq_hi_and_reserved : byte;
            clock_seq_low : byte;
            node : array[0..5] of byte;
        );
    end;

type
	TInterfaceEntryType = (
		etStandard, 				// Standard entry
		etVirtualMethodResult,		// Virtual method
		etStaticMethodResult,		// Static method
		etFieldValue,				// Field value
		etVirtualMethodClass,		// Interface provided by a virtual class method
		etStaticMethodClass,		// Interface provided by a static class method
		etFieldValueClass			// Interface provided by a class field
	);

type
	TInterfaceEntry = record
		IID   : PGuid;
		IIDStr: PShortString;
		IIDRef: Pointer;
		VTable: Pointer;
		case Integer of
		1: (
			IOffset: Long_DWord;
		);
		2: (
			IOffsetAsCodePtr: CodePointer;
			IIDStrRef       : Pointer;
			IType           : TInterfaceEntryType;
      );
	end;

type
	PInterfaceTable = ^TInterfaceTable;
	TInterfaceTable = record
		EntryCount: Long_DWord;
		Entries: array [0..0] of TInterfaceEntry;
	end;

type
	PPVmt = ^PVmt;
	PVmt  = ^TVmt;
	TVmt = record
		vInstanceSize     : DWord;
       	vInstanceSize2    : DWord;
       	vParentRef        : PPVmt;
       	vClassName        : PShortString;
       	vDynamicTable     : Pointer;
       	vMethodTable      : Pointer;
       	vFieldTable       : Pointer;
       	vTypeInfo         : Pointer;
       	vInitTable        : Pointer;
       	vAutoTable        : Pointer;
       	vIntfTable        : PInterfaceTable;
       	vMsgStrPtr        : PStringMessageTable;
       	vDestroy          : CodePointer;
       	vNewInstance      : CodePointer;
       	vFreeInstance     : CodePointer;
       	vSafeCallException: CodePointer;
       	vDefaultHandler   : CodePointer;
       	vAfterConstruction: CodePointer;
       	vBeforeDestruction: CodePointer;
       	vDefaultHandlerStr: CodePointer;
       	vDispatch         : CodePointer;
       	vDispatchStr      : CodePointer;
       	vEquals           : CodePointer;
       	vGetHashCode      : CodePointer;
       	vToString         : CodePointer;
	private
		function GetvParent: PVmt; inline;
	public
		property vParent: PVmt read GetvParent;
	end;


type
	PJmp_buf = ^jmp_buf;
	jmp_buf  = packed record
		ebx:   Long_DWord;
		esi:   Long_DWord;
		edi:   Long_DWord;
		bp:    Pointer;
		sp:    Pointer;
		pc:    Pointer;
	end;

type
	PExceptAddr = ^TExceptAddr;
	TExceptAddr = record
		buf       : pjmp_buf;
		next      : PExceptAddr;
		frametype : Long_Dword;
	end;

type
	FileRec = record
		Mode: LongInt;
	end;

type
	TTypeKind = (
		tkUnknown,		// Unknown property type.
		tkInteger,		// Integer property.
		tkChar, 		// Char property.
		tkEnumeration,	// Enumeration type property.
		tkFloat,		// Float property.
		tkSet,			// Set property.
		tkMethod,		// Method property.
		tkSString,		// Shortstring property.
		tkLString,		// Longstring property.
		tkAString,		// Ansistring property.
		tkWString,		// Widestring property.
		tkVariant,		// Variant property.
		tkArray,		// Array property.
		tkRecord,		// Record property.
		tkInterface,	// Interface property.
		tkClass,		// Class property.
		tkObject,		// Object property.
		tkWChar,		// Widechar property.
		tkBool,			// Boolean property.
		tkInt64,		// Int64 property.
		tkQWord,		// QWord property.
		tkDynArray, 	// Dynamic array property.
		tkInterfaceRaw, // Raw interface property.
		tkProcVar,		// Procedural variable
		tkUString,		// Unicode string
		tkUChar,		// Unicode character
		tkHelper,		// Helper type
		tkFile, 		// File type
		tkClassRef, 	// Class reference type
		tkPointer		// Generic pointer type
	);

type
	PText = ^Text;
	
	TextRec = packed  record
//		Handle    : THandle;
		Mode      : Long_DWord;
		bufsize   : Long_DWord;
		_private  : Long_DWord;
		bufpos,
		bufend    : Long_DWord;
//		bufptr    : ^textbuf;
//		openfunc,
//		inoutfunc,
//		flushfunc,
//		closefunc : codepointer;
//		UserData  : array[1..32] of byte;
//		name      : array[0..textrecnamelength-1] of TFileTextRecChar;
//		LineEnd   : TLineEndStr;
//		buffer    : textbuf;
  End;

Type
  TAnsiRec = record
    CodePage: UINT;
    Len     : Short_DWord;
  end;
  PAnsiRec = ^TAnsiRec;

const
  AnsiFirstOff = sizeof(TAnsiRec);

type
    TObject = class
    public
        constructor Create;
        destructor Destroy;virtual;
    end;

procedure fpc_ansistr_decr_ref (Var S : Pointer); compilerproc;
procedure fpc_AnsiStr_Incr_Ref (    S : Pointer); compilerproc; inline;

Procedure fpc_AnsiStr_Assign   (Var DestS : Pointer;S2 : Pointer); compilerproc;
procedure fpc_AnsiStr_Concat   (var DestS : String;const S1,S2 : String); compilerproc;


function  fpc_get_input: PText;         compilerproc;
procedure fpc_iocheck;                  compilerproc;
procedure fpc_readln_end(var f: Text);	compilerproc;

function  fpc_help_constructor(_self:pointer;var _vmt:pointer;_vmt_pos:cardinal):pointer;compilerproc;
procedure fpc_help_destructor(_self,_vmt:pointer;vmt_pos:cardinal);compilerproc;
procedure fpc_help_fail(_self:pointer;var _vmt:pointer;vmt_pos:cardinal);compilerproc;

procedure fpc_ReRaise; compilerproc;

procedure fpc_initializeunits; cdecl; external name 'fpc_initializeunits'; compilerproc;
procedure fpc_do_exit; compilerproc;


// ---------------------------------------------------------------------------
// win32api module kernel32.dll:
// ---------------------------------------------------------------------------
function  LocalAlloc( uFlags: UINT; uBytes: SIZE_T): UINT; cdecl; external DLL_STR_kernel32 name 'LocalAlloc';
procedure ExitProcess( ExitCode: LongInt ); cdecl; external DLL_STR_kernel32 name 'ExitProcess';

procedure move(const source; var dest; count: DWord);

implementation

function sizeByte : Byte; inline; begin result :=  1; end;
function sizeChar : Byte; inline; begin result :=  2; end;
function sizeWord : Byte; inline; begin result :=  4; end;
function sizeDWord: Byte; inline; begin result :=  8; end;
function sizeQWord: Byte; inline; begin result := 16; end;

// ---------------------------------------------------------------------------
// core Pascal entry point stuff:
// ---------------------------------------------------------------------------
procedure PascalMain; external name 'PASCALMAIN';
procedure Entry; [public, alias: '_mainCRTstartup'];
begin
    PascalMain;
    ExitProcess(0);
end;


constructor TObject.Create;
begin

end;
destructor TObject.Destroy;
begin
end;

procedure fpc_ansistr_decr_ref(Var S: Pointer); [public, alias: 'FPC_ANSISTR_DECR_REF'];  compilerproc;
Var
  p: PAnsiRec;
Begin
  { Zero string }
  If S=Nil then 
    exit;
  { check for constant strings ...}
//  p:=PAnsiRec(S-AnsiFirstOff);
//  s:=nil;
//  If p^.ref<0 then exit;
  { declocked does a MT safe dec and returns true, if the counter is 0 }
//  If declocked(p^.ref) then
//    FreeMem(p);
end;

Procedure fpc_AnsiStr_Incr_Ref (S : Pointer); [Public,Alias:'FPC_ANSISTR_INCR_REF'];  compilerproc; inline;
Begin
  If S=Nil then
    exit;
  { Let's be paranoid : Constant string ??}
//  If PAnsiRec(S-AnsiFirstOff)^.Ref<0 then exit;
end;

Procedure fpc_ansistr_assign(Var DestS: Pointer; S2: Pointer); [Public, Alias:'FPC_ANSISTR_ASSIGN']; compilerproc;
begin
  if DestS = S2 then
  exit;
  
  if DestS = nil then
  begin
    DestS := Pointer( LocalAlloc( LHND, 256 ) );
  end;
  
//  If S2<>nil then
//    If PAnsiRec(S2-AnsiFirstOff)^.Ref>0 then
//      inclocked(PAnsiRec(S2-AnsiFirstOff)^.Ref);
  { Decrease the reference count on the old S1 }
  //fpc_ansistr_decr_ref (DestS);
  { And finally, have DestS pointing to S2 (or its copy) }
  DestS := S2;
end;

procedure fpc_AnsiStr_Concat   (var DestS : String;const S1,S2 : String); compilerproc;
Var
  S1Len, S2Len: Long_DWord;
  same : boolean;
begin
  S1Len:=Length(S1);
  S2Len:=length(S2);
  
  DestS := 'S1 + S2';
end;

function TVmt.GetvParent: PVMT;
begin
	result := nil;
end;

function  fpc_get_input: PText; compilerproc;
begin
	result := nil;
end;

procedure fpc_readln_end(var f: Text); [public,alias:'FPC_READLN_END']; iocheck; compilerproc;
begin end;

procedure fpc_do_exit; alias: 'FPC_DO_EXIT'; compilerproc;
begin
  ExitProcess(0);
end;

procedure fpc_iocheck; compilerproc;
begin end;

// -----------------------------------------------------
// object pascal ...
// -----------------------------------------------------
function  fpc_help_constructor(_self:pointer;var _vmt:pointer;_vmt_pos:cardinal):pointer;compilerproc;
begin result := nil end;

procedure fpc_help_destructor(_self,_vmt:pointer;vmt_pos:cardinal);compilerproc;
begin end;

procedure fpc_help_fail(_self:pointer;var _vmt:pointer;vmt_pos:cardinal);compilerproc;
begin end;

procedure fpc_ReRaise; compilerproc;
begin end;


procedure move(const source; var dest; count: DWord); assembler; nostackframe;
asm
    mov    %r8, %rax
    sub    %rdx, %rcx            { rcx = src - dest }
    jz     .Lquit                { exit if src=dest }
    jnb    .L1                   { src>dest => forward move }

    add    %rcx, %rax            { rcx is negative => r8+rcx > 0 if regions overlap }
    jb     .Lback                { if no overlap, still do forward move }

.L1:
    cmp    $8, %r8
    jl     .Lless8f              { signed compare, negative count not allowed }
    test   $7, %dl
    je     .Ldestaligned

    test   $1, %dl               { align dest by moving first 1+2+4 bytes }
    je     .L2f
    mov    (%rcx,%rdx,1),%al
    dec    %r8
    mov    %al, (%rdx)
    add    $1, %rdx
.L2f:
    test   $2, %dl
    je     .L4f
    mov    (%rcx,%rdx,1),%ax
    sub    $2, %r8
    mov    %ax, (%rdx)
    add    $2, %rdx
.L4f:
    test   $4, %dl
    je     .Ldestaligned
    mov    (%rcx,%rdx,1),%eax
    sub    $4, %r8
    mov    %eax, (%rdx)
    add    $4, %rdx

.Ldestaligned:
    mov    %r8, %r9
    shr    $5, %r9
    jne    .Lmore32

.Ltail:
    mov    %r8, %r9
    shr    $3, %r9
    je     .Lless8f

    .balign 16
.Lloop8f:                             { max. 8 iterations }
    mov    (%rcx,%rdx,1),%rax
    mov    %rax, (%rdx)
    add    $8, %rdx
    dec    %r9
    jne    .Lloop8f
    and    $7, %r8

.Lless8f:
    test   %r8, %r8
    jle    .Lquit

    .balign 16
.Lloop1f:
    mov    (%rcx,%rdx,1),%al
    mov    %al,(%rdx)
    inc    %rdx
    dec    %r8
    jne    .Lloop1f
.Lquit:
    retq


.Lmore32:
    cmp    $0x2000, %r9          { this limit must be processor-specific (1/2 L2 cache size) }
    jnae   .Lloop32
    cmp    $0x1000, %rcx         { but don't bother bypassing cache if src and dest }
    jnb    .Lntloopf             { are close to each other}

    .balign 16
.Lloop32:
    add    $32,%rdx
    mov    -32(%rcx,%rdx,1),%rax
    mov    -24(%rcx,%rdx,1),%r10
    mov    %rax,-32(%rdx)
    mov    %r10,-24(%rdx)
    dec    %r9
    mov    -16(%rcx,%rdx,1),%rax
    mov    -8(%rcx,%rdx,1),%r10
    mov    %rax,-16(%rdx)
    mov    %r10,-8(%rdx)
    jne    .Lloop32

    and    $0x1f, %r8
    jmpq   .Ltail

.Lntloopf:
    mov    $32, %eax

    .balign 16
.Lpref:
    prefetchnta (%rcx,%rdx,1)
    prefetchnta 0x40(%rcx,%rdx,1)
    add    $0x80, %rdx
    dec    %eax
    jne    .Lpref

    sub    $0x1000, %rdx
    mov    $64, %eax

    .balign 16
.Loop64:
    add    $64, %rdx
    mov    -64(%rcx,%rdx,1), %r9
    mov    -56(%rcx,%rdx,1), %r10
    movnti %r9, -64(%rdx)
    movnti %r10, -56(%rdx)

    mov    -48(%rcx,%rdx,1), %r9
    mov    -40(%rcx,%rdx,1), %r10
    movnti %r9, -48(%rdx)
    movnti %r10, -40(%rdx)
    dec    %eax
    mov    -32(%rcx,%rdx,1), %r9
    mov    -24(%rcx,%rdx,1), %r10
    movnti %r9, -32(%rdx)
    movnti %r10, -24(%rdx)

    mov    -16(%rcx,%rdx,1), %r9
    mov    -8(%rcx,%rdx,1), %r10
    movnti %r9, -16(%rdx)
    movnti %r10, -8(%rdx)
    jne    .Loop64

    sub    $0x1000, %r8
    cmp    $0x1000, %r8
    jae    .Lntloopf

    mfence
    jmpq    .Ldestaligned        { go handle remaining bytes }

{ backwards move }
.Lback:
    add    %r8, %rdx             { points to the end of dest }
    cmp    $8, %r8
    jl     .Lless8b              { signed compare, negative count not allowed }
    test   $7, %dl
    je     .Ldestalignedb
    test   $1, %dl
    je     .L2b
    dec    %rdx
    mov    (%rcx,%rdx,1), %al
    dec    %r8
    mov    %al, (%rdx)
.L2b:
    test   $2, %dl
    je     .L4b
    sub    $2, %rdx
    mov    (%rcx,%rdx,1), %ax
    sub    $2, %r8
    mov    %ax, (%rdx)
.L4b:
    test   $4, %dl
    je     .Ldestalignedb
    sub    $4, %rdx
    mov    (%rcx,%rdx,1), %eax
    sub    $4, %r8
    mov    %eax, (%rdx)

.Ldestalignedb:
    mov    %r8, %r9
    shr    $5, %r9
    jne    .Lmore32b

.Ltailb:
    mov    %r8, %r9
    shr    $3, %r9
    je     .Lless8b

.Lloop8b:
    sub    $8, %rdx
    mov    (%rcx,%rdx,1), %rax
    dec    %r9
    mov    %rax, (%rdx)
    jne    .Lloop8b
    and    $7, %r8

.Lless8b:
    test   %r8, %r8
    jle    .Lquit2

    .balign 16
.Lsmallb:
    dec   %rdx
    mov   (%rcx,%rdx,1), %al
    dec   %r8
    mov   %al,(%rdx)
    jnz   .Lsmallb
.Lquit2:
    retq

.Lmore32b:
    cmp   $0x2000, %r9
    jnae  .Lloop32b
    cmp    $0xfffffffffffff000,%rcx
    jb     .Lntloopb

    .balign 16
.Lloop32b:
    sub    $32, %rdx
    mov    24(%rcx,%rdx,1), %rax
    mov    16(%rcx,%rdx,1), %r10
    mov    %rax, 24(%rdx)
    mov    %r10, 16(%rdx)
    dec    %r9
    mov    8(%rcx,%rdx,1),%rax
    mov    (%rcx,%rdx,1), %r10
    mov    %rax, 8(%rdx)
    mov    %r10, (%rdx)
    jne    .Lloop32b
    and    $0x1f, %r8
    jmpq   .Ltailb

.Lntloopb:
    mov    $32, %eax

    .balign 16
.Lprefb:
    sub    $0x80, %rdx
    prefetchnta (%rcx,%rdx,1)
    prefetchnta 0x40(%rcx,%rdx,1)
    dec    %eax
    jnz    .Lprefb

    add    $0x1000, %rdx
    mov    $0x40, %eax

    .balign 16
.Lloop64b:
    sub    $64, %rdx
    mov    56(%rcx,%rdx,1), %r9
    mov    48(%rcx,%rdx,1), %r10
    movnti %r9, 56(%rdx)
    movnti %r10, 48(%rdx)

    mov    40(%rcx,%rdx,1), %r9
    mov    32(%rcx,%rdx,1), %r10
    movnti %r9, 40(%rdx)
    movnti %r10, 32(%rdx)
    dec    %eax
    mov    24(%rcx,%rdx,1), %r9
    mov    16(%rcx,%rdx,1), %r10
    movnti %r9, 24(%rdx)
    movnti %r10, 16(%rdx)

    mov    8(%rcx,%rdx,1), %r9
    mov    (%rcx,%rdx,1), %r10
    movnti %r9, 8(%rdx)
    movnti %r10, (%rdx)
    jne    .Lloop64b

    sub    $0x1000, %r8
    cmp    $0x1000, %r8
    jae    .Lntloopb
    mfence
    jmpq   .Ldestalignedb
end;

end.
