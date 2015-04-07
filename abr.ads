with objets;
use objets;

-- le paquetage contient les fonctions classiques vu en cours concert les arbres binaires de recherche et les deux
-- fonctions "compte_position" et "noeuds_voisins"
package abr is

type noeud;
type arbre is access noeud;
type direction is (gauche, droite);
type tableau_fils is array(direction) of arbre;
type noeud is record
    -- la clef est un segment, sachant qu'en remplacant le type "segment" par un autre type dans les fonctions suivantes
    -- et en fournissant des fonctions de comparaison de "<=" et de "=", elles marcheraient encore.
	c: segment;
	fils: tableau_fils;
	pere: arbre;
	compte: positive;
end record;

-- procédure classique d'insertion dans un arbre binaire de recherche en respectant l'invariant de l'infériorité 
-- du fils gauche
procedure insertion(a: in out arbre; cle: segment; n: out arbre);
-- req: un arbre binaire de recherche quelconque
-- gar: un noeud qui sera situé à la position d'une feuille dans l'arbre selon la convention de l'arbre binaire de 
-- recherche en question

procedure supprimer(a: in out arbre; cle: segment);
-- req: un arbre binaire de recherche quelconque
-- gar: si la cle a été trouvé dans l'arbre alors le noeud correspondant a été supprimé, sinon on renvoie 
-- l'arbre d'entrée

-- la fonciton suivante sert uniquement à déterminer si un segment commence ou termine par rapport à un certain point
function recherche(a: arbre; cle: segment) return boolean;
-- req: un arbre binaire de recherche quelconque
-- gar: renvoie true si la cle en question a été trouvé, renvoie false sinon
 
procedure noeuds_voisins(cible: arbre; petit_voisin, grand_voisin: out arbre);
-- req: un arbre binaire de recherche quelconque
-- gar: renvoie le segment juste en-dessous et juste au-dessus par rapport au noeud en question(i.e. la "cible")

procedure compte_position(cible: arbre; nb_petits, nb_grands: out natural);
-- req: un arbre binaire de recherche quelconque
-- gar: renvoie le nombre de noeuds de l'arbre qui ont une clé stricement inférieure par rapport à celle de la "cible"
-- et le nombre de ceux ayant une clé strictement supérieure

end abr;
