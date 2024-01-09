.686
.model flat
public _odejmij_jeden

.code
_odejmij_jeden PROC
	push ebp ; zapisanie zawartoúci EBP na stosie
	mov ebp,esp ; kopiowanie zawartoúci ESP do EBP
	push ebx ; przechowanie zawartoúci rejestru EBX

	mov ebx, [ebp+8] ; w ebx jest teraz adres wskaünika
	mov eax, [ebx] ; odczytanie wartoúci wskaünika
	mov ecx, [eax] ; odczytanie wartoúci
	dec ecx ; minus 1
	mov [eax], ecx ; odes≥anie wyniku do zmiennej

	pop ebx
	pop ebp
	ret
_odejmij_jeden ENDP
 END