package body geometry is

procedure intersection(p: point; seg_in: segment; seg_out: out segment) is
	m, b: float;
begin
	if seg_in.p1.x /= seg_in.p2.x then
        -- on cherche l'équation de la droite qui passe par le segment
		m := (seg_in.p2.y - seg_in.p1.y)/(seg_in.p2.x - seg_in.p1.x);
		b := (seg_in.p1.y*seg_in.p2.x - seg_in.p2.y*seg_in.p1.x)/(seg_in.p2.x - seg_in.p1.x);
		seg_out := (p, (p.x, m*p.x+b));
	else
		-- cas d'un segment vertical
        -- dans ce cas, on prend juste le segment d'entrée 
        seg_out := seg_in;
	end if;
end;

procedure reconnecter(p: point; seg_dessous, seg_dessus: arbre; seg_out_1, seg_out_2: out segment) is
begin
    -- pour lier le point de rebroussement avec les deux segments juste au-dessous et au-dessus, on cherche
    -- l'intersection des droites passant par les segments et de la droite x=p.x
	intersection(p, seg_dessous.c, seg_out_1);
	intersection(p, seg_dessus.c, seg_out_2);	
end;

procedure commencant(a: arbre; seg: segment; p: point; commence: out boolean) is
begin
    -- normalement, un segment commencant à l'autre extrémité à gauche du point qu'on considère
	if (seg.p2.x > p.x) then 
		commence := true;
	elsif seg.p2.x = p.x then
        -- dans le cas du segment vertical, on a pris la convention qu'il ne commence pas dans ce point 
        -- s'il a déjà été détecté par un autre sommet, ce qui revient à tester si le segment est déjà présent
        -- dans l'abre de recherche ou pas
		commence := not recherche(a, seg);
	else
		commence := false;
	end if;
end;

procedure terminant(a: arbre; seg: segment; p: point; termine: out boolean) is
begin
    -- un segment terminant en un point a son autre extrémité normalement à droite
	if seg.p2.x < p.x then
		termine := true;
    -- sauf dans le cas d'un segment vertical. encore une fois, un fois qu'on a trouvé une convention, la 
    -- vérification de présence suffit
	elsif seg.p2.x = p.x then 
		termine := recherche(a, seg);
	else 
		termine := false;
	end if;
end;


end geometry;
