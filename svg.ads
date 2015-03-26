with ada.text_io, objets,abr;
use ada.text_io,objets,abr;

package Svg is

Fichier_Svg : File_Type;

type Color is (Violet, Indigo, Bleu, Vert, Jaune, Orange, Rouge, Noir, Blanc);

function Width(a:arbre) return Float;

function Height(a:arbre) return Float;

procedure Coord_Noeud(N:noeud;P:out Point);

procedure Dessiner_abr(a: in arbre;Tab_noeuds : Tab_Sommets);

function Code_Couleur (C : Color) return String;

procedure Svg_Header(a:arbre;Fichier_Svg : in out File_Type;H : out Float;W : out Float);

procedure Svg_Footer(Fichier_Svg : in out File_Type);

procedure Svg_Line (A, B : Point; C: Color;Fichier_Svg : in out File_Type);

end Svg;