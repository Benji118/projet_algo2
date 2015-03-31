with ada.text_io, objets,abr;
use ada.text_io,objets,abr;

package Svg is

type Color is (Violet, Indigo, Bleu, Vert, Jaune, Orange, Rouge, Noir, Blanc);

function Width(T:Tab_point_seg) return Float;

function Height(T:Tab_point_seg) return Float;

function Code_Couleur (C : Color) return String;

procedure Svg_Header(Fichier_Svg: File_Type; W,H : in FLoat);

procedure Svg_Footer(Fichier_Svg: File_Type);

procedure Svg_Line (Fichier_Svg: File_Type; A, B : Point; C: Color);

procedure Svg_Grid (Fichier_Svg: File_Type; T: in Tab_point_seg);

procedure svg_polygone(Fichier_Svg: File_Type; tab: Tab_point_seg);

end Svg;
