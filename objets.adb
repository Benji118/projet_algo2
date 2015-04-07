with ada.containers.generic_array_sort;

package body objets is


	procedure sort_point_seg(t: in out tab_point_seg) is

		-- la comparaison est nécessaire pour pouvoir trier le tableau
		function "<" (a,b: point_seg) return boolean is
		begin
			-- dans le cas ou deux points ont la même abscisse, on 
			-- commence avec celui qui est au-dessus
			if a.p.x = b.p.x then
				return a.p.y < b.p.y;
			else
				return (a.p.x < b.p.x);
			end if;
		end;


		-- le tri générique d'ada
		procedure sort is new ada.containers.generic_array_sort(integer, point_seg, tab_point_seg);

	begin
		sort(t);
	end;

	function "<=" (a, b: segment) return boolean is
	begin
		-- au lieu de considérer les maximums des extrémités des segments, on
		-- considère les milieux des hauteurs
		if (a.p1.y + a.p2.y)/2.0 = (b.p1.y + b.p2.y)/2.0 then
			-- si les deux segments sont à la même hauteur, on considère les milieux des abscisses
			return (a.p1.x + a.p2.x)/2.0 <= (b.p1.x + b.p2.x)/2.0;
		else 
			return (a.p1.y + a.p2.y)/2.0 > (b.p1.y + b.p2.y)/2.0;
		end if;
	end;

	function "=" (a,b: segment) return boolean is
	begin
		if (((a.p1.x = b.p1.x) and (a.p1.y = b.p1.y)) and  ((a.p2.x = b.p2.x) and (a.p2.y = b.p2.y))) or  
			(((a.p1.x = b.p2.x) and (a.p1.y = b.p2.y)) and  ((a.p2.x = b.p1.x) and (a.p2.y = b.p1.y))) then 
			return true;
		else 
			return false;
		end if;
	end;

end objets;
