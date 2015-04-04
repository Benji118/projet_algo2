with ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur, geometry, ada.float_text_io;
use ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur, geometry, ada.float_text_io;

procedure main is

	nb_sommets: integer;
	fichier_svg, fichier_dot: file_type;
	h, w: float;
	arbre_res: arbre := null;
	segments_parcourus: list_seg := null;
	deja_utilise_bool: boolean;
	suppr: boolean := true;
	commence1, commence2, termine1, termine2: boolean;


	procedure traitement_point(t: tab_point_seg; ind: integer; a: in out arbre; fichier_svg: in out file_type) is
		r: boolean := false;
		s: segment;
		n: arbre;
		v_petit, v_grand: arbre;
		c_petits, c_grands: natural;
		--deux segments pour la reconnection verticale
		s1, s2: segment;
	begin
--		if t(ind).seg1.p2.x = t(ind).p.x then
--			insertion(a, t(ind).seg1, n);
--		end if;
--		if t(ind).seg2.p2.x = t(ind).p.x then
--			insertion(a, t(ind).seg2, n);
--		end if;
		termine1 := false;
		termine2 := false;
		commence1 := false;
		commence2:= false;
		
		-- on regarde si on est sur un point de rebroussement
		--1) si le nombre de segments commencant au point courant est 2
		commencant(t(ind).seg1, t(ind).p, segments_parcourus, commence1);
		commencant(t(ind).seg2, t(ind).p, segments_parcourus, commence2);
		terminant(t(ind).seg1, t(ind).p, segments_parcourus, termine1);
		terminant(t(ind).seg2, t(ind).p, segments_parcourus, termine2);

		if commence1 and commence2 then
			r := true;
			s := (t(ind).p, t(ind).p);
			insertion(a, s, n);
			noeuds_voisins(n, v_petit, v_grand);
			compte_position(n, c_petits, c_grands);
		if ind = 11 then 
			put("yolo");
			put(v_grand.c);
			dot_main(fichier_dot, a);
			close(fichier_dot);
		end if;
			supprimer(a, s); 
		end if;

--		if t(ind).seg1.p2.x = t(ind).p.x then
--			supprimer(a, t(ind).seg1);
--		end if;
--		if t(ind).seg2.p2.x = t(ind).p.x then
--			supprimer(a, t(ind).seg2);
--		end if;

		-- enlever les segments qui terminent sur le point courant de l'abr
--		if t(ind).seg1.p2.x <= t(ind).p.x then
		if termine1 then
			supprimer(a, t(ind).seg1);
		end if;
--		if t(ind).seg2.p2.x <= t(ind).p.x then
		if termine2 then
			supprimer(a, t(ind).seg2);
		end if;
	

		-- ajouter les segments qui commencent sur le point courant dans l'abr
		deja_utilise(t(ind).seg1, segments_parcourus, deja_utilise_bool, suppr);
		if not(deja_utilise_bool ) and (t(ind).seg1.p2.x >= t(ind).p.x) then
		--if commence1 then
			insertion(a, t(ind).seg1, n);
		end if;

		deja_utilise(t(ind).seg2, segments_parcourus, deja_utilise_bool, suppr);
		if not(deja_utilise_bool) and (t(ind).seg2.p2.x >= t(ind).p.x) then
		--if commence2 then
			insertion(a, t(ind).seg2, n);
		end if;
		
		-- si le nombre de segments terminant au point courant est 2
--		terminant(t(ind).seg1, t(ind).p, segments_parcourus, termine1);
--		terminant(t(ind).seg2, t(ind).p, segments_parcourus, termine2);

		if termine1 and termine2 then
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
				reconnecter(t(ind).p, v_petit, v_grand, s1, s2);
				svg_line(fichier_svg, s1.p1, s1.p2, rouge);
				svg_line(fichier_svg, s2.p1, s2.p2, rouge);
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
		lecture_tab_point_seg(argument(1), tab, nb_sommets);
		create(file => fichier_svg, mode => out_file, name => argument(2));
		create(file => fichier_dot, mode => out_file, name => "out.dot");
		svg_header(fichier_svg, height(tab), width(tab));
		svg_polygone(fichier_svg, tab);
		sort_point_seg(tab);

		--partie algo
		for i in tab'range loop
			traitement_point(tab, i, arbre_res, fichier_svg);
		end loop;
--		dot_main(fichier_dot, arbre_res);

		svg_footer(fichier_svg);
--		close(fichier_dot);
		close(fichier_svg);

	end;

end;
