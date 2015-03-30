with ada.text_io, ada.integer_text_io,ada.float_text_io;
use ada.text_io, ada.integer_text_io,ada.float_text_io;

package Objets is

type Droite is record
x_equa : Float;
end record;

type Point is record
X : Float;
Y : Float;
end record;

type Segment is record
P1 : Point;
P2 : Point;
end record;

type point_seg is record
	p: Point;
	seg1, seg2: segment;
end record;

type Tab_Sommets is array (integer range <>) of Point;

type Polygone is array (integer range <>) of Segment;

type tab_point_seg is array (integer range <>) of point_seg;

procedure put(a: segment);

procedure sort_point_seg(t: in out tab_point_seg);

procedure afficher(t: Tab_Sommets);

function "<=" (a,b: segment) return boolean;

function "=" (a,b: segment) return boolean;

end Objets;
