with objets;
use objets;

package Parseur is
	

procedure Lecture_NbSommets (Nom_Fichier : in String; Nb_Sommets : out Integer);

procedure Lecture_Tab_point_seg(Nom_Fichier : in String;T : out Tab_point_seg;Nb_Sommets:in out Integer);

end Parseur;
