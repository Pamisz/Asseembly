.686
.model flat

extern __write :PROC
extern __read :PROC
extern _ExitProcess@4 :PROC

.data
	obszar db 12 dup (?)
	dziesiec dd 10 
	znaki db 12 dup (?)
	dekoder db '0123456789ABCDEF'



.code

wczytaj_do_EAX_hex PROC
	; wczytywanie liczby szesnastkowej z klawiatury – liczba po
	; konwersji na postaæ binarn¹ zostaje wpisana do rejestru EAX
	; po wprowadzeniu ostatniej cyfry nale¿y nacisn¹æ klawisz
	; Enter
	push ebx
	push ecx
	push edx
	push esi
	push edi
	push ebp

	; rezerwacja 12 bajtów na stosie przeznaczonych na tymczasowe
	; przechowanie cyfr szesnastkowych wyœwietlanej liczby
	sub esp, 12 ; rezerwacja poprzez zmniejszenie ESP
	mov esi, esp ; adres zarezerwowanego obszaru pamiêci
	push dword PTR 10 ; max iloœæ znaków wczytyw. liczby
	push esi ; adres obszaru pamiêci
	push dword PTR 0; numer urz¹dzenia (0 dla klawiatury)
	call __read ; odczytywanie znaków z klawiatury
	add esp, 12 ; usuniêcie parametrów ze stosu

	mov eax, 0 ; dotychczas uzyskany wynik
	pocz_konw:
		mov dl, [esi] ; pobranie kolejnego bajtu
		inc esi ; inkrementacja indeksu
		cmp dl, 10 ; sprawdzenie czy naciœniêto Enter
		je gotowe ; skok do koñca podprogramu
		; sprawdzenie czy wprowadzony znak jest cyfr¹ 0, 1, 2 , ..., 9
		cmp dl, '0'
	jb pocz_konw ; inny znak jest ignorowany

	cmp dl, '9'
	ja sprawdzaj_dalej
	sub dl, '0' ; zamiana kodu ASCII na wartoœæ cyfry
	dopisz:
		shl eax, 4 ; przesuniêcie logiczne w lewo o 4 bity
		or al, dl ; dopisanie utworzonego kodu 4-bitowego na 4 ostatnie bity rejestru EAX
		jmp pocz_konw ; skok na pocz¹tek pêtli konwersji

	; sprawdzenie czy wprowadzony znak jest cyfr¹ A, B, ..., F
	sprawdzaj_dalej:
		cmp dl, 'A'
		jb pocz_konw ; inny znak jest ignorowany
		cmp dl, 'F'
		ja sprawdzaj_dalej2
		sub dl, 'A' - 10 ; wyznaczenie kodu binarnego
		jmp dopisz

		; sprawdzenie czy wprowadzony znak jest cyfr¹ a, b, ..., f
	sprawdzaj_dalej2:
		cmp dl, 'a'
		jb pocz_konw ; inny znak jest ignorowany
		cmp dl, 'f'
		ja pocz_konw ; inny znak jest ignorowany
		sub dl, 'a' - 10
		jmp dopisz

	gotowe:
	; zwolnienie zarezerwowanego obszaru pamiêci
	add esp, 12
	pop ebp
	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	ret
wczytaj_do_EAX_hex ENDP

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
	call wczytaj_do_EAX_hex
	
	call wyswietl_EAX

	push 0
	call _ExitProcess@4
_main ENDP
END