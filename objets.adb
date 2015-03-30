with ada.containers.generic_array_sort;

package body objets is

procedure sort_point(t: in out Tab_Sommets) is

	function "<" (a,b: point) return boolean is
	begin
		return (a.x < b.x);
	end;

	
	procedure sort is new ada.containers.generic_array_sort(integer, point, tab_sommets);

begin
	sort(t);
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

procedure afficher(t: Tab_Sommets) is
begin
	for i in t'range loop
		put(t(i).x);
		put(", ");
		put(t(i).y);
		new_line;
	end loop;
	new_line;
end;

function "<=" (a,b: segment) return boolean is
begin
	if ((a.p1.y < b.p1.y) and (a.p1.y < b.p2.y)) or ((a.p2.y < b.p1.y) and (a.p2.y < b.p2.y)) then 
		return true;
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

end objets;
