.686
.model flat
public _odejmij_jeden

.code
_odejmij_jeden PROC
	push ebp ; zapisanie zawarto�ci EBP na stosie
	mov ebp,esp ; kopiowanie zawarto�ci ESP do EBP
	push ebx ; przechowanie zawarto�ci rejestru EBX

	mov ebx, [ebp+8] ; w ebx jest teraz adres wska�nika
	mov eax, [ebx] ; odczytanie warto�ci wska�nika
	mov ecx, [eax] ; odczytanie warto�ci
	dec ecx ; minus 1
	mov [eax], ecx ; odes�anie wyniku do zmiennej

	pop ebx
	pop ebp
	ret
_odejmij_jeden ENDP
 END