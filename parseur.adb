with ada.text_io, ada.integer_text_io,objets,ada.float_text_io;
use ada.text_io, ada.integer_text_io, objets,ada.float_text_io;

package body parseur is

	fichier_in : file_type;

	procedure lecture_nb_sommets(nom_fichier: in string; nb_sommets: out Integer) is
	begin
		open ( file => fichier_in,
		mode => in_file,
		name => nom_fichier);

		get(fichier_in, nb_sommets);

		close(fichier_in);

	end lecture_nb_sommets;

	procedure lecture_tab_point_seg(nom_fichier: in string; t: out tab_point_seg) is
	
	begin

		open ( file => fichier_in,
		mode => in_file,
		name => nom_fichier);

		skip_Line(fichier_in);


			for i in t'range loop
				get(fichier_in, t(i).p.x);
				get(fichier_in, t(i).p.y);
			end loop;

			for i in 1..t'Last-1 loop
				t(i).seg1.p1:=t(i).p;
				t(i).seg1.p2:=t(i + 1).p;
			end loop;

			t(t'last).seg1.p1:=t(t'last).p;
			t(t'last).seg1.p2:=t(t'first).p;

			for i in t'first + 1..t'Last loop
				t(i).seg2.p1:=t(i).p;
				t(i).seg2.p2:=t(i - 1).p;
			end loop;

			t(t'first).seg2.p1:=t(t'first).p;	
			t(t'first).seg2.p2:=t(t'last).p;

		close(fichier_in);

	end lecture_tab_point_seg;

end parseur;
