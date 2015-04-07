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
	-- req: 

	procedure commencant(a: arbre; seg: segment; p: point; commence: out boolean);

	procedure terminant(a: arbre; seg: segment; p: point; termine: out boolean);

end geometry;
