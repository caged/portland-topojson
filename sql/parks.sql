SELECT row_to_json(featurecollection)
FROM
  (SELECT 'FeatureCollection' AS TYPE,
          array_to_json(array_agg(feature)) AS features
   FROM
     (SELECT 'Feature' AS TYPE,
             st_asgeojson(st_intersection(st_makevalid(neighborhoods.geom), st_makevalid(layer.geom)))::json as geometry,
             row_to_json(
                           (SELECT props
                            FROM
                              (SELECT amenity, layer.gid, layer.name) AS props)) AS properties
      FROM osm_polygons AS layer
      INNER JOIN neighborhoods ON st_intersects(neighborhoods.geom, layer.geom)
      WHERE neighborhoods.gid = %NEIGHBORHOOD_GID%
        AND layer.leisure='park' ) AS feature) AS featurecollection;

