select row_to_json(featurecollection)
  from (select 'FeatureCollection' as type, array_to_json(array_agg(feature)) as features
    from (
      select 'Feature' as type,
      st_asgeojson(neighborhoods.geom)::json
      as geometry
      from neighborhoods)
    as feature)
as featurecollection;
