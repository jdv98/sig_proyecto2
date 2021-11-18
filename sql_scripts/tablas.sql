/*
1-Create la tabla para las paradas y tablas intermedias
2-Antes de ejecutarlo se debe cargar la informacion de la aresep y osm
*/
alter table osmpr add cost double precision;
alter table osmpr add source int;
alter table osmpr add target int;

CREATE TABLE  paradas(
    id SERIAL PRIMARY KEY,
    nombre varchar(40),
    ciudad varchar(30),
    geom GEOMETRY(POINT, 4326)
);

CREATE TABLE parada_aresep(
	aresep_id INT,
	parada_id INT,
	CONSTRAINT fk_aresep
   FOREIGN KEY(aresep_id) 
      REFERENCES aresep(objectid_1),
	CONSTRAINT fk_parada
   FOREIGN KEY(parada_id) 
      REFERENCES paradas(id)
);

CREATE TABLE osm_aresep(
	aresep_id INT,
	osm_id INT,
	CONSTRAINT fk_aresep
   FOREIGN KEY(aresep_id) 
      REFERENCES aresep(objectid_1),
	CONSTRAINT fk_osm
   FOREIGN KEY(osm_id) 
      REFERENCES osmpr(ogc_fid)
);