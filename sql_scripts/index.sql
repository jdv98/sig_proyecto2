CREATE INDEX aresep_geom_index
	  ON aresep
	  USING GIST (geom);
	  
CREATE INDEX paradas_index
	ON paradas
	USING GIST (geom);

--Se filtra con la misma condicional que en la funcion de filtrado_calles
CREATE INDEX osmpr_index
	ON osmpr
	USING SPGIST (wkb_geometry)
	WHERE highway IS NOT NULL
	AND highway NOT LIKE ALL(ARRAY['%cycle%','track','steps','footway','unclassified','motorway',
							   'construction','pedestrian','corridor','road','motorway_link','tertiary_link',
								   'proposed','bridleway','raceway','bus_stop']);