#include <stdio.h>
void przestaw(int tabl[], int n);
#define liczba 10
int main()
{
	int tab[liczba] = { 45, 17, 82, 29, 64, 5, 93, 12, 58, 37 };

	for (int i = 0; i < liczba; i++) {
		przestaw(tab, liczba - i);
	}

	printf("Tablica: ");
	
	for (int i = 0; i < liczba; i++) {
		printf("%d ", tab[i]);
	}

	return 0;
}
