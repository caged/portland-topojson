SELECT row_to_json(featurecollection)
  FROM (SELECT 'FeatureCollection' as type, array_to_json(array_agg(feature)) as features
  FROM (SELECT 'Feature' as type, st_asgeojson(neighborhoods.geom)::json as geometry from neighborhoods) as feature)
AS featurecollection;
