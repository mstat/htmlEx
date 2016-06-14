unit wke;

interface

uses
  Windows, Graphics, Dialogs, Classes, MemoryModule;

type
  mUINT64 = record
    low32: DWORD;
    hig32: DWORD;
  end;

  wkeWebView = Pointer;
  jsExecState = Pointer;
  wkeString = Pointer;
  utf8 = AnsiChar;
  Putf8 = PAnsiChar;
  PWutf8 = PWideChar;
  // Cardinal
  jsValue = Int64; // Currency;//Int64;//UInt64;//
  PjsValue = ^Int64; // ^Int64;//UInt64;//
  wkeuint = ^Cardinal;
  wkeint = ^integer;
  jsType = (JSTYPE_NUMBER, JSTYPE_STRING, JSTYPE_BOOLEAN, JSTYPE_OBJECT,
    JSTYPE_FUNCTION, JSTYPE_UNDEFINED);

  ON_TITLE_CHANGED = procedure(const clientHandler: Pointer;
    title: wkeString); cdecl;
  ON_URL_CHANGED = procedure(const clientHandler: Pointer;
    url: wkeString); cdecl;

  _wkeClientHandler = record
    onTitleChanged: ON_TITLE_CHANGED;
    onURLChanged: ON_TITLE_CHANGED;
  end;

  PwkeClientHandler = ^_wkeClientHandler;
  PON_TITLE_CHANGED = ^ON_TITLE_CHANGED;
  PON_URL_CHANGED = ^ON_URL_CHANGED;

  wkeRect = record
    x: integer;
    y: integer;
    w: integer;
    h: integer;
  end;

  // jsNativeFunction = function(es:jsExecState):jsValue of Object;
  // jsNativeFunction = function(es:jsExecState):jsValue; cdecl;
  jsNativeFunction = Pointer;
  PjsNativeFunction = ^jsNativeFunction;

  { TwkeClientHandler = record
    name:string;
    id:string;
    end; }
  // WKE_API void wkeSetClientHandler(wkeWebView webView, const wkeClientHandler* handler);
  // WKE_API const wkeClientHandler* wkeGetClientHandler(wkeWebView webView);

  {
    WKE_API void wkeSelectAll(wkeWebView webView);
    WKE_API void wkeCopy(wkeWebView webView);
    WKE_API void wkeCut(wkeWebView webView);
    WKE_API void wkePaste(wkeWebView webView);
    WKE_API void wkeDelete(wkeWebView webView);

    WKE_API void wkeSleep(wkeWebView webView);
    WKE_API void wkeAwaken(wkeWebView webView);
    WKE_API bool wkeIsAwake(wkeWebView webView);
  }

  TwkeSelectAll = procedure(webView: wkeWebView); cdecl;
  TwkeCopy = procedure(webView: wkeWebView); cdecl;
  TwkeCut = procedure(webView: wkeWebView); cdecl;
  TwkePaste = procedure(webView: wkeWebView); cdecl;
  TwkeDelete = procedure(webView: wkeWebView); cdecl;

  TwkeSleep = procedure(webView: wkeWebView); cdecl;
  TwkeAwaken = procedure(webView: wkeWebView); cdecl;
  TwkeIsAwake = function(webView: wkeWebView): Boolean; cdecl;
  TwkeDestroyWebView = procedure(webView: wkeWebView); cdecl;

  TwkeSetClientHandler = procedure(webView: wkeWebView;
    const handler: Pointer); cdecl;
  TwkeGetClientHandler = function(webView: wkeWebView): Pointer; cdecl;

  TwkesetUserAgent = procedure(webView: wkeWebView; const ua: Putf8); cdecl;
  TwkesetJavaScriptEnabled = procedure(enable: Boolean); cdecl;
  TwkesetPluginsEnabled = procedure(enable: Boolean); cdecl;
  TwkesetLoadsImagesAutomatically = procedure(enable: Boolean); cdecl;
  TwkesetJavaScriptCanAccessClipboard = procedure(enable: Boolean); cdecl;
  TwkesetLocalStorageEnabled = procedure(enable: Boolean); cdecl;

  TwkeIsTransparent = function(webView: wkeWebView): Boolean; cdecl;
  TwkeSetTransparent = procedure(webView: wkeWebView;
    transparent: Boolean); cdecl;
  TwkeInit = procedure(); cdecl;
  TwkeCreateWebView = function(): wkeWebView; cdecl;
  TwkeDestoryWebView = procedure(webView: wkeWebView); cdecl;
  TwkeResize = procedure(webView: wkeWebView; w, h: integer); cdecl;

  TwkeLoadURL = procedure(webView: wkeWebView; const url: Putf8); cdecl;
  TwkeLoadURLW = procedure(webView: wkeWebView; const url: PWutf8); cdecl;

  TwkeLoadHTML = procedure(webView: wkeWebView; const html: Putf8); cdecl;
  TwkeLoadHTMLW = procedure(webView: wkeWebView; const html: PWutf8); cdecl;

  TwkeLoadFile = procedure(webView: wkeWebView; const filename: Putf8); cdecl;
  TwkeLoadFileW = procedure(webView: wkeWebView; const filename: PWutf8); cdecl;

  TwkeUpdate = procedure(); cdecl;
  TwkeVersionString = function(): Putf8; cdecl;
  TwkeIsLoaded = function(webView: wkeWebView): Boolean; cdecl;
  // = functionwkeIsLoading(webView: wkeWebView):Boolean;cdecl;
  TwkeIsDocumentReady = function(webView: wkeWebView): Boolean; cdecl;
  TwkeIsLoadComplete = function(webView: wkeWebView): Boolean; cdecl;
  TwkeIsLoadFailed = function(webView: wkeWebView): Boolean; cdecl;
  TwkeRunJS = function(webView: wkeWebView; script: Putf8): jsValue; cdecl;
  TwkeRunJSW = function(webView: wkeWebView; script: PWutf8): jsValue; cdecl;
  TwkeContentsWidth = function(webView: wkeWebView): integer; cdecl;
  TwkeContentsHeight = function(webView: wkeWebView): integer; cdecl;
  TwkeWidth = function(webView: wkeWebView): integer; cdecl;
  TwkeHeight = function(webView: wkeWebView): integer; cdecl;
  TwkeTitleW = function(webView: wkeWebView): PWutf8; cdecl;

  TwkePaint = procedure(wkeWebView: wkeWebView; bits: Pointer;
    pitch: integer); cdecl;
  TwkeIsDirty = function(webView: wkeWebView): Boolean; cdecl;
  TwkeSetDirty = procedure(webView: wkeWebView; dirty: Boolean); cdecl;
  TwkeAddDirtyArea = procedure(webView: wkeWebView; x: integer; y: integer;
    w: integer; h: integer); cdecl;
  TwkeLayoutIfNeeded = procedure(webView: wkeWebView); cdecl;

  TwkeFocus = procedure(webView: wkeWebView); cdecl;
  TwkeUnfocus = procedure(webView: wkeWebView); cdecl;

  TwkeMouseEvent = function(webView: wkeWebView; msg: Cardinal; x, y: integer;
    flags: Cardinal): Boolean; cdecl;
  TwkeContextMenuEvent = function(webView: wkeWebView; x, y: integer;
    flags: Cardinal): Boolean; cdecl;
  TwkeMouseWheel = function(webView: wkeWebView; x, y: integer; msg: integer;
    flags: Cardinal): Boolean; cdecl;

  TwkeKeyUp = function(webView: wkeWebView; virtualKeyCode: Cardinal;
    flags: Word; systemKey: Boolean): Boolean; cdecl;
  TwkeKeyDown = function(webView: wkeWebView; virtualKeyCode: Cardinal;
    flags: Word; systemKey: Boolean): Boolean; cdecl;
  TwkeKeyPress = function(webView: wkeWebView; charCode: Cardinal; flags: Word;
    systemKey: Boolean): Boolean; cdecl;

  TwkeGetCaret = function(webView: wkeWebView): wkeRect; cdecl;
  TwkeSetEditable = procedure(webView: wkeWebView; editable: Boolean); cdecl;

  TwkeGlobalExec = function(webView: wkeWebView): jsExecState; cdecl;

  // WKE_API const utf8* wkeToString(const wkeString string);
  // WKE_API const wchar_t* wkeToStringW(const wkeString string);
  TwkeToString = function(const str: wkeString): Putf8; cdecl;
  TwkeToStringW = function(const str: wkeString): PWutf8; cdecl;

  TjsBindFunction = procedure(const name: PAnsiChar; fn: jsNativeFunction;
    argCount: Word); cdecl;
  TjsBindGetter = procedure(const name: PAnsiChar; fn: jsNativeFunction); cdecl;
  TjsBindSetter = procedure(const name: PAnsiChar; fn: jsNativeFunction); cdecl;
  TjsArgCount = function(es: jsExecState): integer; cdecl;
  TjsArgType = function(es: jsExecState; argIdx: integer): jsType; cdecl;
  TjsArg = function(es: jsExecState; argIdx: integer): jsValue; cdecl;

  TjsTypeOf = function(v: jsValue): jsType; cdecl;
  TjsIsNumber = function(v: jsValue): Boolean; cdecl;
  TjsIsString = function(v: jsValue): Boolean; cdecl;
  TjsIsBoolean = function(v: jsValue): Boolean; cdecl;
  TjsIsObject = function(v: jsValue): Boolean; cdecl;
  TjsIsfunction = function(v: jsValue): Boolean; cdecl;
  TjsIsUndefined = function(v: jsValue): Boolean; cdecl;
  TjsIsNull = function(v: jsValue): Boolean; cdecl;
  TjsIsArray = function(v: jsValue): Boolean; cdecl;
  TjsIsTrue = function(v: jsValue): Boolean; cdecl;
  TjsIsFalse = function(v: jsValue): Boolean; cdecl;

  TjsToInt = function(es: jsExecState; v: jsValue): integer; cdecl;
  TjsToFloat = function(es: jsExecState; v: jsValue): Single; cdecl;
  TjsToDouble = function(es: jsExecState; v: jsValue): Double; cdecl;
  TjsToBoolean = function(es: jsExecState; v: jsValue): Boolean; cdecl;
  TjsToString = function(es: jsExecState; v: jsValue): Putf8; cdecl;
  TjsToStringW = function(es: jsExecState; v: jsValue): PWutf8; cdecl;

  TjsInt = function(n: integer): jsValue; cdecl;
  TjsFloat = function(f: Single): jsValue; cdecl;
  TjsDouble = function(d: Double): jsValue; cdecl;
  TjsBoolean = function(b: Boolean): jsValue; cdecl;

  TjsUndefined = function(): jsValue; cdecl;
  TjsNull = function(): jsValue; cdecl;
  TjsTrue = function(): jsValue; cdecl;
  TjsFalse = function(): jsValue; cdecl;

  TjsString = function(es: jsExecState; const str: Putf8): jsValue; cdecl;
  TjsStringW = function(es: jsExecState; const str: PWutf8): jsValue; cdecl;
  Tjsobject = function(es: jsExecState): jsValue; cdecl;
  TjsArray = function(es: jsExecState): jsValue; cdecl;

  TjsFunction = function(es: jsExecState; fn: jsNativeFunction;
    argCount: Cardinal): jsValue; cdecl;

  // return the window object
  TjsGlobalobject = function(es: jsExecState): jsValue; cdecl;

  TjsEval = function(es: jsExecState; const str: Putf8): jsValue; cdecl;
  TjsEvalW = function(es: jsExecState; const str: PWutf8): jsValue; cdecl;

  TjsCall = function(es: jsExecState; func: jsValue; thisjsobject: jsValue;
    args: PjsValue; argCount: integer): jsValue; cdecl;
  TjsCallGlobal = function(es: jsExecState; func: jsValue; args: PjsValue;
    argCount: integer): jsValue; cdecl;

  TjsGet = function(es: jsExecState; jsobject: jsValue; const prop: Putf8)
    : jsValue; cdecl;
  TjsSet = procedure(es: jsExecState; jsobject: jsValue; const prop: Putf8;
    v: jsValue); cdecl;

  TjsGetGlobal = function(es: jsExecState; const prop: Putf8): jsValue; cdecl;
  TjsSetGlobal = procedure(es: jsExecState; const prop: Putf8;
    v: jsValue); cdecl;

  TjsGetAt = function(es: jsExecState; jsobject: jsValue; index: integer)
    : jsValue; cdecl;
  TjsSetAt = procedure(es: jsExecState; jsobject: jsValue; index: integer;
    v: jsValue); cdecl;

  TjsGetLength = function(es: jsExecState; jsobject: jsValue): integer; cdecl;
  TjsSetLength = procedure(es: jsExecState; jsobject: jsValue;
    length: integer); cdecl;

  TjsGetWebView = function(es: jsExecState): wkeWebView; cdecl;

  TjsGC = procedure(); cdecl; // garbage collect

procedure wke_Init();
function wkeGetBitmap(browser: wkeWebView; typ: integer): TBitmap;

var
  // wkeDllHandle: THandle;
  MBT_LEFT: Cardinal = 0;
  MBT_MIDDLE: Cardinal = 1;
  MBT_RIGHT: Cardinal = 2;
  WKE_LBUTTON: Cardinal = $01;
  WKE_RBUTTON: Cardinal = $02;
  WKE_SHIFT: Cardinal = $04;
  WKE_CONTROL: Cardinal = $08;
  WKE_MBUTTON: Cardinal = $10;
  WKE_EXTENDED: Cardinal = $0100;
  WKE_REPEAT: Cardinal = $000;

  wkeSelectAll: TwkeSelectAll;
  wkeCopy: TwkeCopy;
  wkeCut: TwkeCut;
  wkePaste: TwkePaste;
  wkeDelete: TwkeDelete;

  wkeSleep: TwkeSleep;
  wkeAwaken: TwkeAwaken;
  wkeIsAwake: TwkeIsAwake;
  wkeDestroyWebView: TwkeDestroyWebView;

  wkeSetClientHandler: TwkeSetClientHandler;
  wkeGetClientHandler: TwkeGetClientHandler;

  wkesetUserAgent: TwkesetUserAgent;
  wkesetJavaScriptEnabled: TwkesetJavaScriptEnabled;
  wkesetPluginsEnabled: TwkesetPluginsEnabled;
  wkesetLoadsImagesAutomatically: TwkesetLoadsImagesAutomatically;
  wkesetJavaScriptCanAccessClipboard: TwkesetJavaScriptCanAccessClipboard;
  wkesetLocalStorageEnabled: TwkesetLocalStorageEnabled;

  wkeIsTransparent: TwkeIsTransparent;
  wkeSetTransparent: TwkeSetTransparent;
  wkeInit: TwkeInit;
  wkeCreateWebView: TwkeCreateWebView;
  wkeDestoryWebView: TwkeDestoryWebView;
  wkeResize: TwkeResize;

  wkeLoadURL: TwkeLoadURL;
  wkeLoadURLW: TwkeLoadURLW;

  wkeLoadHTML: TwkeLoadHTML;
  wkeLoadHTMLW: TwkeLoadHTMLW;

  wkeLoadFile: TwkeLoadFile;
  wkeLoadFileW: TwkeLoadFileW;

  wkeUpdate: TwkeUpdate;
  wkeVersionString: TwkeVersionString;
  wkeIsLoaded: TwkeIsLoaded;

  wkeIsDocumentReady: TwkeIsDocumentReady;
  wkeIsLoadComplete: TwkeIsLoadComplete;
  wkeIsLoadFailed: TwkeIsLoadFailed;
  wkeRunJS: TwkeRunJS;
  wkeRunJSW: TwkeRunJSW;
  wkeContentsWidth: TwkeContentsWidth;
  wkeContentsHeight: TwkeContentsHeight;
  wkeWidth: TwkeWidth;
  wkeHeight: TwkeHeight;
  wkeTitleW: TwkeTitleW;

  wkePaint: TwkePaint;
  wkeIsDirty: TwkeIsDirty;
  wkeSetDirty: TwkeSetDirty;
  wkeAddDirtyArea: TwkeAddDirtyArea;
  wkeLayoutIfNeeded: TwkeLayoutIfNeeded;

  wkeFocus: TwkeFocus;
  wkeUnfocus: TwkeUnfocus;

  wkeMouseEvent: TwkeMouseEvent;
  wkeContextMenuEvent: TwkeContextMenuEvent;
  wkeMouseWheel: TwkeMouseWheel;

  wkeKeyUp: TwkeKeyUp;
  wkeKeyDown: TwkeKeyDown;
  wkeKeyPress: TwkeKeyPress;

  wkeGetCaret: TwkeGetCaret;
  wkeSetEditable: TwkeSetEditable;

  wkeGlobalExec: TwkeGlobalExec;
  wkeToString: TwkeToString;
  wkeToStringW: TwkeToStringW;

  jsBindFunction: TjsBindFunction;
  jsBindGetter: TjsBindGetter;
  jsBindSetter: TjsBindSetter;
  jsArgCount: TjsArgCount;
  jsArgType: TjsArgType;
  jsArg: TjsArg;

  jsTypeOf: TjsTypeOf;
  jsIsNumber: TjsIsNumber;
  jsIsString: TjsIsString;
  jsIsBoolean: TjsIsBoolean;
  jsIsObject: TjsIsObject;
  jsIsfunction: TjsIsfunction;
  jsIsUndefined: TjsIsUndefined;
  jsIsNull: TjsIsNull;
  jsIsArray: TjsIsArray;
  jsIsTrue: TjsIsTrue;
  jsIsFalse: TjsIsFalse;

  jsToInt: TjsToInt;
  jsToFloat: TjsToFloat;
  jsToDouble: TjsToDouble;
  jsToBoolean: TjsToBoolean;
  jsToString: TjsToString;
  jsToStringW: TjsToStringW;

  jsInt: TjsInt;
  jsFloat: TjsFloat;
  jsDouble: TjsDouble;
  jsBoolean: TjsBoolean;

  jsUndefined: TjsUndefined;
  jsNull: TjsNull;
  jsTrue: TjsTrue;
  jsFalse: TjsFalse;

  jsString: TjsString;
  jsStringW: TjsStringW;
  jsobject: Tjsobject;
  jsArray: TjsArray;

  jsFunction: TjsFunction;

  // return the window object
  jsGlobalobject: TjsGlobalobject;

  jsEval: TjsEval;
  jsEvalW: TjsEvalW;

  jsCall: TjsCall;
  jsCallGlobal: TjsCallGlobal;

  jsGet: TjsGet;
  jsSet: TjsSet;

  jsGetGlobal: TjsGetGlobal;
  jsSetGlobal: TjsSetGlobal;

  jsGetAt: TjsGetAt;
  jsSetAt: TjsSetAt;

  jsGetLength: TjsGetLength;
  jsSetLength: TjsSetLength;

  jsGetWebView: TjsGetWebView;

  jsGC: TjsGC;

  MemDll: TMemoryModule;

  wkeJavaScriptEnabled: Boolean = true;
  wkePluginsEnabled: Boolean = true;
  wkeLoadsImagesAutomatically: Boolean = true;
  wkeJavaScriptCanAccessClipboard: Boolean = true;
  wkeLocalStorageEnabled: Boolean = true;

implementation

procedure LoadRecDll();
var
  RecS: TResourceStream;
  // h: THandle;
begin
  // h := LoadLibrary('UIlib.dll'); { ‘ÿ»Î DLL }
  RecS := TResourceStream.Create(Hinstance, 'LIB', RT_RCDATA); // Hinstance
  RecS.Position := 0;
  MemDll := MemoryLoadLibary(RecS.Memory);
  RecS.Free;
end;

function LoadDllFunc(Funcname: string): Pointer;
begin
  Result := MemoryGetProcAddress(MemDll, PAnsiChar(AnsiString(Funcname)));
end;

procedure wke_Init();
begin
  Set8087CW(Get8087CW or $3F);
  LoadRecDll();

  wkeSelectAll := LoadDllFunc('wkeSelectAll');
  wkeCopy := LoadDllFunc('wkeCopy');
  wkeCut := LoadDllFunc('wkeCut');
  wkePaste := LoadDllFunc('wkePaste');
  wkeDelete := LoadDllFunc('wkeDelete');

  wkeSleep := LoadDllFunc('wkeSleep');
  wkeAwaken := LoadDllFunc('wkeAwaken');
  wkeIsAwake := LoadDllFunc('wkeIsAwake');
  wkeDestroyWebView := LoadDllFunc('wkeDestroyWebView');

  wkesetUserAgent := LoadDllFunc('wkesetUserAgent');
  wkesetJavaScriptEnabled := LoadDllFunc('wkesetJavaScriptEnabled');
  wkesetPluginsEnabled := LoadDllFunc('wkesetPluginsEnabled');
  wkesetLoadsImagesAutomatically :=
    LoadDllFunc('wkesetLoadsImagesAutomatically');
  wkesetJavaScriptCanAccessClipboard :=
    LoadDllFunc('wkesetJavaScriptCanAccessClipboard');
  wkesetLocalStorageEnabled := LoadDllFunc('wkesetLocalStorageEnabled');

  wkeSetClientHandler := LoadDllFunc('wkeSetClientHandler');
  wkeGetClientHandler := LoadDllFunc('wkeGetClientHandler');

  wkeIsTransparent := LoadDllFunc('wkeIsTransparent');
  wkeSetTransparent := LoadDllFunc('wkeSetTransparent');
  wkeInit := LoadDllFunc('wkeInit');
  wkeCreateWebView := LoadDllFunc('wkeCreateWebView');
  wkeDestoryWebView := LoadDllFunc('wkeDestoryWebView');
  wkeResize := LoadDllFunc('wkeResize');

  wkeLoadURL := LoadDllFunc('wkeLoadURL');
  wkeLoadURLW := LoadDllFunc('wkeLoadURLW');
  wkeLoadHTML := LoadDllFunc('wkeLoadHTML');
  wkeLoadHTMLW := LoadDllFunc('wkeLoadHTMLW');
  wkeLoadFile := LoadDllFunc('wkeLoadFile');
  wkeLoadFileW := LoadDllFunc('wkeLoadFileW');

  wkeUpdate := LoadDllFunc('wkeUpdate');
  wkeVersionString := LoadDllFunc('wkeVersionString');
  wkeIsLoaded := LoadDllFunc('wkeIsLoaded');

  wkeIsDocumentReady := LoadDllFunc('wkeIsDocumentReady');
  wkeIsLoadComplete := LoadDllFunc('wkeIsLoadComplete');
  wkeIsLoadFailed := LoadDllFunc('wkeIsLoadFailed');
  wkeRunJS := LoadDllFunc('wkeRunJS');
  wkeRunJSW := LoadDllFunc('wkeRunJSW');
  wkeContentsWidth := LoadDllFunc('wkeContentsWidth');
  wkeContentsHeight := LoadDllFunc('wkeContentsHeight');
  wkeWidth := LoadDllFunc('wkeWidth');
  wkeHeight := LoadDllFunc('wkeHeight');
  wkeTitleW := LoadDllFunc('wkeTitleW');

  wkePaint := LoadDllFunc('wkePaint');
  wkeIsDirty := LoadDllFunc('wkeIsDirty');
  wkeSetDirty := LoadDllFunc('wkeSetDirty');
  wkeAddDirtyArea := LoadDllFunc('wkeAddDirtyArea');
  wkeLayoutIfNeeded := LoadDllFunc('wkeLayoutIfNeeded');

  wkeFocus := LoadDllFunc('wkeFocus');
  wkeUnfocus := LoadDllFunc('wkeUnfocus');

  wkeMouseEvent := LoadDllFunc('wkeMouseEvent');
  wkeContextMenuEvent := LoadDllFunc('wkeContextMenuEvent');
  wkeMouseWheel := LoadDllFunc('wkeMouseWheel');

  wkeKeyUp := LoadDllFunc('wkeKeyUp');
  wkeKeyDown := LoadDllFunc('wkeKeyDown');
  wkeKeyPress := LoadDllFunc('wkeKeyPress');

  wkeGetCaret := LoadDllFunc('wkeGetCaret');
  wkeSetEditable := LoadDllFunc('wkeSetEditable');

  wkeGlobalExec := LoadDllFunc('wkeGlobalExec');
  wkeToString := LoadDllFunc('wkeToString');
  wkeToStringW := LoadDllFunc('wkeToStringW');

  jsBindFunction := LoadDllFunc('jsBindFunction');
  jsBindGetter := LoadDllFunc('jsBindGetter');
  jsBindSetter := LoadDllFunc('jsBindSetter');
  jsArgCount := LoadDllFunc('jsArgCount');
  jsArgType := LoadDllFunc('jsArgType');
  jsArg := LoadDllFunc('jsArg');

  jsTypeOf := LoadDllFunc('jsTypeOf');
  jsIsNumber := LoadDllFunc('jsIsNumber');
  jsIsString := LoadDllFunc('jsIsString');
  jsIsBoolean := LoadDllFunc('jsIsBoolean');
  jsIsObject := LoadDllFunc('jsIsObject');
  jsIsfunction := LoadDllFunc('jsIsfunction');
  jsIsUndefined := LoadDllFunc('jsIsUndefined');
  jsIsNull := LoadDllFunc('jsIsNull');
  jsIsArray := LoadDllFunc('jsIsArray');
  jsIsTrue := LoadDllFunc('jsIsTrue');
  jsIsFalse := LoadDllFunc('jsIsFalse');

  jsToInt := LoadDllFunc('jsToInt');
  jsToFloat := LoadDllFunc('jsToFloat');
  jsToDouble := LoadDllFunc('jsToDouble');
  jsToBoolean := LoadDllFunc('jsToBoolean');
  jsToString := LoadDllFunc('jsToString');
  jsToStringW := LoadDllFunc('jsToStringW');

  jsInt := LoadDllFunc('jsInt');
  jsFloat := LoadDllFunc('jsFloat');
  jsDouble := LoadDllFunc('jsDouble');
  jsBoolean := LoadDllFunc('jsBoolean');

  jsUndefined := LoadDllFunc('jsUndefined');
  jsNull := LoadDllFunc('jsNull');
  jsTrue := LoadDllFunc('jsTrue');
  jsFalse := LoadDllFunc('jsFalse');

  jsString := LoadDllFunc('jsString');
  jsStringW := LoadDllFunc('jsStringW');
  jsobject := LoadDllFunc('jsobject');
  jsArray := LoadDllFunc('jsArray');

  jsFunction := LoadDllFunc('jsFunction');

  // return the window object
  jsGlobalobject := LoadDllFunc('jsGlobalobject');

  jsEval := LoadDllFunc('jsEval');
  jsEvalW := LoadDllFunc('jsEvalW');

  jsCall := LoadDllFunc('jsCall');
  jsCallGlobal := LoadDllFunc('jsCallGlobal');

  jsGet := LoadDllFunc('jsGet');
  jsSet := LoadDllFunc('jsSet');

  jsGetGlobal := LoadDllFunc('jsGetGlobal');
  jsSetGlobal := LoadDllFunc('jsSetGlobal');

  jsGetAt := LoadDllFunc('jsGetAt');
  jsSetAt := LoadDllFunc('jsSetAt');

  jsGetLength := LoadDllFunc('jsGetLength');
  jsSetLength := LoadDllFunc('jsSetLength');

  jsGetWebView := LoadDllFunc('jsGetWebView');

  jsGC := LoadDllFunc('jsGC');

  wkesetJavaScriptEnabled(wkeJavaScriptEnabled);
  wkesetPluginsEnabled(wkePluginsEnabled);
  wkesetLoadsImagesAutomatically(wkeLoadsImagesAutomatically);
  wkesetJavaScriptCanAccessClipboard(wkeJavaScriptCanAccessClipboard);
  wkesetLocalStorageEnabled(wkeLocalStorageEnabled);
  wkeInit();
end;

function wkeGetBitmap(browser: wkeWebView; typ: integer): TBitmap;
var
  w, h, i: integer;
  p, s: Pointer;
  Bitmap: TBitmap;
begin
  h := wkeHeight(browser);
  w := wkeWidth(browser);
  { if((wkeW<>w) or (wkeH<>h)) then
    begin
    wkeW:=w;
    wkeH:=h;
    wkeResize(browser, w, h);
    end; }
  // wkeResize(browser, w, h);
  // h:=wkeContentsHeight(browser);
  // w:=wkeContentsWidth(browser);
  Bitmap := TBitmap.Create;
  Bitmap.PixelFormat := pf32bit;
  Bitmap.Width := w;
  Bitmap.Height := h-1;
  GetMem(p, h * w * 4);
  try
    // browser.GetImage(typ, w, h, p);
    wkePaint(browser, p, typ);
    s := p;
    Inc(integer(s), w * 4);
    for i := 0 to h - 2 do
    begin
      Move(s^, Bitmap.ScanLine[i]^, w * 4);
      Inc(integer(s), w * 4);
    end;
    Result := Bitmap;
  finally
    FreeMem(p);
  end;
end;

end.
