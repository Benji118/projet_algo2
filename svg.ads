with ada.text_io, objets,Abr,parseur;
use ada.text_io,objets,Abr,parseur;

package Svg is

type Color is (Violet, Indigo, Bleu, Vert, Jaune, Orange, Rouge, Noir, Blanc);

function Code_Couleur (C : Color) return String;

procedure Svg_Header(Fichier_Svg: File_Type;T : Tab_Point_Seg);

procedure Svg_Footer(Fichier_Svg: File_Type);

procedure Svg_Line (Fichier_Svg: File_Type; A, B : Point; C: Color);

procedure svg_polygone(Fichier_Svg: File_Type; tab: Tab_point_seg);

end Svg;
