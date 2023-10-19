.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern _MessageBoxA@16 : PROC
extern __read : PROC 

public _main
.data

title_Uni dw 'U', 'T', 'F', '-' ,'1', '6', 0
title_Win db 'Windows1250', 0

tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
magazynek dw 80 dup (?)
nowa_linia db 10
liczba_znakow dd ?

.code
_main PROC

mov ecx,(OFFSET koniec_t) - (OFFSET tekst_pocz)
 push ecx
 push OFFSET tekst_pocz 
 push 1 

 add esp, 12 ; usuniecie parametrów ze stosu

; czytanie wiersza z klawiatury
 push 80 
 push OFFSET magazyn
 push 0 
 call __read 

 add esp, 12 

 mov liczba_znakow, eax

; rejestr ECX pe³ni rolê licznika obiegów pêtli
 mov ecx, eax
 mov ebx, 0 

 ptl: mov dl, magazyn[ebx] 
 cmp dl, 0A5h ; czy ¹
 jne czy_A9h ;skok, gdy znak jest inny
 mov magazyn[ebx], 0A5h
 mov magazynek[ebx*2], 0104h

 czy_A9h:
 cmp dl, 0A9h ; czy ê
 jne czy_E4h ;skok, gdy znak jest inny
 mov magazyn[ebx], 0CAh
 mov magazynek[ebx*2], 0118H

 czy_E4h:
 cmp dl, 0E4h ; czy ñ
 jne czy_98h ;skok, gdy znak jest inny
 mov magazyn[ebx], 0D1h
 mov magazynek[ebx*2], 0143H

 czy_98h:
 cmp dl, 98h ; czy œ
 jne czy_BEh ;skok, gdy znak jest inny 
 mov magazyn[ebx], 8Ch
 mov magazynek[ebx*2], 015AH

 czy_BEh:
 cmp dl, 0BEh ; czy ¿
 jne czy_86h ;skok, gdy znak jest inny 
 mov magazyn[ebx], 0AFh
 mov magazynek[ebx*2], 017BH

 czy_86h:
 cmp dl, 86h ; czy æ
 jne czy_88h ;skok, gdy znak jest inny 
 mov magazyn[ebx], 0C6h
 mov magazynek[ebx*2], 0106H

 czy_88h:
 cmp dl, 88h ; czy ³
 jne czy_A2h ;skok, gdy znak jest inny 
 mov magazyn[ebx], 0A3h
 mov magazynek[ebx*2], 0141H

 czy_A2h:
 cmp dl, 0A2h ; czy ó
 jne czy_ABh ;skok, gdy znak jest inny 
 mov magazyn[ebx], 0D3h
 mov magazynek[ebx*2], 00D3H

 czy_ABh:
 cmp dl, 0ABh ; czy Ÿ
 jne czy_mala ;skok, gdy znak jest inny 
 mov magazyn[ebx], 8Fh
 mov magazynek[ebx*2], 0179H

czy_mala:
 cmp dl, 'a'
 jb dalej ; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej ; skok, gdy znak nie wymaga zamiany
 sub dl, 20H ; zamiana na wielkie litery

 mov magazyn[ebx], dl
 mov magazynek[ebx*2], dx

dalej: inc ebx 
dec ecx
jnz ptl

 push 0
 push OFFSET title_Win
 push OFFSET magazyn
 push 0
 call _MessageBoxA@16

 push 0
 push OFFSET title_Uni
 push OFFSET magazynek
 push 0
 call _MessageBoxW@16

 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END
