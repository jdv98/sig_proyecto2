/*
Agrega el costo de las rutas
*/
CREATE OR REPLACE FUNCTION add_cost_osmpr()
RETURNS VARCHAR
AS $$
BEGIN
	WITH filtrado AS (
		SELECT distinct os.ogc_fid,os.wkb_geometry FROM osm_aresep oa
		JOIN osmpr os
		ON os.ogc_fid=oa.osm_id
	)
	UPDATE public.osmpr os
	SET cost = ST_Length(filtrado.wkb_geometry)
	FROM filtrado
		WHERE filtrado.ogc_fid = os.ogc_fid;
	RETURN 'Finalizado';
END
$$ language plpgsql;




/*
Retorna la informacion del dijkstra y las rutas para mostarlas en leaflet
*/
CREATE OR REPLACE FUNCTION dijkstra(inicio int,destino int)
returns table(
	dijkstra json,
	ruta jsonb
)
AS $$
DECLARE
	id_inicio int;
	id_destino int;
	v_dijkstra json;
	v_ruta jsonb;
BEGIN
	SELECT osmvert.id INTO id_inicio FROM osmpr_vertices_pgr osmvert
	JOIN paradas pa
	ON ST_DWITHIN(pa.geom,osmvert.the_geom,0.00015)
	WHERE pa.id=inicio
	LIMIT 1;
	
	SELECT osmvert.id INTO id_destino FROM osmpr_vertices_pgr osmvert
	JOIN paradas pa
	ON ST_DWITHIN(pa.geom,osmvert.the_geom,0.00015)
	WHERE pa.id=destino
	LIMIT 1;
	
	SELECT json_agg(to_json(row)) INTO v_dijkstra
	FROM (
		SELECT * FROM 
		pgr_dijkstra('SELECT ogc_fid as id, source, target, cost FROM osmpr WHERE source IS NOT NULL',
					 id_inicio,id_destino,FALSE)
	) row;
	
	
	SELECT jsonb_agg(feature) into v_ruta
	FROM (
	  SELECT ST_AsGeoJSON(geom)::jsonb AS feature
	  FROM (SELECT osm.ogc_fid as id,osm.wkb_geometry as geom,osm.name as nombre FROM osmpr as osm
		JOIN json_array_elements(v_dijkstra) as vdijk
		ON (vdijk.value::JSON->>'edge')::int =osm.ogc_fid) row) features;
	
	return QUERY SELECT v_dijkstra,v_ruta;
  
END
$$ language plpgsql;

--SELECT * FROM dijkstra(27,20);


