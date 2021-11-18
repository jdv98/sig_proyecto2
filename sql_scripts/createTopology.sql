/*
Crea la topologia con un filtro para reducir la cantidad y con un metro en grados.
Esta funcion se ejecuta dentro de filtrado de calles despues de crear la relacion calle-ruta.
*/
SELECT pgr_createTopology('osmpr',0.0001,'wkb_geometry','ogc_fid',rows_where:='(SELECT true from osm_aresep oa where oa.osm_id=ogc_fid LIMIT 1)',clean:=true);