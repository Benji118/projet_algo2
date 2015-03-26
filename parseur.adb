with ada.text_io, ada.integer_text_io,objets,ada.float_text_io;
use ada.text_io, ada.integer_text_io, objets,ada.float_text_io;

package body Parseur is

Fichier_In : File_Type;

procedure Lecture_NbSommets (Nom_Fichier : in String; Nb_Sommets : out Integer) is
begin
Open ( File => Fichier_In,
	   Mode => In_File,
	   Name => Nom_Fichier);

Get (Fichier_In,Nb_Sommets);

Close (Fichier_In);

end Lecture_NbSommets;

procedure Lecture_Polygone(Nom_Fichier : in String;T :in out Tab_Sommets;Nb_Sommets:in out Integer; P :in out Polygone) is
begin

Open ( File => Fichier_In,
	   Mode => In_File,
	   Name => Nom_Fichier);

Skip_Line (Fichier_In);

for I in 1..Nb_Sommets loop
	Get(Fichier_In,Float (T(I).X));
	Get(Fichier_In,Float(T(I).Y));
end loop;

for I in 1..Nb_Sommets loop
	P(I).P1:=T(I);
	Put_Line("ok" & Integer'Image(I));
end loop;

for I in 1..Nb_Sommets-1 loop
	P(I).P1:=T(I);
	P(I).P2:=T(I+1);	
end loop;
	P(Nb_Sommets).P1:=T(Nb_Sommets);
	P(Nb_Sommets).P2:=T(1);	

end Lecture_Polygone;
end Parseur;