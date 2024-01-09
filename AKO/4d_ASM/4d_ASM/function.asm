.686
.model flat
public _przestaw

.code
_przestaw PROC
	push ebp ; zapisanie zawarto�ci EBP na stosie
	mov ebp,esp ; kopiowanie zawarto�ci ESP do EBP
	push ebx ; przechowanie zawarto�ci rejestru EBX

	mov ebx, [ebp+8] ; adres tablicy tabl
	mov ecx, [ebp+12] ; liczba element�w tablicy
	dec ecx

	cmp ecx, 1 ; sprawdzanie czy nie ma przypadkiem 1 (lub mniej) element�w
	jle koniec

	
	ptl: 
		mov eax, [ebx]	    ; wpisanie kolejnego elementu tablicy do rejestru EAX
		cmp eax, [ebx+4]	; por�wnanie elementu tablicy wpisanego do EAX z nast�pnym
		jle gotowe			; skok, gdy nie ma przestawiania

		; zamiana s�siednich element�w tablicy
		mov edx, [ebx+4]
		mov [ebx], edx
		mov [ebx+4], eax

		gotowe:
			add ebx, 4 ; wyznaczenie adresu kolejnego elementu
	loop ptl ; organizacja p�tli

	koniec:
	pop ebx ; odtworzenie zawarto�ci rejestr�w
	pop ebp
	ret ; powr�t do programu g��wnego
_przestaw ENDP
 END