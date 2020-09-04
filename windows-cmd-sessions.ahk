; Ok I want a "command line session" type thing - not sure if this exists but  I Guess i'll have a go at trying it myself, I can use Autohotkey to control c (copy) the command line text, but then pasting it, you can't just paste stuff into the command line cause commands are executed when there is a new line , so AHK will save the contents of the clipboard to a file "my-cmd-session-1.txt" etc, then a Batch will script (windows only) will echo the contents of my-cmd-session-1.txt in the currently opened command line window (so far I'm only thinking about the typical DOS prompt, not powershell, Git Shell etc ) 


; assumes CMD is window is currently opened active window & is full screen 
MsgBox, Windows CMD Sessions is running.... 
!^s:: ; ctrl alt s (save session) 
    InputBox, sessionFile, Save session ; may use FileSelect 
    Click, 100, 100 
    Send, ^a ; simulate Ctrl+C (=selection in clipboard)
    tmp = %ClipboardAll% ; save clipboard
    Clipboard := "" ; clear clipboard
    Send, ^c ; simulate Ctrl+C (=selection in clipboard)
    ClipWait, 0, 1 ; wait until clipboard contains data
    sessionText = %Clipboard% ; save the content of the clipboard
    FileDelete, C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\windows-cmd-sessions\sessions\%sessionFile%.tx
    file := FileOpen("C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\windows-cmd-sessions\sessions\" . sessionFile . ".txt","w")
    file.write(sessionText)
    Clipboard = %tmp% ; restore old content of the clipboard 
    MsgBox, session saved %sessionFile%
    return 

!^o:: ; ctrl alt o (open session) 
    InputBox, sessionFile, Open session ; may use FileSelect 
    Click, 100, 100 
    Send, type C:\Users\user\webapps\maybe-not-a-webapp-autoit-script\windows-cmd-sessions\sessions\%sessionFile%.txt
    Send, {Enter}
    MsgBox, you may now cd into your session :) 

; https://stackoverflow.com/a/3534392 
; https://superuser.com/questions/162713/how-can-i-print-a-textfile-on-the-command-prompt-in-windows 
