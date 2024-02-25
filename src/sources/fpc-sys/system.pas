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

type CodePointer  = Pointer;
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

Procedure fpc_AnsiStr_Assign   (Var DestS : Pointer;S2 : Pointer); compilerproc;
procedure fpc_AnsiStr_Concat   (var DestS : String;const S1,S2 : String; cp: DWORD); compilerproc;


function  fpc_get_input: PText;         compilerproc;
procedure fpc_iocheck;                  compilerproc;
procedure fpc_readln_end(var f: Text);	compilerproc;

function  fpc_help_constructor(_self:pointer;var _vmt:pointer;_vmt_pos:cardinal):pointer;compilerproc;
procedure fpc_help_destructor(_self,_vmt:pointer;vmt_pos:cardinal);compilerproc;
procedure fpc_help_fail(_self:pointer;var _vmt:pointer;vmt_pos:cardinal);compilerproc;

procedure fpc_doneexception; compilerproc;

procedure fpc_ReRaise; compilerproc;

procedure fpc_initializeunits; compilerproc;
procedure fpc_libinitializeunits; cdecl; external name 'fpc_libinitializeunits'; compilerproc;

procedure fpc_finalize(Data,TypeInfo: Pointer); compilerproc;
procedure fpc_copy_proc(Src, Dest, TypeInfo : Pointer); compilerproc; inline;
procedure fpc_do_exit; compilerproc;

procedure EmptyMethod; external name 'FPC_EMPTYMETHOD';

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
        FStringObject.FString := other.FString;
    end;
end;
destructor QString.Destroy;
begin
    FStringObject.Free;
end;

function QString.append(str: String): QString;
begin
    if FStringObject = nil then
    FStringObject := self;

    FStringObject.FString := FStringObject.FString + str;
    result := FStringObject;
end;

function QString.append(other: QString): QString;
begin
    if other = nil then
    other := self;

    FStringObject := other;
    FStringObject.FString := other.FString;

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

procedure fpc_ansistr_assign(var DestS: Pointer; S2: Pointer); [public, alias: 'FPC_ANSISTR_ASSIGN']; compilerproc;
Var
  MyHeap: THandle;
begin
    if DestS = S2 then
    exit;

    MyHeap := THandle( HeapCreate( HEAP_NO_SERIALIZE, $ffff, 0 ) );
    if MyHeap = 0 then
    begin
        MessageBox( 0,'Error creating private heap.', 'title', 0 );
        exit;
    end;

    MessageBox( 0, 'oookkkkk', 'title', 0 );

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
  S1Len, S2Len: LongDWord;
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

procedure fpc_InitializeUnits;[public,alias:'FPC_INITIALIZEUNITS']; compilerproc;
begin
end;

end.
