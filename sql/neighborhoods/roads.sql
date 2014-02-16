SELECT row_to_json(featurecollection)
FROM
  (SELECT 'FeatureCollection' AS TYPE,
          array_to_json(array_cat('{}', array_agg(feature))) AS features
   FROM
     (SELECT 'Feature' AS TYPE,
             st_asgeojson(st_intersection(neighborhoods.geom, layer.geom))::json as geometry,
             row_to_json(
                           (SELECT props
                            FROM
                              (SELECT highway, layer.gid) AS props)) AS properties
      FROM osm_lines AS layer
      INNER JOIN neighborhoods ON st_intersects(neighborhoods.geom, layer.geom)
      WHERE neighborhoods.gid = %NEIGHBORHOOD_GID%
        AND layer.highway IS NOT NULL ) AS feature) AS featurecollection;

