/*
Inserta todas las rutas y calles que se relacionen a su vez sacandole el maximo provecho al indice
*/
CREATE OR REPLACE FUNCTION filtrado_calles()
RETURNS VARCHAR
AS $$
BEGIN
	DELETE FROM public.osm_aresep;
	
	INSERT INTO public.osm_aresep(aresep_id, osm_id)
	SELECT ar.objectid_1,osm.ogc_fid FROM (SELECT DISTINCT aresep_id FROM parada_aresep) pare
	JOIN aresep as ar
	ON ar.objectid_1=pare.aresep_id
	JOIN public.osmpr as osm
	ON ST_DWithin(osm.wkb_geometry,ar.geom,0.00027)
	WHERE osm.highway IS NOT NULL
	AND osm.highway NOT LIKE ALL(ARRAY['%cycle%','track','steps','footway','unclassified','motorway',
							   'construction','pedestrian','corridor','road','motorway_link','tertiary_link',
								   'proposed','bridleway','raceway','bus_stop']);
	
	PERFORM pgr_createTopology('osmpr',0.000014,'wkb_geometry','ogc_fid',
							  rows_where:='(SELECT true from osm_aresep oa where oa.osm_id=ogc_fid LIMIT 1)',clean:=true);
	RAISE NOTICE '--COST';
	PERFORM add_cost_osmpr();
	RETURN 'Finalizado';
END;
$$ LANGUAGE plpgsql;

SELECT filtrado_calles()