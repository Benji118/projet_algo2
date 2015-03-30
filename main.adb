with ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur;
use ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, dot, parseur;

procedure main is

	nb_sommets: integer;
	fichier: file_type;
	h, w: float;
	arbre_res: arbre := null;
	type list_segments is record


begin
	if argument_count /=2 then 
		put("Il faut avoir un fichier "".in"" d'entrée et un fichier "".svg"" de sortie");
		return;
	end if;

	lecture_nbsommets(argument(1), nb_sommets);

	declare
		tab: tab_sommets(1 .. nb_sommets);
		poly: polygone(1 .. nb_sommets);
	begin

		-- partie préparatoire
		lecture_polygone(argument(1), tab, nb_sommets, poly);
		create(file => fichier, mode => out_file, name => argument(2));
		svg_header(null, fichier, tab, h, w);
		sort_point(tab);
		svg_polygone(fichier, tab);

		--partie algo
		for i in tab'range loop
			ajouter_segments(tab, i, arbre_res);
		end loop;



	end;

end;
