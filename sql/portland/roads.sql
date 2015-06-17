SELECT row_to_json(featurecollection)
  FROM (SELECT 'FeatureCollection' as type, array_to_json(array_cat('{}', array_agg(feature))) AS features
    FROM (SELECT
      'Feature' as type,
       st_asgeojson(st_intersection(osm_lines.geom, osm_polygons.geom))::json as geometry,
       '{}'::json as properties
  FROM osm_polygons
  INNER JOIN osm_lines ON st_intersects(osm_lines.geom, osm_polygons.geom)
  WHERE st_intersects(osm_lines.geom, osm_polygons.geom)
    AND osm_polygons.place='city'
    AND osm_polygons.name='Portland') as feature) as featurecollection;
