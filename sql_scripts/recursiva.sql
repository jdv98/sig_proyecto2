/*
Mediante una recursividad determina cuales son las paradas que comparten ruta
y de esta manera poder decirle al dijkstra que solo busque la ruta mas corta
dentro de las rutas reales de la aresep.
*/

CREATE OR REPLACE FUNCTION parada_to_parada(inicio int,destino int,vdepth int)
RETURNS TABLE(
	r_parada_id INT,
	r_paradas INT[],
	r_rutas INT[],
	r_depth INT
)
AS $$
BEGIN
	RETURN QUERY (WITH RECURSIVE paths (parada_id, paradas,rutas,depth) AS (
			SELECT e.parada_id, ARRAY[e.parada_id],array_agg(e.aresep_id),1
			FROM public.parada_aresep as e
			where e.parada_id=inicio
			GROUP BY e.parada_id
		UNION
			SELECT p.parada_id, p.paradas || ARRAY[e.parada_id],p.rutas||ARRAY[e.aresep_id],(SELECT (p.depth+1))
			FROM public.parada_aresep as e
			JOIN paths p
				ON NOT (ARRAY[e.parada_id] <@ p.paradas)
				AND NOT (ARRAY[destino] <@ p.paradas)
			where p.depth < vdepth 
				AND (ARRAY[TRUE] <@ (SELECT array_agg(TRUE) 
					 FROM parada_aresep f 
					 WHERE e.parada_id=f.parada_id
						AND ARRAY[f.aresep_id] <@ p.rutas
					))
	)
	SELECT * FROM paths
	WHERE ARRAY[destino] <@ paradas);
END
$$ language plpgsql;

select DISTINCT ar.geom FROM parada_to_parada(21,9,3) pa
JOIN aresep ar 
ON (SELECT DISTINCT TRUE FROM unnest(pa.r_rutas) ru WHERE ar.objectid_1=ru);