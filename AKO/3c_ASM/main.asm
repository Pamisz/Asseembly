.686
.model flat

extern __write :PROC
extern __read :PROC
extern _ExitProcess@4 :PROC

.data
	obszar db 12 dup (?)
	dziesiec dd 10 
	znaki db 12 dup (?)


.code

wczytaj_do_EAX PROC
	push ebx
	push ecx
	push edx
	push edi
	push esi
	push ebp
	
	push dword PTR 12
	push dword PTR OFFSET obszar 
	push dword PTR 0
	call __read 
	add esp,12

	mov eax, 0
	mov ebx, OFFSET obszar 
	pobieraj_znaki:
		mov cl, [ebx] 
		inc ebx 
		cmp cl,10 
		je byl_enter 
		sub cl, 30H 
		movzx ecx, cl 
		mul dword PTR dziesiec
		add eax, ecx 
	jmp pobieraj_znaki 
	byl_enter:
	
	pop ebp
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx

	ret
wczytaj_do_EAX ENDP

wyswietl_EAX PROC
	pusha

	mov esi, 10 
	mov ebx, 10 
	konwersja:
		mov edx, 0 
		div ebx 
		add dl, 30H 
		mov znaki [esi], dl
		dec esi 
		cmp eax, 0 
	jne konwersja 
	 
; wype³nienie pozosta³ych bajtów spacjami i wpisanie
; znaków nowego wiersza
	;wypeln:
	;	or esi, esi
	;	jz wyswietl ; skok, gdy ESI = 0
	;	mov byte PTR znaki [esi], 20H ; kod spacji
	;	dec esi ; zmniejszenie indeksu
	;jmp wypeln

	wyswietl:
		;mov byte PTR znaki [0], 0AH ; kod nowego wiersza
		;mov byte PTR znaki [11], 0AH ; kod nowego wiersza

		; wyœwietlenie cyfr na ekranie
		push dword PTR 12 
		push dword PTR OFFSET znaki 
		push dword PTR 1
		call __write 
		add esp, 12 

	popa
	ret
wyswietl_EAX ENDP

_main PROC
	call wczytaj_do_EAX
	mov ecx,eax
	mul eax
	call wyswietl_EAX

	push 0
	call _ExitProcess@4
_main ENDP
END