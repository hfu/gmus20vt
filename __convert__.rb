require 'find'
require './_config_.rb'

targets = []
Find.find("../#{$source}/") {|path|
  next unless path.end_with?('shp')
  target = File.basename(path.sub(/_.*?shp/, ''))
  targets << target
  print "rm -f #{target}.geojson\n"
  print "ogr2ogr -f GeoJSON #{target}.geojson #{path}\n"
  print "../tippecanoe/tippecanoe --maximum-zoom=8 -f -o #{target}.mbtiles -n #{target} -l #{target} #{target}.geojson\n"
}
