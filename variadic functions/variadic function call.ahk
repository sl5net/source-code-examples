; discussion: https://autohotkey.com/boards/viewtopic.php?f=5&t=45239&p=204700#p204700 
; 07.03.2018 19:15
; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
#Include *i %A_ScriptDir%\inc_ahk\init_global.init.inc.ahk

global g_msg := ""

params := { x:1, y:2 } ; works
if(1){
  func1_by_reference( &params ) ; works
  func1_by_reference(&{ y:2, x:1 }*)  ; works
  ;func1_by_value( params ) ; works
  ;func1_by_value({ y:2, x:1 })  ; works
}

if(0){
  func1_by_value_PRE( params ) ; works
  func1_by_value_PRE( params* ) ; works
  func1_by_value_PRE({ y:3, x:4 }*)  ; works
  func1_by_value_PRE( 5 )  ; works
  func1_by_value_PRE( 6, 7 )  ; works
}
;MsgBox,, ,% (& params) " = address", 3 ; with timeout
; func1_by_ref_PRE( & params ) ; & params get the address

;MsgBox,, g_msg, % g_msg , 3 ; with timeout

func1_by_ref_PRE(x, y=""){
  MsgBox,, ,% x " = address", 3 ; with timeout
  MsgBox,, ,% Object(x)["x"] " = value", 3 ; with timeout
  callerFunc := A_ThisFunc
  func1_by_value( Object(x) , callerFunc  )
}
func1_by_value_PRE(x, y=""){
  callerFunc := A_ThisFunc
  if(!IsObject(x))
    x := { y:y, x:x }
  func1_by_value( x , callerFunc  )
}
func1_by_value(args, callerFunc ){
  acceptedFunc := "func1_by_value_PRE"
  if( callerFunc  <> acceptedFunc ){
    msg := "please call this " A_ThisFunc " only from " acceptedFunc " (callerFunc=" callerFunc ")"
    ToolTip, % msg 
    MsgBox,, ERROR, %msg% `n (%A_ScriptName%~%A_LineNumber%)  , 1 ; with timeout
    ;return
  }
  g_msg .= args["x"]
  g_msg .= args["y"] ","
}


func2(3,4)  ; works
func2({ y:2, x:5 })  ; works
MsgBox,, g_msg, % g_msg , 3 ; with timeout
ToolTip,


func2(x, y=""){
  ;x["callerFunc"] := A_ThisFunc ; not work
  ;ObjRawSet(x*, "callerFunc", A_ThisFunc) ; not work
  ;ObjRawSet(x, "callerFunc", A_ThisFunc) ; not work
  ;x.Insert("callerFunc", A_ThisFunc) ; not work
  ;x.Insert("callerFunc", A_ThisFunc) ; not work
  ; x.Insert({"callerFunc": A_ThisFunc}) ; not work
  ;x.Push({"callerFunc": A_ThisFunc}) ; not work
  x .= {"callerFunc": A_ThisFunc} ; not work
  MsgBox, % x["callerFunc"] " = callerFunc, A_ThisFunc = " A_ThisFunc
  ExitApp
  if(!y)
    func1_by_reference(& x )
  else
    func1_by_reference(& { y:y, x:x })
}

func1_by_reference( args ){ ; The "variadic" parameter can only appear at the end of the formal parameter list.
  acceptedFunc := "func2"
  if( !Object(args)["callerFunc"] || Object(args)["callerFunc"] <> acceptedFunc ){
    msg := "please call this " A_ThisFunc " only from " acceptedFunc " (callerFunc=" Object(args)["callerFunc"] ")"
    ToolTip, % msg 
    MsgBox,, ERROR, % msg , 2 ; with timeout
    ;return
  }
  g_msg .=  Object(args)["x"]
  g_msg .= Object(args)["y"] ","
}




; some interesting discussion: https://autohotkey.com/boards/viewtopic.php?t=191

#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;#Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise m�sen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#Include *i %A_ScriptDir%\inc_ahk\UPDATEDSCRIPT_global.inc.ahk
