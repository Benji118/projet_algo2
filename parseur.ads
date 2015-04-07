with objets;
use objets;

-- le paquetage lit le fichier d'entrée et sauvegarde les informations dans un tab_point_seg (défini
-- dans objets.ads)
package parseur is

        function x_min(t :in tab_point_seg) return float;
		-- req: un tab_point_seg quelconque
		-- gar: l'abscisse minimale du tableau
		
        function y_min(t :in tab_point_seg) return float;
		-- req: un tab_point_seg quelconque
		-- gar: l'ordonnée minimale du tableau

        function x_max(t :in tab_point_seg) return float;
		-- req: un tab_point_seg quelconque
		-- gar: l'abscisse maximale du tableau
		
        function y_max(t :in tab_point_seg) return float;
		-- req: un tab_point_seg quelconque
		-- gar: l'ordonnée maximale du tableau

        -- Translate toutes les coordonnées X des points parsés pour les ramener dans le carré positif de la grille svg
        procedure translation_x(t :in out tab_point_seg);
		-- req: un tab_point_seg quelconque
		-- gar: dans le cas où un point a une abscisse négative, tous les points seront translatés 
		-- de la valeur absolue de la valeur minimale des abscisses 

        -- Translate toutes les coordonnées Y des points parsés pour les ramener dans le carré positif de la grille svg
        procedure translation_y(t :in out tab_point_seg);
		-- req: un tab_point_seg quelconque
		-- gar: dans le cas où un point a une ordonnée négative, tous les points seront translatés 
		-- de la valeur absolue de la valeur minimale des ordonnées 

        -- procédure qui lit uniquement la première ligne du fichier d'entrée
        -- on en a besoin dans le programme principal pour pouvoir initialiser le tab_point_seg
        procedure lecture_nb_sommets(nom_Fichier: in string; nb_sommets: out integer);
        -- req: un fichier qui suit le benchmark .in
        -- gar: le fichier reste inchangé, le premier nombre de la première ligne sera stocké dans nb_sommets

        -- procédure qui parse le fichier entier à partir de la deuxième ligne
        procedure lecture_tab_point_seg(nom_Fichier: in String; t: out tab_point_seg);
        -- req: un fichier qui suit le benchmar .in
        -- gar: le fichier reste inchangé, le tableau tab_point_seg contiendra tous les points du polygone
        -- et chaque point disposera des informations sur ses voisins dans le polygone

end parseur;
