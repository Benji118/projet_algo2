with ada.text_io, ada.integer_text_io,ada.float_text_io,objets,abr;
use ada.text_io, ada.integer_text_io,ada.float_text_io,objets,abr;

package body svg is

	function code_couleur (c : color) return string is
	begin
		case c is
			when violet => return "rgb(255,0,255)";
			when indigo => return "rgb(111,0,255)";
			when bleu => return "rgb(0,0,255)";
			when vert => return "rgb(0,255,0)";
			When jaune => return "rgb(0,255,255)";
			When orange => return "rgb(255,165,0)";
			when rouge => return "rgb(255,0,0)";
			when noir => return "rgb(0,0,0)";
			when blanc => return "rgb(255,255,255)";
		end case;
	end code_couleur;

	function height(t:tab_point_seg) return float is

		function maxheight return float is
			Max_Height : float:=0.0;
		begin
			for I in t'range loop
				if t(I).P.Y>Max_Height then
					Max_Height:=t(I).P.Y;
				end if;
			end loop;
			return Max_Height;
		end MaxHeight;

		function MinHeight return float is
			Min_Height : float := 0.0;
		begin
			for I in t'range loop
				if t(I).P.Y<Min_Height then
					Min_Height := t(I).P.Y;
				end if;
			end loop;
			return Min_Height;
		end MinHeight;

	begin
		return MaxHeight - MinHeight;
	end Height;

	function Width(t:tab_point_seg) return float is

		function MaxWidth return float is
			Max_Width : float:=0.0;
		begin
			for I in t'range loop
				if t(I).P.X>Max_Width then
					Max_Width := t(I).P.X;
				end if;
			end loop;
			return Max_Width;
		end MaxWidth;

		function MinWidth return float is
			Min_Width : float := 0.0;
		begin
			for I in t'range loop
				if t(I).P.X<Min_Width then
					Min_Width := t(I).P.X;
				end if;
			end loop;
			return Min_Width;
		end MinWidth;

	begin
		return MaxWidth - MinWidth;
	end Width;


	procedure svg_Header(fichier_svg: file_type; W,H : in float) is
	begin
		Put (fichier_svg, "<svg width=""");
		Put (fichier_svg, W);
		Put (fichier_svg, """ height=""");
		Put (fichier_svg, H);
		Put_Line (fichier_svg, """>");
	end svg_Header;

	procedure svg_footer(fichier_svg: file_type) is
	begin
		Put_Line (fichier_svg, "</svg>");
	end svg_footer;

	procedure svg_Line (fichier_svg: file_type; A, B : Point; c: color)	is
	begin
		Put (fichier_svg, "<line x1=""");
		Put (fichier_svg, A.X);
		Put (fichier_svg, """ y1=""");
		Put (fichier_svg, A.Y);
		Put (fichier_svg, """ x2=""");
		Put (fichier_svg, B.X);
		Put (fichier_svg, """ y2=""");
		Put (fichier_svg, B.Y);
		Put (fichier_svg, """ style=""stroke:");
		Put (fichier_svg, code_couleur(c));
		Put_Line (fichier_svg, ";stroke-width:0.1""/>");
	end svg_Line;

	procedure svg_Grid(fichier_svg: file_type; t: in tab_point_seg) is
		W,H:float;
	begin

		W:=Width(t);
		H:=Height(t);

		Put (fichier_svg,"<rect x=""");
		Put (fichier_svg,50.0);
		Put (fichier_svg,""" y=""");
		Put (fichier_svg,50.0);
		Put (fichier_svg,""" width=""");
		Put (fichier_svg,W);
		Put (fichier_svg,""" height=""");
		Put (fichier_svg,H);
		Put(fichier_svg,""" style=""");
		Put(fichier_svg,"fill:white;stroke:black;stroke-width:2px;");
		Put_Line(fichier_svg,"""/>""");
	end svg_Grid;

	procedure svg_polygone(fichier_svg: file_type; tab: tab_point_seg) is begin
		Put (fichier_svg, "<polygon points=""");
		for i in tab'range loop
			Put (fichier_svg, tab(i).p.X);
			Put (fichier_svg, ",");
			Put (fichier_svg, tab(i).p.Y); Put (fichier_svg, " ");
		end loop;
		Put_Line(fichier_svg, """ style=""fill:lime;stroke:purple;stroke-width:0.1"" /> "); end;

	end svg;
