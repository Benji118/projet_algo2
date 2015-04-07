				with ada.text_io, ada.integer_text_io,ada.float_text_io,objets,Abr,parseur;
				use ada.text_io, ada.integer_text_io,ada.float_text_io,objets,Abr,parseur;

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

					procedure Svg_Header(Fichier_Svg: File_Type;T : Tab_Point_Seg) is
						H,W : Float;
						xmin, ymin: float;
					begin
						xmin := x_min(t);
						ymin := y_min(t);

						W:= X_Max(T) + x_min(t);
						H:= Y_Max(T) + y_min(t);

						Put (Fichier_Svg, "<svg width=""");
						Put (Fichier_Svg, W);
						Put (Fichier_Svg, """ height=""");
						Put (Fichier_Svg, H);
						Put_Line (Fichier_Svg, """>");
						Put(Fichier_Svg, "<rect width=""");
						Put(Fichier_Svg, W);
						Put(Fichier_Svg, """ height=""");
						Put(Fichier_Svg, H);
						Put(Fichier_Svg, """ fill=""");
						Put(Fichier_Svg, "white""");
						Put_Line(Fichier_Svg, "/>");
					end Svg_Header;

					procedure Svg_Footer(Fichier_Svg: File_Type) is
					begin
						Put_Line (Fichier_Svg, "</svg>");
					end Svg_Footer;

					procedure Svg_Line (Fichier_Svg: File_Type; A, B : Point; C: Color)     is
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


					procedure svg_polygone(Fichier_Svg: File_Type; tab: Tab_point_seg) is begin
						Put (Fichier_Svg, "<polygon points=""");
						for i in tab'range loop
							Put (Fichier_Svg, tab(i).p.X);
							Put (Fichier_Svg, ",");
							Put (Fichier_Svg, tab(i).p.Y); Put (Fichier_Svg, " ");
						end loop;
						Put(Fichier_Svg, """ style=""fill:lime;stroke:purple;");
						Put(Fichier_Svg,"stroke-width:0.1;fill-opacity=0.5""");
						Put_Line(Fichier_Svg,"/> ");
					end;

				end Svg;
