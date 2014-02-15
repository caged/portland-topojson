-- SELECT row_to_json(featurecollection)
-- FROM
--   (SELECT 'FeatureCollection' AS TYPE,
--           array_to_json(array_agg(feature)) AS features
--    FROM
--      (SELECT 'Feature' AS TYPE,
--              st_asgeojson(st_intersection(neighborhoods.geom, layer.geom))::json as geometry,
--              row_to_json(
--                            (SELECT props
--                             FROM
--                               (SELECT year_built, layer.gid) AS props)) AS properties
--       FROM buildings AS layer
--       INNER JOIN neighborhoods ON st_intersects(neighborhoods.geom, layer.geom)
--       WHERE neighborhoods.gid = %NEIGHBORHOOD_GID% ) AS feature) AS featurecollection;

SELECT
     st_asgeojson(st_intersection(water.geom, osm_polygons.geom)) as geometry
FROM osm_polygons
INNER JOIN water ON st_intersects(water.geom, osm_polygons.geom)
WHERE st_intersects(water.geom, osm_polygons.geom)
  AND osm_polygons.place='city'
  AND osm_polygons.name='Portland';

