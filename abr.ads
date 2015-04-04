with objets;
use objets;

package abr is

type noeud;
type arbre is access noeud;
type direction is (gauche, droite);
type tableau_fils is array(direction) of arbre;
type noeud is record
	c: segment;
	fils: tableau_fils;
	pere: arbre;
	compte: positive;
end record;

function hauteur(a: arbre) return natural;

procedure inserer(a: in out arbre; cle: segment; n: out arbre);

procedure supprimer(a: in out arbre; cle: segment);

procedure noeuds_voisins(cible: arbre; petit_voisin, grand_voisin: out arbre);

procedure compte_position(cible: arbre; nb_petits, nb_grands: out natural);

end abr;
