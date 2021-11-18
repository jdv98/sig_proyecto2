--Lee todas las paradas de buses y las convierte a geojson
create or replace function paradas_geojson()
returns table(
	j jsonb
)
as $$
begin 
	return QUERY SELECT jsonb_build_object(
    'type',     'FeatureCollection',
    'features', jsonb_agg(feature)
)
FROM (
  SELECT jsonb_build_object(
    'type',       'Feature',
    'id',         id,
    'geometry',   ST_AsGeoJSON(geom)::jsonb,
    'properties', to_jsonb(row) - 'id' - 'geom'
  ) AS feature
  FROM (SELECT * FROM paradas) row) features;
END;
$$ LANGUAGE plpgsql;


  
  --Extraido de:
    ---https://gis.stackexchange.com/questions/14514/exporting-feature-geojson-from-postgis
--Usuario:
    --https://gis.stackexchange.com/users/97861/philip-attisano