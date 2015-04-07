with objets, abr;
use objets, abr;

-- le paquetage gère les aspects géométriques de l'algorithme qu'on n'a 
-- pas pu déclarer dans le paquetage "objets", car les procédures utilisent
-- des déclarations du paquetage "abr".or, le paquetage "abr" utilise déjà
-- le paquetage "objets". Alors ce paquetage existe pour éviter les double-dépendances.
package geometry is

	-- la procédue reconnecter lie les points de rebroussement choisis par l'algorithme principal avec 
	-- ses segments voisins
	procedure reconnecter(p: point; seg_dessous, seg_dessus: arbre; seg_out_1, seg_out_2: out segment);
	-- req: deux segments quelconques et un point quelconque
    -- gar: les deux segments de sortie correspondent aux intersections de la droite x=p.x avec les
    -- droites qui passent par les deux segments de sortie. Après c'est à l'utilisateur de bien se servir
    -- de la fonction pour trouver les bons segments qui sont nécessaires pour décomposer le polygon

    -- les deux fonctions suivantes sont des fonctions propres à l'utilisation des segments en tant que
    -- clefs de l'arbre binaire de recherche
	procedure commencant(a: arbre; seg: segment; p: point; commence: out boolean);
    -- req: un arbre quelconque (au sens de la déclaration du sujet) et un segment qui partage au moins
    -- un point avec le point "p"
    -- gar: la variable commence correspond à la validation de la condition commence du segment au point
    -- telle qu'elle est définie dans le sujet
	procedure terminant(a: arbre; seg: segment; p: point; termine: out boolean);
    -- req, gar: cf. la procédure commencant

end geometry;
