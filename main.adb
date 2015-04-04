with ada.command_line, ada.text_io, objets, abr, svg, parseur, geometry;
use ada.command_line, ada.text_io, objets, abr, svg, parseur, geometry;

procedure main is

	-- variables d'initialisation des structures et du fichier de sortie
	nb_sommets: integer;
	fichier_svg: file_type;
	h, w: float;

	-- variables pour l'algorithme principal fourni dans le sujet
	arbre_res: arbre := null;
	-- segments_parcourus est une mémoire qui évite de ne pas ajouter 2 fois le même segment 
	segments_parcourus: list_seg := null;
	deja_utilise_bool: boolean;
	-- la variable suppr signale à la fonction deja_utilise qu'il faut supprimer un segment
	-- qui est déjà la liste des segments parcourus pour éviter que la liste soit trop longue
	suppr: boolean := true;
	commence1, commence2, termine1, termine2: boolean;


	-- il s'agit de l'algorithme principal fourni qui traite le point courant
	procedure traitement_point(t: tab_point_seg; ind: integer; a: in out arbre; fichier_svg: in out file_type) is
		-- variables demandées dans le sujet
		r: boolean := false;
		s: segment := (t(ind).p, t(ind).p);
		n: arbre;
		v_petit, v_grand: arbre;
		c_petits, c_grands: natural;
		--deux segments pour la reconnection verticale
		s1, s2: segment;
	begin
		commencant(t(ind).seg1, t(ind).p, segments_parcourus, commence1);
		commencant(t(ind).seg2, t(ind).p, segments_parcourus, commence2);
		terminant(t(ind).seg1, t(ind).p, segments_parcourus, termine1);
		terminant(t(ind).seg2, t(ind).p, segments_parcourus, termine2);

		-- on regarde si on est sur un point de rebroussement
		-- si le nombre de segments commencant au point courant est 2
		if commence1 and commence2 then
			r := true;
			inserer(a, s, n);
			noeuds_voisins(n, v_petit, v_grand);
			compte_position(n, c_petits, c_grands);
			supprimer(a, s); 
		end if;

		-- enlever les segments qui terminent sur le point courant de l'abr
		if termine1 then
			supprimer(a, t(ind).seg1);
		end if;
		if termine2 then
			supprimer(a, t(ind).seg2);
		end if;
	

		-- ajouter les segments qui commencent sur le point courant dans l'abr
		-- la fonction deja_utilise nous dit si un segment a déjà été ajouté à travers 
		-- la variable deja_utilise_bool
		deja_utilise(t(ind).seg1, segments_parcourus, deja_utilise_bool, suppr);
		if not(deja_utilise_bool) and commence1 then
			inserer(a, t(ind).seg1, n);
		end if;

		deja_utilise(t(ind).seg2, segments_parcourus, deja_utilise_bool, suppr);
		if not(deja_utilise_bool) and commence2 then
			inserer(a, t(ind).seg2, n);
		end if;
		
		-- on regarde si on est sur un point de rebroussement
		-- si le nombre de segments terminant au point courant est 2
		if termine1 and termine2 then
			r := true;
			inserer(a, s, n);
			noeuds_voisins(n, v_petit, v_grand);
			compte_position(n, c_petits, c_grands);
			supprimer(a, s);
		end if;

		-- on traite l'éventuel point de rebroussement
		if r then
			if (c_petits mod 2 = 1) or (c_grands mod 2 = 1) then
				-- reconnecter le point courant verticalement aux segments voisins
				reconnecter(t(ind).p, v_petit, v_grand, s1, s2);
				-- on ajoute les deux segments au fichier de sortie
				svg_line(fichier_svg, s1.p1, s1.p2, rouge);
				svg_line(fichier_svg, s2.p1, s2.p2, rouge);
			end if;
		end if;


	end;

begin
	-- prévention de mauvaise utilisation
	if argument_count /=2 then 
		put("Il faut avoir un fichier "".in"" d'entrée et un fichier "".svg"" de sortie");
		return;
	end if;

	-- il nous faut le nombre de sommests pour pouvoir initialiser le tableau
	lecture_nb_sommets(argument(1), nb_sommets);

	declare
		tab: tab_point_seg(1..nb_sommets);
	begin

		-- partie préparatoire
		lecture_tab_point_seg(argument(1), tab);
		create(file => fichier_svg, mode => out_file, name => argument(2));
		-- écriture dans le fichier de sortie
		svg_header(fichier_svg, height(tab), width(tab));
		svg_polygone(fichier_svg, tab);

		-- pour pouvoir parcourir le polygone de gauche à droite, il faut trier
		-- les sommets dans l'ordre des abscisses croissantes
		sort_point_seg(tab);

		--partie algo
		-- on parcourt tous les points
		for i in tab'range loop
			traitement_point(tab, i, arbre_res, fichier_svg);
		end loop;

		-- fermeture du fichier de sortie
		svg_footer(fichier_svg);
		close(fichier_svg);

	end;

end;
