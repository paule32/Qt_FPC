// ---------------------------------------------------------------------------
// This file is part of RTL.
//
// (c) Copyright 2021 Jens Kallup - paule32
// only for non-profit usage !!!
// ---------------------------------------------------------------------------
{$mode delphi}{$H+}
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

procedure fpc_ansistr_decr_ref (Var S : Pointer); compilerproc;
procedure fpc_AnsiStr_Incr_Ref (    S : Pointer); compilerproc; inline;

Procedure fpc_AnsiStr_Assign   (Var DestS : Pointer;S2 : Pointer); compilerproc;
procedure fpc_AnsiStr_Concat   (var DestS : String;const S1,S2 : String; cp: DWORD); compilerproc;


function  fpc_get_input: PText;         compilerproc;
procedure fpc_iocheck;                  compilerproc;
procedure fpc_readln_end(var f: Text);	compilerproc;

function  fpc_help_constructor(_self:pointer;var _vmt:pointer;_vmt_pos:cardinal):pointer;compilerproc;
procedure fpc_help_destructor(_self,_vmt:pointer;vmt_pos:cardinal);compilerproc;
procedure fpc_help_fail(_self:pointer;var _vmt:pointer;vmt_pos:cardinal);compilerproc;

procedure fpc_ReRaise; compilerproc;

procedure fpc_initializeunits;    cdecl; external name 'fpc_initializeunits';    compilerproc;
procedure fpc_libinitializeunits; cdecl; external name 'fpc_libinitializeunits'; compilerproc;

procedure fpc_finalize(Data,TypeInfo: Pointer); compilerproc;
procedure fpc_copy_proc(Src, Dest, TypeInfo : Pointer); compilerproc; inline;
procedure fpc_do_exit; compilerproc;

// ---------------------------------------------------------------------------
// win32api module kernel32.dll:
// ---------------------------------------------------------------------------
function  LocalAlloc( uFlags: UINT; uBytes: SIZE_T): UINT; cdecl; external DLL_STR_kernel32 name 'LocalAlloc';
procedure ExitProcess( ExitCode: LongInt ); cdecl; external DLL_STR_kernel32 name 'ExitProcess';

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


procedure fpc_copy_proc(Src, Dest, TypeInfo : Pointer);compilerproc; inline;
begin end;

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

procedure fpc_AnsiStr_Concat   (var DestS : String;const S1,S2 : String; cp: DWORD); compilerproc;
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

procedure fpc_finalize(Data,TypeInfo: Pointer); compilerproc;
begin end;

end.
