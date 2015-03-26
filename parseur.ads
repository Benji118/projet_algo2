with objets;
use objets;

package Parseur is
	

procedure Lecture_NbSommets (Nom_Fichier : in String; Nb_Sommets : out Integer);

procedure Lecture_Polygone(Nom_Fichier : in String;T :in out Tab_Sommets;Nb_Sommets:in out Integer; P :in out Polygone);

end Parseur;