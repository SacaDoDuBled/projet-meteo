#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LIGNE 1000000
#define MAX_NUM_COLONNE 15 //Nombre de colonne du fichier data.csv

int compare(const char *a, const char *b) {
  return strcmp(a, b);
}

int main(void) {

  FILE *fp = fopen("data.csv", "r");
  if (!fp) {
    printf("Erreur à l'ouverture du fichier.");
    return 1;
  }

  int colonne;
  printf("Entrer le numéro de la colonne à trier : ");
  scanf("%d", &colonne);

  char ligne[MAX_LIGNE];
  char *valeur_colonne[MAX_NUM_COLONNE];
  int num_ligne = 0;
  while (fgets(ligne, MAX_LIGNE, fp)) {
    char *token = strtok(ligne, ",");
    int num_colonne = 0;
    while (token) {
      if (num_colonne == colonne) {
        valeur_colonne[num_ligne] = strdup(token);
      }
      token = strtok(NULL, ",");
      num_colonne++;
    }
    num_ligne++;
  }

  fclose(fp);

  for (int i = 1; i < num_ligne; i++) {
    char *temp = valeur_colonne[i];
    int j = i - 1;
    while (j >= 0 && compare(valeur_colonne[j], temp) > 0) {
      valeur_colonne[j + 1] = valeur_colonne[j];
      j--;
    }
    valeur_colonne[j + 1] = temp;
  }

  for (int i = 0; i < num_ligne; i++) {
    printf("%s\n", valeur_colonne[i]);
  }

  return 0;
}