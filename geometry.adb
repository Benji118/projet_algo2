with ada.text_io;
use ada.text_io;

package body geometry is

procedure intersection(p: point; seg_in: segment; seg_out: out segment) is
	m, b: float;
begin
	if seg_in.p1.x /= seg_in.p2.x then
		m := (seg_in.p2.y - seg_in.p1.y)/(seg_in.p2.x - seg_in.p1.x);
		b := (seg_in.p1.y*seg_in.p2.x - seg_in.p2.y*seg_in.p1.x)/(seg_in.p2.x - seg_in.p1.x);
		seg_out := (p, (p.x, m*p.x+b));
	else
		-- cas d'un segment vertical 
		if p = seg_in.p1 then
			seg_out := (p, seg_in.p2);
		else 
			seg_out := (p, seg_in.p1);
		end if;
	end if;
end;

procedure reconnecter(p: point; seg_dessous, seg_dessus: arbre; seg_out_1, seg_out_2: out segment) is
begin
	intersection(p, seg_dessous.c, seg_out_1);
	intersection(p, seg_dessus.c, seg_out_2);	
end;

end geometry;
