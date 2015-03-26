with ada.text_io, ada.integer_text_io,ada.float_text_io,objets,abr;
use ada.text_io, ada.integer_text_io,ada.float_text_io,objets,abr;

package body Svg is

function Code_Couleur (C : Color) return String is
begin
case C is
when Violet => return "rgb(255,0,255)";
when Indigo => return "rgb(111,0,255)";
when Bleu => return "rgb(0,0,255)";
when Vert => return "rgb(0,255,0)";
When Jaune => return "rgb(0,255,255)";
When Orange => return "rgb(255,165,0)";
when Rouge => return "rgb(255,0,0)";
when Noir => return "rgb(0,0,0)";
when Blanc => return "rgb(255,255,255)";
end case;
end Code_Couleur;

function Width(a:arbre) return Float is
begin
--	return largeur(a)*2; (largeur a coder)
return 0.0;
end;

function Height(a:arbre) return Float is
begin
	return Float(hauteur(a)*2);

end;


 procedure Svg_Header(a: arbre ; Fichier_Svg : in out File_Type ; H : out Float; W : out Float) is
begin
W:=Width(a);
H:=100.0; --(a remplacer par Height(a))

Put (Fichier_Svg, "<svg width=""");
Put (Fichier_Svg, W);
Put (Fichier_Svg, """ height=""");
Put (Fichier_Svg, H);
Put_Line (Fichier_Svg, """>");
end Svg_Header;

procedure Svg_Footer(Fichier_Svg : in out File_Type) is
begin
Put_Line (Fichier_Svg, "</svg>");
end Svg_Footer;

procedure Svg_Line (A, B : Point; C: Color;Fichier_Svg : in out File_Type)
is
begin
Put (Fichier_Svg, "<line x1=""");
Put (Fichier_Svg, A.X);
Put (Fichier_Svg, """ y1=""");
Put (Fichier_Svg, A.Y);
Put (Fichier_Svg, """ x2=""");
Put (Fichier_Svg, B.X);
Put (Fichier_Svg, """ y2=""");
Put (Fichier_Svg, B.Y);
Put (Fichier_Svg, """ style=""stroke:");
Put (Fichier_Svg, Code_Couleur(C));
Put_Line (Fichier_Svg, ";stroke-width:0.1""/>");
end Svg_Line;

procedure Coord_Noeud(N:noeud;P:out Point) is
begin
	if N.pere=null then
		P:=(50.0,50.0);
	elsif N.c >N.pere.c then
		P:=(Coord_Noeud(N.pere.all,P).X+5.0,Coord_Noeud(N.pere.all,P).Y+10.0);
	elsif N.c <= N.pere.c then
		P:=(Coord_Noeud(N.pere.all,P).X+5.0,Coord_Noeud(N.pere.all,P).Y+10.0);
	end if;
end Coord_Noeud;

procedure Dessiner_abr(a: in arbre;Tab_noeuds : Tab_Sommets) is
begin
	null;
end;

end Svg;
