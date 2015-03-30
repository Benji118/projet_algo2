with ada.text_io, objets,abr;
use ada.text_io,objets,abr;

package Svg is

Fichier_Svg : File_Type;

type Color is (Violet, Indigo, Bleu, Vert, Jaune, Orange, Rouge, Noir, Blanc);

function Width(T:Tab_Sommets) return Float;

function Height(T:Tab_Sommets) return Float;

function Code_Couleur (C : Color) return String;

procedure Svg_Header(W,H : in FLoat);

procedure Svg_Footer;

procedure Svg_Line (A, B : Point; C: Color;Fichier_Svg : in out File_Type);

procedure Svg_Grid (T: in Tab_Sommets);

procedure svg_polygone(Fichier_Svg: in File_Type; tab: Tab_Sommets);

end Svg;