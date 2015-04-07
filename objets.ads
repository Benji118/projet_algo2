-- le paquetage objets sert à spécifier le contenu de l'arbre binaire
-- de recherche en fournissant les déclarations et les foncitons de 
-- comparaison
package objets is

	-- on a besoin des points pour pouvoir représenter le polygone
	type point is record
		x: float;
		y: float;
	end record;

	-- l'arbre gère des segments
	type segment is record
		p1 : point;
		p2 : point;
	end record;

	-- l'algorithme principal a besoin de connaître les points voisins
	-- de chaque sommet. il nous faut une structure qui sauvegarde ces 
	-- informations, car on va trier le tableau selon les abscisses
	type point_seg is record
		p: Point;
		seg1, seg2: segment;
	end record;

	type tab_point_seg is array (integer range <>) of point_seg;

	-- la procédure sort_point_seg utilise le tri générique de la
	-- bibliothèque ada.containers.generic_array_sort
	procedure sort_point_seg(t: in out tab_point_seg);
	-- req: un tab_point_seg quelconque
	-- gar: le tableau sera trié selon les abscisses(croissantes)

	-- les fonctions de comparaison entre des segments
	function "<=" (a,b: segment) return boolean;
	-- req: deux segments appartenant au même polygone (pas de croisement)
	-- gar: renvoie la comparaison "a est en dessous de b" (selon la définition du sujet)

	function "=" (a,b: segment) return boolean;
	-- req: deux segments quelconques
	-- gar: renvoie true si si a et b ont les mêmes points, sachant que le segment
	-- CE est le même que le segment EC.

end objets;
