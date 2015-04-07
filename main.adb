with ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, parseur, geometry, ada.float_text_io;
use ada.command_line, ada.text_io, ada.integer_text_io, objets, abr, svg, parseur, geometry, ada.float_text_io;

procedure main is

        -- variables d'initialisation des structures et du fichier de sortie
        nb_sommets: integer;
        fichier_svg: file_type;

        -- variables pour l'algorithme principal fourni dans le sujet
        arbre_res: arbre := null;
        commence1, commence2, termine1, termine2: boolean;


        -- il s'agit de l'algorithme principal fourni qui traite le point courant
        procedure traitement_point(t: tab_point_seg; ind: integer; a: in out arbre; fichier_svg: in out file_type) is
                r: boolean := false;
                s: segment := (t(ind).p, t(ind).p);
                n: arbre;
                v_petit, v_grand: arbre;
                c_petits, c_grands: natural;
                --deux segments pour la reconnexion verticale
                s1, s2: segment;
        begin

                commencant(a, t(ind).seg1, t(ind).p, commence1);
                commencant(a, t(ind).seg2, t(ind).p, commence2);
                terminant(a, t(ind).seg1, t(ind).p, termine1);
                terminant(a, t(ind).seg2, t(ind).p, termine2);

                -- on regarde si on est sur un point de rebroussement
                -- si le nombre de segments commencant au point courant est 2
                if commence1 and commence2 then
                        r := true;
                        insertion(a, s, n);
                        noeuds_voisins(n, v_petit, v_grand);
                        compte_position(n, c_petits, c_grands);
                        supprimer(a, s);
                end if;

                -- enlever les segments qui terminent sur le point courant de l'abr
                if termine1 then
                        supprimer(a, t(ind).seg1);
                end if;
                if termine2 then
                        supprimer(a, t(ind).seg2);
                end if;


                -- ajouter les segments qui commencent sur le point courant dans l'abr
                if commence1 then
                        insertion(a, t(ind).seg1, n);
                end if;
                if commence2 then
                        insertion(a, t(ind).seg2, n);
                end if;

                -- on regarde si on est sur un point de rebroussement
                -- si le nombre de segments terminant au point courant est 2
                if termine1 and termine2 then
                        r := true;
                        insertion(a, s, n);
                        noeuds_voisins(n, v_petit, v_grand);
                        compte_position(n, c_petits, c_grands);
                        supprimer(a, s);
                end if;

                -- on traite l'éventuel point de rebroussement
                if r then
                        if (c_petits mod 2 = 1) or (c_grands mod 2 = 1) then
                                -- reconnecter le point courant verticalement aux segments voisins
                                reconnecter(t(ind).p, v_petit, v_grand, s1, s2);
                                -- on ajoute les deux segments au fichier de sortie
                                svg_line(fichier_svg, s1.p1, s1.p2, rouge);
                                svg_line(fichier_svg, s2.p1, s2.p2, rouge);
                        end if;
                end if;

        end;

begin
        -- prévention de mauvaise utilisation
        if argument_count /=2 then
                put("Il faut avoir un fichier "".in"" d'entrée et un fichier "".svg"" de sortie");
                return;
        end if;

        -- il nous faut le nombre de sommets pour pouvoir initialiser le tableau
        lecture_nb_sommets(argument(1), nb_sommets);

        declare
                tab: tab_point_seg(1..nb_sommets);
        begin

                -- partie préparatoire
                lecture_tab_point_seg(argument(1), tab);
                --Translation des points vers le carré positif du repère
                Translation_X(Tab);
                Translation_Y(Tab);
                create(file => fichier_svg, mode => out_file, name => argument(2));
                -- écriture dans le fichier de sortie
                svg_header(Fichier_Svg,tab);
                svg_polygone(fichier_svg, tab);
                -- pour pouvoir parcourir le polygone de gauche à droite, il faut trier
                -- les sommets dans l'ordre des abscisses croissantes
                sort_point_seg(tab);

                --partie algo
                -- on parcourt tous les points
                for i in tab'range loop
                        traitement_point(tab, i, arbre_res, fichier_svg);
                end loop;

                -- fermeture du fichier de sortie
                svg_footer(fichier_svg);
                close(fichier_svg);

        end;

end;
