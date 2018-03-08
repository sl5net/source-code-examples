;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; variadic function call.ahk
; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
; https://autohotkey.com/boards/viewtopic.php?f=5&t=45239&p=204592#p204592
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

global g_msg := ""

params := { x:1, y:2 } ; works
func1_by_reference( params* ) ; works
func1_by_reference({ y:2, x:1 }*)  ; works
func1_by_value( params ) ; works
func1_by_value({ y:2, x:1 })  ; works

func2(3,4)  ; works
func2({ y:2, x:5 })  ; works
MsgBox,, % g_msg ,, 3 ; with timeout


func2(x, y=""){
  if(!y)
    func1_by_reference( x*, A_ThisFunc )
  else
    func1_by_reference({ y:y, x:x }*, A_ThisFunc)  
}

func1_by_reference(args*, callerFunc ){
acceptedFunc := "func2"
  if( callerFunc <> acceptedFunc ){
    msg := "please never call this " A_ThisFunc " directly next time ;) . please use " acceptedFunc
    ToolTip, % msg 
    ;MsgBox,, % msg ,, 1 ; with timeout
    ;return
  }
  g_msg .= args["x"]
  g_msg .= args["y"] ","
}
func1_by_value(args){
  g_msg := args["x"]
  g_msg .= args["y"] ","
}

