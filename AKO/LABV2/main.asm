.686
.model flat 
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __read : PROC 

public _main
.data

myTitle dw 'L', 'a', 'b', '2', ' ', 'z', 'a', 'd', 'a', 'n', 'i', 'e', 0

bufer db 80 dup (?)
chars_numb dd ?
word_number db 0
index db 0
frog dw '>','1', ' ', 0D83Dh, 0DC38h, 0

.code 
_main PROC

;INPUT
 push 80 
 push OFFSET bufer
 push 0 
 call __read 

 ;CLEAR 
 add esp,12

 mov chars_numb, eax ; moving number of chars to chars_numb
 mov ecx, eax		; moving number of chars to ecx
 mov ebx, 0			; index of loop

 mov ah, 0			; max number of polish chars
 mov al, 0			; index of max word

 ptl: mov dl, bufer[ebx]
	
	cmp dl, 20h ; isSpace
	jne is0A4h
	
	cmp word_number, ah
	jbe changes
	mov ah, word_number
	mov al, index

	changes:
	mov word_number, 0
	inc index

	is0A4h:
	cmp dl, 0A4h ;is •
	jne is8Fh
	inc word_number

	is8Fh:
	cmp dl, 8Fh ;is ∆
	jne is0A8h
	inc word_number

	is0A8h:
	cmp dl, 0A8h ;is  
	jne is9Dh
	inc word_number

	is9Dh:
	cmp dl, 9Dh ;is £
	jne is0E3h
	inc word_number

	is0E3h:
	cmp dl, 0A8h ;is —
	jne is0E0h
	inc word_number

	is0E0h:
	cmp dl, 0E0h ;is ”
	jne is97h
	inc word_number

	is97h:
	cmp dl, 97h ;is å
	jne is8Dh
	inc word_number

	is8Dh:
	cmp dl, 8Dh ;is è
	jne is0BDh
	inc word_number

	is0BDh:
	cmp dl, 0BDh ;is  
	jne dalej
	inc word_number

 dalej: inc ebx 
 dec ecx
 jnz ptl

 ;if the last word is the one 
 cmp word_number, ah
 jbe theEnd
 mov ah, word_number
 mov al, index


 theEnd:
 add al, 30h			;ASCII 
 mov ah, 0h
 mov frog[2], ax

 push 0
 push OFFSET myTitle
 push OFFSET frog
 push 0
 call _MessageBoxW@16

 push 0 
 call _ExitProcess@4
_main ENDP
END

;frog - 0D83Dh, 0DC38h




