#include <stdio.h>

int szukaj4_max(int a, int b, int c, int d);

int main()
{
	int a, b, c, d;
	printf("Podaj 4 liczby: ");
	scanf_s("%d %d %d %d", &a, &b, &c, &d, 32);

	int wynik = szukaj4_max(a, b, c, d);

	printf("Najwieksza liczba to: %d", wynik);

	return 0;
}