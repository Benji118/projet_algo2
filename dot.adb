with ada.text_io, ada.integer_text_io, abr;
use ada.text_io, ada.integer_text_io, abr;

package body dot is

procedure dot_aux(fichier: file_type; a: arbre) is
begin
	if a /= null then
		if a.fils(gauche) /= null then
			Put(fichier, """");
			Put(fichier, integer'image(a.c));
			Put(fichier, ",");
			Put(fichier, integer'image(a.compte));
			Put(fichier, """");
			Put(fichier, " -- ");
			Put(fichier, """");
			Put(fichier, integer'image(a.fils(gauche).c));
			Put(fichier, ",");
			Put(fichier, integer'image(a.fils(gauche).compte));
			Put(fichier, """");
			Put_Line(fichier, ";");
		end if;
		if a.fils(droite) /= null then
			Put(fichier, """");
			Put(fichier, integer'image(a.c));
			Put(fichier, ",");
			Put(fichier, integer'image(a.compte));
			Put(fichier, """");
			Put(fichier, " -- ");
			Put(fichier, """");
			Put(fichier, integer'image(a.fils(droite).c));
			Put(fichier, ",");
			Put(fichier, integer'image(a.fils(droite).compte));
			Put(fichier, """");
			Put_Line(fichier, ";");
		end if;
	dot_aux(fichier, a.fils(gauche));
	dot_aux(fichier, a.fils(droite));
	end if;
end;

procedure dot_main(fichier: file_type; a: arbre) is
begin
	Put_Line(fichier, "graph mon_arbre {");
	dot_aux(fichier, a);
	Put_Line(fichier, "}");
end;

end dot;
