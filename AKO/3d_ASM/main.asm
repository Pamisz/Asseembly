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

wyswietl_EAX_hex PROC
	; wyœwietlanie zawartoœci rejestru EAX
	; w postaci liczby szesnastkowej
	pusha ; przechowanie rejestrów

	; rezerwacja 12 bajtów na stosie (poprzez zmniejszenie
	; rejestru ESP) przeznaczonych na tymczasowe przechowanie
	; cyfr szesnastkowych wyœwietlanej liczby
	sub esp, 12
	mov edi, esp ; adres zarezerwowanego obszaru pamiêci

	; przygotowanie konwersji
	mov ecx, 8 ; liczba obiegów pêtli konwersji
	mov esi, 1 ; indeks pocz¹tkowy u¿ywany przy zapisie cyfr

	; pêtla konwersji
	ptl3hex:
		; przesuniêcie cykliczne (obrót) rejestru EAX o 4 bity w lewo
		; w szczególnoœci, w pierwszym obiegu pêtli bity nr 31 - 28
		; rejestru EAX zostan¹ przesuniête na pozycje 3 - 0
		rol eax, 4

		; wyodrêbnienie 4 najm³odszych bitów i odczytanie z tablicy
		; 'dekoder' odpowiadaj¹cej im cyfry w zapisie szesnastkowym
		mov ebx, eax ; kopiowanie EAX do EBX
		and ebx, 0000000FH ; zerowanie bitów 31 - 4 rej.EBX
		mov dl, dekoder[ebx] ; pobranie cyfry z tablicy
		; przes³anie cyfry do obszaru roboczego
		mov [edi][esi], dl
		inc esi ;inkrementacja modyfikatora
	loop ptl3hex ; sterowanie pêtl¹

	; wpisanie znaku nowego wiersza przed i po cyfrach
	mov byte PTR [edi][0], 10
	mov byte PTR [edi][9], 10


	
	mov esi,1
	letzgo:
		cmp byte PTR [edi][esi], 30h
		jne skip
		mov byte PTR [edi][esi],20h
		inc esi
	jmp letzgo
	skip:

	; wyœwietlenie przygotowanych cyfr
	push 10 ; 8 cyfr + 2 znaki nowego wiersza
	push edi ; adres obszaru roboczego
	push 1 ; nr urz¹dzenia (tu: ekran)
	call __write ; wyœwietlenie

	; usuniêcie ze stosu 24 bajtów, w tym 12 bajtów zapisanych
	; przez 3 rozkazy push przed rozkazem call
	; i 12 bajtów zarezerwowanych na pocz¹tku podprogramu
	add esp, 24

	popa ; odtworzenie rejestrów
	ret ; powrót z podprogramu
wyswietl_EAX_hex ENDP

_main PROC
	call wczytaj_do_EAX
	
	call wyswietl_EAX_hex

	push 0
	call _ExitProcess@4
_main ENDP
END