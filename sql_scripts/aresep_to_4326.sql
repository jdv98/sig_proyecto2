/*
Como aresep es más pequeña que la tabla de osmpr entonces se opta por convertir los datos de aresep a 4326
para evitar las conversiones de geometrias.
*/
ALTER TABLE aresep ADD COLUMN geom
    geometry(MultiLineString,4326);

WITH n_aresep AS (SELECT objectid_1,wkb_geometry FROM aresep)
UPDATE aresep
SET geom=st_transform(na.wkb_geometry,4326)
FROM n_aresep as na
WHERE aresep.objectid_1=na.objectid_1