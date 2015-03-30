with ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur;
use ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur;

procedure main is

	nb_sommets: integer;
	fichier: file_type;
	h, w: float;
	arbre_res: arbre := null;


	procedure traitement_point(t: tab_point_seg; ind: integer; a: in out arbre) is
		r: boolean := false;
		s: segment;
		n: arbre;
		v_petit, v_grand: arbre;
		c_petits, c_grands: natural;
	begin
		
		-- on regarde si on est sur un point de rebroussement
		--1) si le nombre de segments commencant au point courant est 2
		if (t(ind).seg_1.p2.x > t(ind).p.x) and (t(ind).seg_2.p2.x > t(ind).p.x) then
			r := true;
			s := (t(ind).p, t(ind).p);
			insertion(a, s, n);
			noeuds_voisins(n, v_petit, v_grand);
			compte_position(n, c_petits, c_grands);
			supprimer(a, s); 
		end if;

		-- enlever les segments qui terminent sur le point courant de l'abr
		if t(ind).seg_1.p2.x < t(ind).p.x then
			supprimer(a, t(ind).seg_1);
		end if;
		if t(ind).seg_2.p2.x < t(ind).p.x then
			supprimer(a, t(ind).seg_2);
		end if;

		-- ajouter les segments qui commencent sur le point courant dans l'abr
		if t(ind).seg_1.p2.x > t(ind).p.x then
			insertion(a, t(ind).seg_1, n);
		end if;
		if t(ind).seg_1.p2.x > t(ind).p.x then
			insertion(a, t(ind).seg_2, n);
		end if;
		
		-- si le nombre de segments terminant au point courant est 2
		if (t(ind).seg_1.p2.x < t(ind).p.x) and (t(ind).seg_2.p2.x < t(ind).p.x) then
			r := true;
			s := (t(ind).p, t(ind).p);
			insertion(a, s, n);
			noeuds_voisins(n, v_petit, v_grand);
			compte_position(n, c_petits, c_grands);
			supprimer(a, s);
		end if;

		-- on traite l'éventuel point de rebroussement
		if r then
			if (c_petits mod 2 = 1) or (c_grands mod 2 = 1) then
				-- reconnecter le point courant verticalement aux segments voisins
				

			end if;
		end if;


	end;

begin
	if argument_count /=2 then 
		put("Il faut avoir un fichier "".in"" d'entrée et un fichier "".svg"" de sortie");
		return;
	end if;

	lecture_nbsommets(argument(1), nb_sommets);

	declare
		tab: tab_point_seg(1..nb_sommets);
	begin

		-- partie préparatoire
		lecture_tab_point_seg(argument(1), tab);
		create(file => fichier, mode => out_file, name => argument(2));
		svg_header(tab, h, w);
		sort_point_seg(tab);
		svg_polygone(fichier, tab);

		--partie algo
		for i in tab'range loop
			traitement_point(tab, i, arbre_res);
		end loop;



	end;

end;
