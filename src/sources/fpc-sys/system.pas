// ---------------------------------------------------------------------------
// This file is part of RTL.
//
// (c) Copyright 2024 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$mode delphi}{$H+}
unit system;

interface
// ---------------------------------------------------------------------------
// 64-bit data types
// ---------------------------------------------------------------------------
type ShortBYTE  =                 -128..127;
type ShortWORD  =               -32768..32767;
type ShortDWORD =          -2147483648..2147483647;
type ShortQWORD = -9223372036854775808..9223372036854775807;

type LongBYTE   =  0..255;
type LongDWORD  =  0..4294967295;
type LongQWORD  =  0..18446744073709551615;

type Integer  = QWord;
type Cardinal = QWord;

function sizeByte : Byte; inline; //  1
function sizeChar : Byte; inline; //  2
function sizeWord : Byte; inline; //  4
function sizeDWord: Byte; inline; //  8
function sizeQWord: Byte; inline; // 16

type DWORD  = LongDWORD;
type UINT   = LongDWORD;
type SIZE_T = LongDWORD;

type CodePointer  = Pointer;

type PChar        = ^Char;
type PShortString = ^ShortString;

{$define windows_header}
{$I RTL_Windows.pas}

// ---------------------------------------------------------------------------
type
	TMsgStrTable = record
		name: PShortString;			// Message name
		method: CodePointer;		// Method to call
	end;

type
	TStringMessageTable = record
		count: LongDWord; 			// Number of messages in the string table.
		msgstrtable: array [0..0] of TMsgStrTable;
	end;

type
	PStringMessageTable = ^TStringMessageTable;

type
	PGuid = ^TGuid;
	TGuid = packed record
    case Integer of
        1 : (
            Data1 : LongDWord;
            Data2 : word;
            Data3 : word;
            Data4 : array[0..7] of byte;
        );
        2 : (
            D1 : LongDWord;
            D2 : word;
            D3 : word;
            D4 : array[0..7] of byte;
        );
        3 : ( { uuid fields according to RFC4122 }
            time_low : LongDWord;
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
			IOffset: LongDWord;
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
		EntryCount: LongDWord;
		Entries: array [0..0] of TInterfaceEntry;
	end;

type
	PPVmt = ^PVmt;
	PVmt  = ^TVmt;
	TVmt = record
		vInstanceSize     : LongDWord;
       	vInstanceSize2    : LongDWord;
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
		ebx:   LongDWord;
		esi:   LongDWord;
		edi:   LongDWord;
		bp:    Pointer;
		sp:    Pointer;
		pc:    Pointer;
	end;

type
	PExceptAddr = ^TExceptAddr;
	TExceptAddr = record
		buf       : pjmp_buf;
		next      : PExceptAddr;
		frametype : LongDword;
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
		Mode      : LongDWord;
		bufsize   : LongDWord;
		_private  : LongDWord;
		bufpos,
		bufend    : LongDWord;
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
    Len     : ShortDWord;
  end;
  PAnsiRec = ^TAnsiRec;

const
  AnsiFirstOff = sizeof(TAnsiRec);

// ---------------------------------------------------------------------------
// TObjectm and IUnknown has to be defined first as forward class ...
// ---------------------------------------------------------------------------
type
    TObject = class
    public
        constructor Create;
        destructor Destroy; virtual;
        class function newinstance : tobject; virtual;
        procedure FreeInstance; virtual;
        function SafeCallException( exceptobject: tobject; exceptaddr: codepointer ): HResult; virtual;
        procedure DefaultHandler(var message); virtual;
        
        procedure Free;

        procedure AfterConstruction; virtual;
        procedure BeforeDestruction; virtual;
    end;

    QObject = class(TObject)
    public
        constructor Create;
        destructor Destroy; virtual;
    end;

// ---------------------------------------------------------------------------
// QString Qt-Framework GUI ...
// ---------------------------------------------------------------------------
function Q_NULLPTR: Pointer; inline;

type
    QString  = class(QObject)
    protected
        FStringObject: QString;
        FString: String;
    public
        constructor Create(other: QString); overload;
        constructor Create(str: String); overload;
        constructor Create; overload;

        destructor Destroy; virtual;

        function append(str: String): QString; overload;
        function append(other: QString): QString; overload;

        function arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
    end;

// ---------------------------------------------------------------------------

procedure fpc_ansistr_decr_ref (Var S : Pointer); compilerproc;
procedure fpc_AnsiStr_Incr_Ref (    S : Pointer); compilerproc; inline;

procedure fpc_AnsiStr_Assign        (var DestS : Pointer;           S2: Pointer);           compilerproc;
procedure fpc_AnsiStr_Concat        (var dst   : String ; const S1, S2: String; cp: DWORD); compilerproc;

function  fpc_AnsiStr_Compare_Equal (const S1, S2: String): BOOL compilerproc;

function  fpc_char_to_ansistr (const c :  char): String; compilerproc;
function  fpc_pchar_to_ansistr(const p : pchar): String; compilerproc;

procedure fpc_EmptyChar( var DestS: Pointer); compilerproc;

function  fpc_get_input: PText;         compilerproc;
procedure fpc_iocheck;                  compilerproc;
procedure fpc_readln_end(var f: Text);	compilerproc;

function  fpc_help_constructor (_self: pointer; var _vmt: pointer; _vmt_pos: cardinal): Pointer;  compilerproc;
procedure fpc_help_fail        (_self: pointer; var _vmt: pointer;  vmt_pos: cardinal);           compilerproc;
procedure fpc_help_destructor  (_self,              _vmt: pointer;  vmt_pos: cardinal);           compilerproc;

procedure fpc_doneexception; compilerproc;

procedure fpc_ReRaise; compilerproc;

procedure fpc_initializeunits; compilerproc;
procedure fpc_libinitializeunits; compilerproc;

procedure fpc_finalize(Data,TypeInfo: Pointer); compilerproc;
procedure fpc_copy_proc(Src, Dest, TypeInfo : Pointer); compilerproc; inline;
procedure fpc_do_exit; compilerproc;

procedure EmptyMethod; external name 'FPC_EMPTYMETHOD';

function malloc (    s: DWORD                  ): PVOID ; cdecl; external 'ucrtbase.dll'   name 'malloc';
function strcat (var d: LPCSTR; const s: LPCSTR): LPCSTR; cdecl; external 'ucrtbase.dll'   name 'strcat';
function strcpy (var d: LPCSTR; const s: LPCSTR): LPCSTR; cdecl; external 'ucrtbase.dll'   name 'strcpy';
function strlen (               const s: LPCSTR): DWORD ; cdecl; external DLL_STR_kernel32 name 'lstrlenA';

procedure move (const source; var dest; count: DWord);

implementation

{$undef  windows_header}  // interface
{$define windows_source}  // impl

{$I RTL_Windows.pas}

function Q_NULLPTR: Pointer; inline;
begin
    result := Pointer(0);
end;

// ---------------------------------------------------------------------------
// TObject: the base class of all sub classes:
// ---------------------------------------------------------------------------
constructor TObject.Create;
begin
end;

destructor TObject.Destroy;
begin
end;
procedure TObject.AfterConstruction;
begin
end;
procedure TObject.BeforeDestruction;
begin
end;

procedure TObject.Free;
begin
    if self <> nil then
    self.destroy;
end;

class function TObject.NewInstance : tobject;
begin
end;

procedure TObject.FreeInstance;
begin
end;

function TObject.SafeCallException(exceptobject : tobject; exceptaddr : codepointer) : HResult;
begin
  result := 1;
end;

procedure TObject.DefaultHandler(var message);
begin
end;

// ---------------------------------------------------------------------------
// QObject
// ---------------------------------------------------------------------------
constructor QObject.Create;
begin
end;
destructor QObject.Destroy;
begin
end;

// ---------------------------------------------------------------------------
// QString Qt-Framework GUI ...
// ---------------------------------------------------------------------------
constructor QString.Create;
begin
    FStringObject := nil;
    //FStringObject.FString := '';
end;
constructor QString.Create(str: String);
begin
    FStringObject := nil;
    //FStringObject.FString := str;
end;
constructor QString.Create(other: QString);
begin
    if other <> nil then
    begin
        FStringObject := other;
        //FStringObject.FString := other.FString;
    end;
end;
destructor QString.Destroy;
begin
//    FStringObject.Free;
end;

function QString.append(str: String): QString;
begin
    if FStringObject = nil then
    FStringObject := self;

//    FStringObject.FString := FStringObject.FString + str;
    result := FStringObject;
end;

function QString.append(other: QString): QString;
begin
    if other = nil then
    other := self;

    FStringObject := other;
//    FStringObject.FString := other.FString;

    result := FStringObject;
end;

function QString.arg(a: QString; fieldWidth: Integer = 0; base: Integer = 10; fillChar: Char = ' '): QString;
begin
    result := FStringObject;
end;

function sizeByte : Byte; inline; begin result :=  1; end;
function sizeChar : Byte; inline; begin result :=  2; end;
function sizeWord : Byte; inline; begin result :=  4; end;
function sizeDWord: Byte; inline; begin result :=  8; end;
function sizeQWord: Byte; inline; begin result := 16; end;

procedure fpc_doneexception; [public, alias: 'FPC_DONEEXCEPTION'] compilerproc;
begin
end;

procedure fpc_emptymethod; [public, alias : 'FPC_EMPTYMETHOD'];
begin
end;

procedure fpc_copy_proc(Src, Dest, TypeInfo : Pointer);compilerproc; inline;
begin end;

procedure fpc_EmptyChar( var DestS: Pointer); [public, alias: 'FPC_EMPTYCHAR']; compilerproc;
var
    SA: PChar;
begin
    DestS := VirtualAlloc( nil, sizeof( Char ), MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE );
    if (not (DestS = nil)) then
    begin
        FillChar(  DestS^, sizeof( Char ), #0 );
        move( SA^, DestS^, sizeof( Char ) );
    end else
    begin
        MessageBox( 0, 'Error: fpc_AnsiStr_EmptyChar memory allocation fail.', 'Error', 0 );
        ExitProcess( 1 );
    end;
    // TODO: delete DestS
end;

procedure fpc_ansistr_decr_ref(Var S: Pointer); [public, alias: 'FPC_ANSISTR_DECR_REF'];  compilerproc;
Begin
end;

procedure fpc_AnsiStr_Incr_Ref (S : Pointer); [public, alias: 'FPC_ANSISTR_INCR_REF'];  compilerproc; inline;
Begin
end;

function  fpc_char_to_ansistr(const c : char): String; compilerproc;
var
    MyHeap: THandle;
    DestS: PChar;
begin
MessageBox(0,'s11111 111','s2',0);
    MyHeap := THandle( HeapCreate( HEAP_NO_SERIALIZE, $ffff, 0 ) );
    if MyHeap = 0 then
    begin
        MessageBox( 0,'Error: creating private heap.', 'Error', 0 );
        exit;
    end;
    DestS  := PChar( LocalAlloc( LHND, 2 ) );
    DestS^ := c;
    
    (DestS + 1)^ := #0;
    
    LocalFree( Pointer( MyHeap ) );
end;
function  fpc_pchar_to_ansistr(const p: PChar): String; compilerproc;
var
    MyHeap: THandle;
    DestS: PChar;
begin
MessageBox(0,'ssss1','s2',0);
    MyHeap := THandle( HeapCreate( HEAP_NO_SERIALIZE, $ffff, 0 ) );
    if MyHeap = 0 then
    begin
        MessageBox( 0,'Error: creating private heap.', 'Error', 0 );
        exit;
    end;
    DestS := PChar( LocalAlloc( LHND, 2 ) );
    DestS := p;
    
    (DestS + 1)^ := #0;
    
    LocalFree( Pointer( MyHeap ) );
end;

procedure fpc_ansistr_assign(var DestS: Pointer; S2: Pointer); [public, alias: 'FPC_ANSISTR_ASSIGN']; compilerproc;
var
    SLen: SIZE_T;
begin
    SLen  := strlen( LPCSTR( S2 ) );
    DestS := VirtualAlloc( nil, SLen, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE );
    
    if (not (DestS = nil)) then
    begin
        FillChar( DestS^, SLen, #0 );
        move( S2^, DestS^, SLen );
    end else
    begin
        MessageBox( 0, 'Error: fpc_AnsiStr_Assign memory allocation fail.', 'Error', 0 );
        ExitProcess( 1 );
    end;

    // TODO: add delete
    //VirtualFree( DestS, 0, MEM_RELEASE );
end;
procedure fpc_ansistr_concat(var dst: String; const S1,S2 : String; cp: DWORD); compilerproc;
Var
    S1Len, S2Len, S3Len: SIZE_T;
    DestS: Pointer;
    SA, SB: PChar;
begin
    S1Len := strlen( LPCSTR( S1 ) );
    S2Len := strlen( LPCSTR( S2 ) );
    
    S3Len := S1Len + S2Len + 1;
    DestS := VirtualAlloc( nil, S3Len, MEM_COMMIT or MEM_RESERVE, PAGE_READWRITE );
    
    if (not (DestS = nil)) then
    begin
        FillChar( DestS^, S3Len, #0 );
        
        SA := PChar( S1 );
        SB := PChar( S2 );
        
        move( SA^,        DestS^ , S1Len );
        move( SB^, (PChar(DestS) + S1Len)^, S2Len );
        
        dst := String( DestS );
    end else
    begin
        MessageBox( 0, 'Error: fpc_AnsiStr_Concat memory allocation fail.', 'Error', 0 );
        ExitProcess( 1 );
    end;
end;
function  fpc_AnsiStr_Compare_Equal (const S1, S2: String): BOOL; [public, alias: 'FPC_ANSISTR_COMPARE_EQUAL'] compilerproc;
var
    maxi, temp: DWORD;
begin
    if Pointer( S1 ) = Pointer( S2 ) then
    begin
        result := 1;
        exit;
    end;
    
    maxi := strlen( S1 );
    temp := strlen( S2 );
    
    result := maxi - temp;
    
    if result = 0 then
    begin
        if maxi > 0 then
        begin
            result := 1;
            exit;
        end;
        result := 0;
        exit;
    end;
    result := 1;
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

procedure fpc_finalize(Data,TypeInfo: Pointer); compilerproc;
begin end;

procedure fpc_initializeunits;    [public, alias:'FPC_INITIALIZEUNITS']; compilerproc; begin end;
procedure fpc_libinitializeunits; [public, alias:'FPC_LIBINITIALIZEUNITS']; compilerproc; begin end;

procedure move(const source; var dest; count: DWord); [public, alias:'FPC_move']; assembler; nostackframe;
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
