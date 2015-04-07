package body abr is

-- il s'agit de la procédure insertion telle qu'elle a été vu en cours,
-- sauf qu'il faut affecter "n" par l'arbre créé.
procedure insertion(a: in out arbre; cle: segment; n: out arbre) is
begin
        if a = null then
        -- on est arrivé à une feuille, du coup on peut créer le nouveau noeud
                a := new noeud'(cle, (null, null), null, 1);
                n := a;
        else
        -- il faut pas oublier d'incrémenter le champ "compte" de tous les pères
        -- du nouveau noeud
                a.compte := a.compte + 1;
            -- contrairement à la fonction classique, il faut soit s'arrêter au père
            -- du nouveau fils, soit passer le père en paramètre de la fonction récursive,
           -- car ici les noeuds disposent un champ qui indique leur père
                        if cle <= a.c and a.fils(gauche) = null then
                           a.fils(gauche) := new noeud'(cle, (null, null), a, 1);
                           n := a.fils(gauche);
                        elsif not(cle <= a.c) and a.fils(droite) = null then
                           a.fils(droite) := new noeud'(cle, (null, null), a, 1);
                           n := a.fils(droite);
            -- le branchement classique portant sur l'invariant de l'arbre binaire de recherche
                        elsif cle <= a.c then
                                insertion(a.fils(gauche), cle, n);
                        else
                                insertion(a.fils(droite), cle, n);
                        end if;
        end if;
end;

-- procédure auxiliaire de la procédure supprimer (vu en cours).
procedure sup_max(max: out segment; a: in out arbre) is
begin
        if a /= null then
        -- il faut encore s'arrêter à un niveau au-dessus à cause du champ père
        -- si le fils droite est null, on remplace directement par le fils gauche
                if a.fils(droite) = null then
                        max := a.c;
                        if a.fils(gauche) /= null then
                                a.fils(gauche).pere := a.pere;
                        end if;
            -- remplacement par le fils gauche
                        a := a.fils(gauche);
                else
            -- il ne faut pas oublier de décrementer le "compte" de chaque noeud en descendant
                        a.compte := a.compte - 1;
                        sup_max(max, a.fils(droite));
                end if;
        end if;
        end;

-- procédure auxiliaire de la procédure supprimer qui met à jour le compte des pères
-- du noeud qui a été supprimé
procedure decrementer(a: in out arbre) is
begin
        if a = null then
                null;
        else
                if a.compte > 1 then
            -- un noeud en moins => il faut décrémenter le "compte" du noeud
                        a.compte := a.compte - 1;
                end if;
                        decrementer(a.pere);
        end if;
end;

-- procédure vu en cours
procedure supprimer(a: in out arbre; cle: segment) is
        max_cle: segment;
begin
        if a = null then
                null;
        elsif a.c = cle then
                        -- il faut décrementer le compte des pères
                        decrementer(a);
            -- selon si le fils gauche est null ou non, il faut chercher
            -- le noeud remplacant dans le fils droite ou pas
                if a.fils(gauche) = null then
                        if a.fils(droite) /= null then
                                a.fils(droite).pere := a.pere;
                        end if;
                                a := a.fils(droite);
                else
            -- si le fils gauche n'est pas vide, on prend sa feuille maximale
                        sup_max(max_cle, a.fils(gauche));
                        a.c := max_cle;
                end if;
        else
        -- branchement portant sur l'invariant de l'arbre binaire de recherche
                if not(cle = a.c) and (cle <= a.c) then
                        supprimer(a.fils(gauche), cle);
                else
                        supprimer(a.fils(droite), cle);
                end if;
        end if;
end;

-- procédure vu en cours
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

-- fonction auxiliaire de la procédure noeuds_voisins
function max_pere(a: arbre; cle: segment) return arbre is
        -- on cherche le premier père avec une clef supérieure à la "cle"
begin
        if a /= null then
                if not(a.c <= cle) then
                        return a;
                else
                        return max_pere(a.pere, cle);
                end if;
        else
                return null;
        end if;
end;

function min_pere(a: arbre; cle: segment) return arbre is
        -- on cherche le premier père avec une clef inférieure à la "cle"
begin
        if a /= null then
                if a.c <= cle then
                        return a;
                else
                        return min_pere(a.pere, cle);
                end if;
        else
                return null;
        end if;
end;

procedure noeuds_voisins(cible: arbre; petit_voisin, grand_voisin: out arbre) is
begin
    -- l'astuce de la fonction est de voir que les arbres dont on cherche les voisins sont que des feuilles
    -- dans l'algorithme principal
        if cible.pere /= null then
                petit_voisin := min_pere(cible.pere, cible.c);
                grand_voisin := max_pere(cible.pere, cible.c);
        else
        -- s'il y a pas de père, il s'agit de la racine, or dans l'algorithme principal, "cible" est toujours une feuille, i.e.
        -- l'arbre n'est qu'une racine => il n'y a pas de segments adjacents
                petit_voisin := null;
                grand_voisin := null;
        end if;
end;

function parcours_grands(a: arbre; cle: segment) return natural is
begin
        if a = null then
                return 0;
        elsif not(cle = a.c) and (cle <= a.c) then
                if a.fils(gauche) /= null then
                        return a.compte - a.fils(gauche).compte + parcours_grands(a.pere, cle);
                else
                        return a.compte + parcours_grands(a.pere, cle);
                end if;
        else
                return parcours_grands(a.pere, cle);
        end if;
end;

function parcours_petits(a: arbre; cle: segment) return natural is
begin
        if a = null then
                return 0;
        elsif not(cle <= a.c) then
                if a.fils(droite) /= null then
                        return a.compte - a.fils(droite).compte + parcours_petits(a.pere, cle);
                else
                        return a.compte + parcours_petits(a.pere, cle);
                end if;
        else
                return parcours_petits(a.pere, cle);
        end if;
end;

procedure compte_position(cible: arbre; nb_petits, nb_grands: out natural) is
begin
    -- pour connaître le nombre de noeuds ayant une cle inférieure ou supérieure,
    -- il faut prendre en considération les champs "compte" des pères et des fils gauches et droites
    -- sinon, l'algo serait en O(n), alors comme ça, il est en O(h)

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
