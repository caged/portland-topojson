select row_to_json(featurecollection)
  from (select 'FeatureCollection' as type, array_to_json(array_agg(feature)) as features
    from (
      select 'Feature' as type,
      st_asgeojson(osm_polygons.geom)::json as geometry,
      '{}'::json as properties
      from osm_polygons
      where osm_polygons.place='city'
      and osm_polygons.name='Portland')
    as feature)
as featurecollection;
