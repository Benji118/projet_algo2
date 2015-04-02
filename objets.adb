with ada.containers.generic_array_sort;
with ada.float_text_io;
use ada.float_text_io;

package body objets is


	procedure sort_point_seg(t: in out tab_point_seg) is

		function "<" (a,b: point_seg) return boolean is
		begin
			if a.p.x = b.p.x then
				return a.p.y < b.p.y;
			else
				return (a.p.x < b.p.x);
			end if;
		end;


		procedure sort is new ada.containers.generic_array_sort(integer, point_seg, tab_point_seg);

	begin
		sort(t);
	end;

	procedure put(fichier: file_type; a: segment) is
	begin
		put(fichier, "p1=(");
		put(fichier, float'image(a.p1.x));
		put(fichier, ",");
		put(fichier, float'image(a.p1.y));
		put(fichier, "); p2=(");
		put(fichier, float'image(a.p2.x));
		put(fichier, ",");
		put(fichier, float'image(a.p2.y));
		put_line(fichier, ")");
	end;

	procedure put(a: segment) is
	begin
		put("p1=(");
		put(float'image(a.p1.x));
		put(",");
		put(float'image(a.p1.y));
		put("); p2=(");
		put(float'image(a.p2.x));
		put(",");
		put(float'image(a.p2.y));
		put_line(")");
	end;

	procedure afficher(t: tab_point_seg) is
	begin
		for i in t'range loop
			put(t(i).p.x);
			put(", ");
			put(t(i).p.y);
			new_line;
		end loop;
		new_line;
	end;

	function "<=" (a,b: segment) return boolean is
	begin
		if float'min(a.p1.y, a.p2.y) > float'min(b.p1.y, b.p2.y) then
			return true;
		elsif float'min(a.p1.y, a.p2.y) = float'min(b.p1.y, b.p2.y) then
			if float'max(a.p1.y, a.p2.y) = float'max(b.p1.y, b.p2.y) then
				return float'max(a.p1.x, a.p2.x) < float'max(b.p1.x, b.p2.x);
			else
				return float'max(a.p1.y, a.p2.y) > float'max(b.p1.y, b.p2.y); 
			end if;
		else 
			return false;
		end if;
	end;

	function "=" (a,b: segment) return boolean is
	begin
		if (((a.p1.x = b.p1.x) and (a.p1.y = b.p1.y)) and  ((a.p2.x = b.p2.x) and (a.p2.y = b.p2.y))) or  (((a.p1.x = b.p2.x) and (a.p1.y = b.p2.y)) and  ((a.p2.x = b.p1.x) and (a.p2.y = b.p1.y))) then return true;
	else return false;
end if;
end;

procedure deja_utilise(s: segment; liste: in out list_seg; b: out boolean) is
	verif: boolean := false;
	l: list_seg := liste;
begin
	if l /= null then
		-- si l'élément est à la tête de la liste
		if l.seg = s then
			liste := liste.suiv;
			verif := true;
		end if;
		while l.suiv /= null and not verif loop
			if l.suiv.seg = s then
				verif := true;
				l.suiv := l.suiv.suiv;
			else
				l := l.suiv;
			end if;
		end loop;
	end if;
	-- se l'élément n'est pas dans la liste, alors on le rajoute
	if not verif then
		if l = null then
			liste := new seg_ptr_ele'(s, null);
		else
			l.suiv := new seg_ptr_ele'(s, null);
		end if;
	end if;
	b := verif;
end;

procedure afficher_list_seg(l: list_seg) is
	ptr: list_seg := l;
begin
	put("affichage de liste");
	while ptr /= null loop
		put(ptr.seg);
		ptr := ptr.suiv;
	end loop;
	new_line;
end;

end objets;
