with ada.text_io, ada.integer_text_io,objets,ada.float_text_io;
use ada.text_io, ada.integer_text_io, objets,ada.float_text_io;

package body parseur is

	-- les 4 fonctions suivantes renvoient les abscisses/ordonnées minimales/maximales 
	-- d'un tab_point_seg quelconque
	function x_min(t : in tab_point_seg) return float is
		min : float :=float'Last;
	begin
		for i in t'Range loop
			if t(i).p.x < min then
				min := t(i).p.x;
			end if;
		end loop;
		return min;
	end x_min;

	function x_max(t : in tab_point_seg) return float is
		max : float :=float'first;
	begin
		for i in t'Range loop
			if t(i).p.x > max then
				max := t(i).p.x;
			end if;
		end loop;
		return max;
	end x_max;

	function y_min(t : in tab_point_seg) return float is
		min : float :=float'Last;
	begin
		for i in t'Range loop
			if t(i).p.y < min then
				min := t(i).p.y;
			end if;
		end loop;
		return min;
	end y_min;

	function y_max(t :in tab_point_seg) return float is
		max : float :=float'first;
	begin
		for i in t'Range loop
			if t(i).p.y > max then
				max := t(i).p.y;
			end if;
		end loop;
		return max;
	end y_max;

	procedure lecture_nb_sommets(nom_fichier: in string; nb_sommets: out integer) is

		fichier_in: file_type;

	begin
		open ( file => fichier_in,
		mode => in_file,
		name => nom_fichier);

		-- on lit le nombre de sommets qui est le premier nombre du fichier
		get(fichier_in, nb_sommets);

		close(fichier_in);

	end lecture_nb_sommets;

	procedure translation_x(t :in out tab_point_seg) is
		min_x : float;
	begin
		min_x := x_min(t);
		if min_x < 0.0 then
			for i in t'Range loop
				t(i).p.x := t(i).p.x - min_x;
			end loop;
		end if;
	end translation_x;

	procedure translation_y(t :in out tab_point_seg) is
		min_y : float;
	begin
		min_y := y_min(t);
		if min_y < 0.0 then
			for i in t'Range loop
				t(i).p.y := t(i).p.y - min_y;
			end loop;
		end if;
	end translation_y;

	procedure lecture_tab_point_seg(nom_fichier: in string; t: out tab_point_seg) is

		fichier_in: file_type;

	begin

		open ( file => fichier_in,
		mode => in_file,
		name => nom_fichier);

		-- on a déjà lu la première ligne dans la procédure lecture_nb_sommets
		skip_Line(fichier_in);


		-- le parcours du fichier sert à sauvegarder tous les points dans le tab_point_seg
		for i in t'range loop
			get(fichier_in, t(i).p.x);
			get(fichier_in, t(i).p.y);
		end loop;
		close(fichier_in);

		-- les points voisins d'un point dans le polygon sont définis par l'ordre
		-- des points dans le fichier d'entrée. Or, on va trier le tableau dans le programme
		-- principal. Ainsi, il est important de se rappeler du voisinage de chaque point
		for i in 1..t'Last-1 loop
			t(i).seg1.p1:=t(i).p;
			t(i).seg1.p2:=t(i + 1).p;
		end loop;
		-- le dernier point doit être traîte à part pour ne pas violer la "range" du tableau
		-- rmq: on aura pu se débrouiller avec un mod, mais on a préféré cette méthode car elle
		-- nous semblerait être plus lisible
		t(t'last).seg1.p1:=t(t'last).p;
		t(t'last).seg1.p2:=t(t'first).p;

		-- pareil pour les voisins dans l'autre sens
		for i in t'first + 1..t'Last loop
			t(i).seg2.p1:=t(i).p;
			t(i).seg2.p2:=t(i - 1).p;
		end loop;
		t(t'first).seg2.p1:=t(t'first).p;
		t(t'first).seg2.p2:=t(t'last).p;


	end lecture_tab_point_seg;

end parseur;
