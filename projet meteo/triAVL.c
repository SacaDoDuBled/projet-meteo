#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Structure d'un noeud AVL
struct Noeud {
    int valeur;
    int hauteur;
    struct Noeud* gauche;
    struct Noeud* droit;
};

// Créer un nouveau noeud AVL avec la valeur donnée
struct Noeud* creerNoeud(int valeur) {
    struct Noeud* noeud = (struct Noeud*) malloc(sizeof(struct Noeud));
    noeud->valeur = valeur;
    noeud->hauteur = 1;
    noeud->gauche = NULL;
    noeud->droit = NULL;
    return noeud;
}

// Retourner la hauteur d'un noeud
int hauteur(struct Noeud* noeud) {
    if (noeud == NULL) {
        return 0;
    }
    return noeud->hauteur;
}

// Mettre à jour la hauteur d'un noeud
void majHauteur(struct Noeud* noeud) {
    int hauteurGauche = hauteur(noeud->gauche);
    int hauteurDroit = hauteur(noeud->droit);
    noeud->hauteur = (hauteurGauche > hauteurDroit ? hauteurGauche : hauteurDroit) + 1;
}

// Effectuer une rotation à gauche sur un noeud
struct Noeud* RotationGauche(struct Noeud* x) {
    struct Noeud* y = x->droit;
    struct Noeud* T2 = y->gauche;

    // Effectuer la rotation
    y->gauche = x;
    x->droit = T2;

    // Mettre à jour les hauteurs
    majHauteur(x);
    majHauteur(y);

    return y;
}

// Effectuer une rotation à droite sur un noeud
struct Noeud* RotationDroite(struct Noeud* y) {
    struct Noeud* x = y->gauche;
    struct Noeud* T2 = x->droit;

    // Effectuer la rotation
    x->droit = y;
    y->gauche = T2;

    // Mettre à jour les hauteurs
    majHauteur(y);
    majHauteur(x);

    return x;
}

// Obtenir le facteur d'équilibre d'un noeud
int Balance(struct Noeud* noeud) {
    if (noeud == NULL) {
        return 0;
    }
    return hauteur(noeud->gauche) - hauteur(noeud->droit);
}

// Insérer une valeur dans l'AVL
struct Noeud* inserer(struct Noeud* noeud, int valeur) {
    // Insérer comme un arbre binaire de recherche standard
    if (noeud == NULL) {
        return creerNoeud(valeur);
    }
    if (valeur < noeud->valeur) {
        noeud->gauche = inserer(noeud->gauche, valeur);
    } else if (valeur > noeud->valeur) {
        noeud->droit = inserer(noeud->droit, valeur);
    } else {
        return noeud;
    }

// Mettre à jour la hauteur de ce noeud
    majHauteur(noeud);

    // Vérifier l'équilibre de ce noeud
    int balance = Balance(noeud);

    // Si ce noeud n'est pas équilibré, effectuer les rotations nécessaires
    if (balance > 1 && valeur < noeud->gauche->valeur) {
        return RotationDroite(noeud);
    }
    if (balance < -1 && valeur > noeud->droit->valeur) {
        return RotationGauche(noeud);
    }
    if (balance > 1 && valeur > noeud->gauche->valeur) {
        noeud->gauche = RotationGauche(noeud->gauche);
        return RotationDroite(noeud);
    }
    if (balance < -1 && valeur < noeud->droit->valeur) {
        noeud->droit = RotationDroite(noeud->droit);
        return RotationGauche(noeud);
    }

    return noeud;
}

// Trier une colonne d'un fichier CSV
void triCSVColonne(char* dossier, int colonne) {
    // Ouvrir le fichier
    FILE* f = fopen(dossier, "r");
    if (f == NULL) {
        printf("Impossible d'ouvrir le fichier\n");
        return;
    }

    // Lire les données du fichier et les insérer dans l'AVL
    struct Noeud* racine = NULL;
    char ligne[1024];
    while (fgets(ligne, 1024, f) != NULL) {
        // Récupérer la valeur de la colonne désirée
        int valeur = 0;
        int i = 0;
        char* token = strtok(ligne, ",");
        while (token != NULL) {
            if (i == colonne) {
                valeur = atoi(token);
                break;
            }
            token = strtok(NULL, ",");
            i++;
        }

        // Insérer la valeur dans l'AVL
        racine = inserer(racine, valeur);
    }

    // Fermer le fichier
    fclose(f);
}

int main() {
    char dossier[] = "data.csv";
    int colonne = 2;
    triCSVColonne(dossier, colonne);
    return 0;
}