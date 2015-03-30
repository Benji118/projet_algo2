with ada.text_io, ada.integer_text_io,objets,ada.float_text_io;
use ada.text_io, ada.integer_text_io, objets,ada.float_text_io;

package body Parseur is

Fichier_In : File_Type;

procedure Lecture_NbSommets

 (Nom_Fichier : in String; Nb_Sommets : out Integer) is
begin
Open ( File => Fichier_In,
	   Mode => In_File,
	   Name => Nom_Fichier);

Get (Fichier_In,Nb_Sommets);

Close (Fichier_In);

end Lecture_NbSommets;

procedure Lecture_Tab_point_seg(Nom_Fichier : in String;T :in out Tab_point_seg;Nb_Sommets:in out Integer) is
begin

Open ( File => Fichier_In,
	   Mode => In_File,
	   Name => Nom_Fichier);

Skip_Line (Fichier_In);

declare
T : Tab_point_seg(1..Nb_Sommets);
begin

for I in T'range loop
	Get(Fichier_In,Float (T(I).P.X));
	Get(Fichier_In,Float(T(I).P.Y));
end loop;

for I in 1..T'Last-1 loop
	T(I).seg1.P1:=T(I).P;
	T(I).seg1.P2:=T(I+1).P;
end loop;

T(Nb_Sommets).seg1.P1:=T(Nb_Sommets).P;
T(Nb_Sommets).seg1.P2:=T(1).P;

for I in 2..T'Last loop
	T(I).seg2.P1:=T(I).P;
	T(I).seg2.P2:=T(I-1).P;
end loop;

	T(1).seg2.P1:=T(1).P;	
	T(1).seg2.P2:=T(Nb_Sommets).P;

end;

end Lecture_Tab_point_seg;

end Parseur;