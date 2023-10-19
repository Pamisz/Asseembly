.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern _MessageBoxA@16 : PROC
extern __read : PROC 

public _main
.data

title_Win db 'Big Boy', 0

tekst_pocz db 10, 'Proszê napisaæ jakiœ tekst '
db 'i nacisnac Enter', 10
koniec_t db ?
magazyn db 80 dup (?)
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
 mov dl, 0A5h
 mov magazyn[ebx], dl

 czy_A9h:
 cmp dl, 0A9h ; czy ê
 jne czy_E4h ;skok, gdy znak jest inny
 mov dl, 0CAh
 mov magazyn[ebx], dl

 czy_E4h:
 cmp dl, 0E4h ; czy ñ
 jne czy_98h ;skok, gdy znak jest inny
 mov dl, 0D1h
 mov magazyn[ebx], dl

 czy_98h:
 cmp dl, 98h ; czy œ
 jne czy_BEh ;skok, gdy znak jest inny 
 mov dl, 8Ch
 mov magazyn[ebx], dl

 czy_BEh:
 cmp dl, 0BEh ; czy ¿
 jne czy_86h ;skok, gdy znak jest inny 
 mov dl, 0AFh
 mov magazyn[ebx], dl

 czy_86h:
 cmp dl, 86h ; czy æ
 jne czy_88h ;skok, gdy znak jest inny 
 mov dl, 0C6h
 mov magazyn[ebx], dl

 czy_88h:
 cmp dl, 88h ; czy ³
 jne czy_A2h ;skok, gdy znak jest inny 
 mov dl, 0A3h
 mov magazyn[ebx], dl

 czy_A2h:
 cmp dl, 0A2h ; czy ó
 jne czy_ABh ;skok, gdy znak jest inny 
 mov dl, 0D3h
 mov magazyn[ebx], dl

 czy_ABh:
 cmp dl, 0ABh ; czy Ÿ
 jne czy_mala ;skok, gdy znak jest inny 
 mov dl, 8Fh
 mov magazyn[ebx], dl

czy_mala:
 cmp dl, 'a'
 jb dalej ; skok, gdy znak nie wymaga zamiany
 cmp dl, 'z'
 ja dalej ; skok, gdy znak nie wymaga zamiany
 sub dl, 20H ; zamiana na wielkie litery

 mov magazyn[ebx], dl

dalej: inc ebx 
dec ecx
jnz ptl

 push 0
 
 push OFFSET title_Win
 push OFFSET magazyn

 push 0
 call _MessageBoxA@16

 push 0 ; kod powrotu programu
 call _ExitProcess@4
_main ENDP
END



; push 0 ; sta³a MB_OK - adres obszaru zawierajšcego tytu³
 ;push OFFSET tytul_Win1250 -  adres obszaru zawierajšcego tekst
 ;push OFFSET tekst_Win1250
 ;push 0 ; NULL
 ;call _MessageBoxA@16

  ;push 0 ; stala MB_OK
; adres obszaru zawierajšcego tytu³
 ;push OFFSET MyTitle
; adres obszaru zawierajšcego tekst
; push OFFSET tile
 ;push 0 ; NULL
 ;call _MessageBoxW@16