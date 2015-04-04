with ada.text_io, objets,abr;
use ada.text_io,objets,abr;

package svg is

	type color is (violet, indigo, bleu, vert, jaune, orange, rouge, noir, blanc);

	function width(t: tab_point_seg) return float;

	function height(t: tab_point_seg) return float;

	function code_couleur(c: color) return string;

	procedure svg_header(fichier_svg: file_type; w, h: in float);

	procedure svg_Footer(fichier_svg: file_type);

	procedure svg_line(fichier_svg: file_type; a, b : point; c: color);

	procedure svg_grid (fichier_svg: file_type; t: in tab_point_seg);

	procedure svg_polygone(fichier_svg: file_type; tab: tab_point_seg);

end svg;
