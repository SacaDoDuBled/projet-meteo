#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure de noeud de l'ABR
struct noeud {
    int valeur;
    struct noeud *gauche;
    struct noeud *droit;
};

// Fonction pour insérer un nouveau noeud dans l'ABR
struct noeud* inserer(struct noeud* noeud, int valeur) {
    if (noeud == NULL) {
        struct noeud* newNode = (struct noeud*) malloc(sizeof(struct noeud));
        newNode->valeur = valeur;
        newNode->gauche = NULL;
        newNode->droit = NULL;
        return newNode;
    }

    if (valeur < noeud->valeur) {
        noeud->gauche = inserer(noeud->gauche, valeur);
    } else if (valeur > noeud->valeur) {
        noeud->droit = inserer(noeud->droit, valeur);
    }

    return noeud;
}

// Fonction pour parcourir l'ABR en ordre infixe et ajouter les valeurs dans un tableau
void parcoursInfixe(struct noeud* noeud, int valeurs[], int* compt) {
    if (noeud == NULL) {
        return;
    }

    parcoursInfixe(noeud->gauche, valeurs, compt);
    valeurs[(*compt)++] = noeud->valeur;
    parcoursInfixe(noeud->droit, valeurs, compt);
}

// Fonction pour trier la colonne spécifiée dans le fichier CSV
void triColonne(char* fp, int column) {
    // Ouvrir le fichier CSV en mode lecture
    FILE* fichier = fopen(fp, "r");
    if (fichier == NULL) {
        printf("Error: Unable to open file.\n");
        return;
    }

    // Lire les en-têtes de colonne
    char ligne[1024];
    fgets(ligne, 1024, fichier);

    // Créer un ABR pour stocker les valeurs de la colonne
    struct noeud* racine = NULL;

    // Lire chaque ligne du fichier et insérer la valeur de la colonne dans l'ABR
    while (fgets(ligne, 1024, fichier) != NULL) {
        char* token = strtok(ligne, ",");
        int compt = 0;
        while (token != NULL) {
            if (compt == column) {
                int valeur = atoi(token);
                racine = inserer(racine, valeur);
            }
            compt++;
            token = strtok(NULL, ",");
        }
    }

    // Fermer le fichier
    fclose(fichier);

    // Parcourir l'ABR en ordre infixe et ajouter les valeurs dans un tableau
    int valeurs[1024];
    int compt = 0;
    parcoursInfixe(racine, valeurs, &compt);
    printf("Fichier '%s' trier avec succès.\n", fp);
}

int main(int argc, char* argv[]) {

    char* fp = argv[1];
    int colonne = atoi(argv[2]);

    triColonne(fp, colonne);

    return 0;
}