# sig_proyecto2
Aplicación Web que le ofrece a sus usuarios información sobre las rutas de buses necesarios para trasladarse desde un punto de origen hasta un destino deseado.

----
----

# Aplicación web
1. ```npm install```
2. ```npm run build```
3. ```npm start```


----
----

# Base de datos

- Primeramente se deben agregar las [extensiones](sql_scripts/extensiones.sql) a la base de datos.
- Insertar los datos los datos de la ARESEP y OSM con el comando ```ogr2ogr -f "PostgreSQL" PG:"dbname=pr2gis user=postgres" .geojson```
- Correr el codigo en [tablas](sql_scripts/tablas.sql)
- Ejecutar [insertar_paradas_aresep](sql_scripts/insert_parada_aresep.sql) para crear la relación entre parada &harr; ruta
- [filtado_calles] se encarga de hacer la relación calles&harr;rutas además de crear la topologia y agregar el costo a las calles.