.686
.model flat

extern _ExitProcess@4 : PROC
extern __write : PROC

public _main
.data
bufer db 'browar'
kunic db 0

.code
_main PROC
cmp bufer, 'a'
 jb dalej ; skok, gdy znak nie wymaga zamiany
 cmp bufer, 'z'
 ja dalej ; skok, gdy znak nie wymaga zamiany
 sub bufer, 20H ; zamiana na wielkie litery
 dalej:

 push kunic - bufer
 push OFFSET bufer 
 push 1
 call __write

 push 0  
 call _ExitProcess@4
_main ENDP
END

