.686
.model flat
public _plus_jeden
.code
_plus_jeden PROC
	push ebp ; zapisanie zawartoœci EBP na stosie
	mov ebp,esp ; kopiowanie zawartoœci ESP do EBP
	push ebx ; przechowanie zawartoœci rejestru EBX

	; wpisanie do rejestru EBX adresu zmiennej zdefiniowanej
	; w kodzie w jêzyku C
	mov ebx, [ebp+8]
	neg dword PTR [ebx] ; negacja zmiennej

	pop ebx
	pop ebp
	ret
_plus_jeden ENDP
 END