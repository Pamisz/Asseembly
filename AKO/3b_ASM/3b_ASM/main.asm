.686
.model flat

extern __read :PROC
extern _ExitProcess@4 :PROC

; wczytywanie liczby dziesiêtnej z klawiatury – po
;wprowadzeniu cyfr nale¿y nacisn¹æ klawisz Enter
; liczba po konwersji na postaæ binarn¹ zostaje wpisana
; do rejestru EAX

.data
	obszar db 12 dup (?)
	dziesiec dd 10 

; obszar instrukcji (rozkazów) programu
.code

wczytaj_do_EAX PROC
	push ebx
	push ecx
	push edx
	push edi
	push esi
	push ebp
	
	; max iloœæ znaków wczytywanej liczby
	push dword PTR 12
	push dword PTR OFFSET obszar ; adres obszaru pamiêci
	push dword PTR 0; numer urz¹dzenia (0 dla klawiatury)
	call __read ; odczytywanie znaków z klawiatury
	add esp,12

	; bie¿¹ca wartoœæ przekszta³canej liczby przechowywana jest
	; w rejestrze EAX; przyjmujemy 0 jako wartoœæ pocz¹tkow¹
	mov eax, 0
	mov ebx, OFFSET obszar ; adres obszaru ze znakami
	pobieraj_znaki:
		mov cl, [ebx] ; pobranie kolejnej cyfry w kodzie ASCII
		inc ebx ; zwiêkszenie indeksu
		cmp cl,10 ; sprawdzenie czy naciœniêto Enter
		je byl_enter ; skok, gdy naciœniêto Enter
		sub cl, 30H ; zamiana kodu ASCII na wartoœæ cyfry
		movzx ecx, cl ; przechowanie wartoœci cyfry w rejestrze ECX
		; mno¿enie wczeœniej obliczonej wartoœci razy 10
		mul dword PTR dziesiec
		add eax, ecx ; dodanie ostatnio odczytanej cyfry
	jmp pobieraj_znaki ; skok na pocz¹tek pêtli
	byl_enter:
	; wartoœæ binarna wprowadzonej liczby znajduje siê teraz w rejestrze EAX

	pop ebp
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx

	ret
wczytaj_do_EAX ENDP

_main PROC
	call wczytaj_do_EAX

	push 0
	call _ExitProcess@4
_main ENDP
END