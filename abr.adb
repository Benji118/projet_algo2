with ada.text_io, ada.integer_text_io;
use ada.text_io, ada.integer_text_io;

package body abr is

function max(a,b: natural) return natural is
begin
	if a >= b then
		return a;
	else return b;
end if;
end;

function hauteur(a: arbre) return natural is
begin
	if a = null then
		return 0;
	else
		return 1 + max(hauteur(a.fils(gauche)), hauteur(a.fils(droite)));
	end if;
end;

procedure insertion(a: in out arbre; cle: segment; n: out arbre) is
begin
	if a = null then 
		a := new noeud'(cle, (null, null), null, 1);
		n := a;
	else
		a.compte := a.compte + 1;
			if cle <= a.c and a.fils(gauche) = null then
			   a.fils(gauche) := new noeud'(cle, (null, null), a, 1);
			   n := a.fils(gauche);
			elsif not(cle <= a.c) and a.fils(droite) = null then
			   a.fils(droite) := new noeud'(cle, (null, null), a, 1);	
			   n := a.fils(droite);
			elsif cle <= a.c then
				insertion(a.fils(gauche), cle, n);
			else 
				insertion(a.fils(droite), cle, n);
			end if;
	end if;
end;

procedure sup_max(max: out segment; a: in out arbre) is
begin
	if a.fils(droite) = null then
		max := a.c;
		a := a.fils(gauche);
	else
		a.compte := a.compte - 1;
		sup_max(max, a.fils(droite));
	end if;
end;

procedure decrementer(a: in out arbre) is
begin
	if a = null then
		null;
	else
		a.compte := a.compte - 1;
		decrementer(a.pere);
	end if;
end;

procedure supprimer(a: in out arbre; cle: segment) is
	max_cle: segment;
begin
	if a = null then
		null;
	elsif a.c = cle then
		sup_max(max_cle, a.fils(gauche));
		a.c := max_cle;
		-- il faut décrementer le compte des pères
		decrementer(a.pere);
	else 
		if not(cle = a.c) and (cle <= a.c) then
			supprimer(a.fils(gauche), cle);
		else 
			supprimer(a.fils(droite), cle);
		end if;
	end if;
end;

function recherche(a: arbre; cle: segment) return boolean is
begin
	if a = null then 
		return false;
	elsif cle = a.c then
		return true;
	elsif not(cle = a.c) and (cle <= a.c) then
		return recherche(a.fils(gauche), cle);
	else 
		return recherche(a.fils(droite), cle);
	end if;
end;

function choix_max_arbre(a, b: arbre) return arbre is
begin
	if not(a.c <= b.c) then 
		return a;
	else 
		return b;
	end if;
end;

function max_arbre(a: arbre) return arbre is
begin
	if a.fils(droite) = null then
		return a;
	else 
		return max_arbre(a.fils(droite));
	end if;
end;

function min_arbre(a: arbre) return arbre is
begin
	if a.fils(gauche) = null then
		return a;
	else 
		return max_arbre(a.fils(gauche));
	end if;
end;

procedure noeuds_voisins(cible:	arbre; petit_voisin, grand_voisin: out arbre) is
begin
	if cible.pere /= null then
		petit_voisin := choix_max_arbre(max_arbre(cible.fils(gauche)), cible.pere);
	else
		petit_voisin := max_arbre(cible.fils(gauche));
	end if;

	if cible.fils(droite) = null then
		grand_voisin := null;
	else 
		grand_voisin := min_arbre(cible.fils(droite));
	end if;
end;

function parcours_grands(a: arbre; cle: segment) return natural is
begin
	if a = null then 
		return 0;
	elsif not(cle = a.c) and (cle <= a.c) then
		return a.compte - a.fils(gauche).compte + parcours_grands(a.pere, cle);
	else
		return parcours_grands(a.pere, cle);
	end if;
end;

function parcours_petits(a: arbre; cle: segment) return natural is
begin
	if a = null then 
		return 0;
	elsif not(cle <= a.c) then
		return a.compte - a.fils(droite).compte + parcours_petits(a.pere, cle);
	else
		return parcours_petits(a.pere, cle);
	end if;
end;

procedure compte_position(cible: arbre; nb_petits, nb_grands: out natural) is
begin

	-- nb_petits
	if cible.fils(gauche) = null then
		if cible.pere = null then
			nb_petits := 0;
		else
			nb_petits := parcours_petits(cible.pere, cible.c);
		end if;
	else
		if cible.pere = null then
			nb_petits := cible.fils(gauche).compte;
		else
			nb_petits := cible.fils(gauche).compte + parcours_petits(cible.pere, cible.c);
		end if;
	end if;

	-- nb_grands
	if cible.fils(droite) = null then
		if cible.pere = null then
			nb_grands := 0;
		else
			nb_grands := parcours_grands(cible.pere, cible.c);
		end if;
	else
		if cible.pere = null then
			nb_grands := cible.fils(droite).compte;
		else
			nb_grands := cible.fils(droite).compte + parcours_grands(cible.pere, cible.c);
		end if;
	end if;


end;
end abr;
