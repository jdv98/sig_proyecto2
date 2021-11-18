/*
Para reducir significativamente las rutas del aresep, se ponen paradas en puntos de inicio y final
de las rutas y así poder filtrar las rutas que se encuentren a menos de 0.00027 grados
para luego vincular estas rutas filtradas con las paradas que se encuentren a una distancia de
0.000309 de dichas paradas
*/

CREATE OR REPLACE FUNCTION insert_parada_aresep()
RETURNS VARCHAR
AS $$
BEGIN
DELETE FROM parada_aresep;

INSERT INTO public.parada_aresep(aresep_id, parada_id)
SELECT filtrado.id,pa.id FROM paradas pa
JOIN (
	SELECT DISTINCT ar.id,ar.geom FROM paradas pa  
	JOIN (SELECT ar.objectid_1 as id, ar.geom FROM aresep ar) ar  
	ON ST_DWithin(ST_STARTPOINT(ST_GeometryN(ar.geom,1)),pa.geom,0.00027)
	OR ST_DWithin(ST_ENDPOINT(ST_GeometryN(ar.geom,1)),pa.geom,0.00027)
	OR ST_DWithin(ST_STARTPOINT(ST_GeometryN(ar.geom,-1)),pa.geom,0.00027)
	OR ST_DWithin(ST_ENDPOINT(ST_GeometryN(ar.geom,-1)),pa.geom,0.00027)
) as filtrado
ON ST_DWithin(filtrado.geom,pa.geom,0.000309);

RETURN 'FINALIZADO';
END $$ LANGUAGE plpgsql;