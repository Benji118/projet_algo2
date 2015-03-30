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

		

		function Height(T:Tab_point_seg) return Float is

		function MaxHeight return Float is
		Max_Height : Float:=0.0;
		begin
			for I in T'range loop
				if T(I).P.Y>Max_Height then
				Max_Height:=T(I).P.Y;
				end if;
			end loop;
			return Max_Height;
		end MaxHeight;

			function MinHeight return Float is
		Min_Height : Float := 0.0;
		begin
			for I in T'range loop
			if T(I).P.Y<Min_Height then
			Min_Height := T(I).P.Y;
			end if;
		end loop;
		return Min_Height;
		end MinHeight;

		begin
			return MaxHeight - MinHeight;
		end Height;

		function Width(T:Tab_point_seg) return Float is

			function MaxWidth return Float is
		Max_Width : Float:=0.0;
		begin
		for I in T'range loop
			if T(I).P.X>Max_Width then
			Max_Width := T(I).P.X;
			end if;
		end loop;
		return Max_Width;
		end MaxWidth;

		function MinWidth return Float is
		Min_Width : Float := 0.0;
		begin
			for I in T'range loop
			if T(I).P.X<Min_Width then
			Min_Width := T(I).P.X;
			end if;
		end loop;
		return Min_Width;
		end MinWidth;

		begin
			return MaxWidth - MinWidth;
		end Width;


		 procedure Svg_Header(W,H : in Float) is
		begin
		Put (Fichier_Svg, "<svg width=""");
		Put (Fichier_Svg, W);
		Put (Fichier_Svg, """ height=""");
		Put (Fichier_Svg, H);
		Put_Line (Fichier_Svg, """>");
		end Svg_Header;

		procedure Svg_Footer is
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

		procedure Svg_Grid(T: in Tab_point_seg) is
		W,H:Float;
		begin

		W:=Width(T);
		H:=Height(T);

		Put (Fichier_Svg,"<rect x=""");
		Put (Fichier_Svg,50.0);
		Put (Fichier_Svg,""" y=""");
		Put (Fichier_Svg,50.0);
		Put (Fichier_Svg,""" width=""");
		Put (Fichier_Svg,W);
		Put (Fichier_Svg,""" height=""");
		Put (Fichier_Svg,H);
		Put(Fichier_Svg,""" style=""");
		Put(Fichier_Svg,"fill:white;stroke:black;stroke-width:2px;");
		Put_Line(Fichier_Svg,"""/>""");
		end Svg_Grid;

		procedure svg_polygone(Fichier_Svg: in File_Type; tab: Tab_point_seg) is begin
		 Put (Fichier_Svg, "<polygon points=""");
			  for i in tab'range loop
			  Put (Fichier_Svg, tab(i).p.X);
			  Put (Fichier_Svg, ",");
			  Put (Fichier_Svg, tab(i).p.Y); Put (Fichier_Svg, " ");
		      end loop;
		 Put_Line(Fichier_Svg, """ style=""fill:lime;stroke:purple;stroke-width:0.1"" /> "); end;

		end Svg;
