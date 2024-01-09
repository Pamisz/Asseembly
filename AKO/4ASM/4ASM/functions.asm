.686
.model flat
public _szukaj4_max 

.code
_szukaj4_max  PROC
	push ebp ; zapisanie zawartoœci EBP na stosie
	mov ebp, esp ; kopiowanie zawartoœci ESP do EBP

	mov eax, [ebp+8] ; liczba a
	cmp eax, [ebp+12] ; porownanie liczb a i b
	jge a_greater ; skok, gdy a >= b

	; przypadek a < b
	mov eax, [ebp+12] ; ustawienie b jako max
	cmp eax, [ebp+16] ; porownanie liczb b i c
	jl c_greater	  ;jezeli b < c skocz do c_greater
	cmp eax, [ebp+20] ;porownanie b i d
	jl enter_d		  ;jezeli b < d skocz do enter_d
	jmp finish		  ; b to max

	;d to max
	enter_d: 
	mov eax, [ebp+20] 
	
	finish:
	pop ebp
	ret

	a_greater:
	cmp eax, [ebp+16] ; porownanie a i c
	jl c_greater      ; skok, gdy a < c
	cmp eax, [ebp+20] ; porownanie a i d
	jl enter_d		  ; jezeli a < d skocz do enter_d
	jmp finish		  ; a to max
	
	c_greater:
	mov eax, [ebp+16] ; ustawienie c jako max
	cmp eax, [ebp+20] ; porownanie c i d
	jl enter_d		  ; jezeli c < d skocz do enter_d
	jmp finish		  ; c to max

_szukaj4_max  ENDP 
END
