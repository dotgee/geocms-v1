xml.instruct!
xml.ViewContext(:id => @context.uuid, :version => "1.1.0", "xmlns" => "http://www.opengis.net/context", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance", "xsi:schemaLocation" => "http://www.opengis.net/context http://schemas.opengis.net/context/1.1.0/context.xsd") do
  xml.General do
    xml.BoundingBox(:SRS => "EPSG:2154", :maxx => @context.maxx, :maxy => @context.maxy, :minx => @context.minx, :miny => @context.miny)
    xml.Title @context.name
    xml.Extension do
      xml.tag!("ol:maxExtent", :maxx => @context.maxx, :maxy => @context.maxy, :minx => @context.minx, :miny => @context.miny, "xmlns:ol" => "http://openlayers.org/context")
    end
  end
  xml.LayerList do
    <Layer hidden="0" queryable="0">
      <Server service="OGC:WMS" version="1.1.1">
        <OnlineResource xlink:href="http://osm.geobretagne.fr/gwc01/service/wms" xlink:type="simple" xmlns:xlink="http://www.w3.org/1999/xlink"/>
      </Server>
      <Name>imposm:google</Name>
      <Title>OpenStreetMap</Title>
      <Abstract>carte OpenStreetMap licence CreativeCommon by-SA</Abstract>
      <MetadataURL>
        <OnlineResource xlink:href="http://wiki.openstreetmap.org/wiki/FR:OpenStreetMap_License" xlink:type="simple" xmlns:xlink="http://www.w3.org/1999/xlink"/>
      </MetadataURL>
      <FormatList>
        <Format current="1">image/png</Format>
      </FormatList>
      <StyleList>
        <Style>
          <Name/>
          <Title/>
        </Style>
      </StyleList>
      <Extension>
        <ol:maxExtent maxx="2146865.30590000004" maxy="8541697.23630000092" minx="-357823.236499999999" miny="6037008.69390000030" xmlns:ol="http://openlayers.org/context"/>
        <ol:tileSize height="256" width="256" xmlns:ol="http://openlayers.org/context"/>
        <ol:numZoomLevels xmlns:ol="http://openlayers.org/context">17</ol:numZoomLevels>
        <ol:units xmlns:ol="http://openlayers.org/context">m</ol:units>
        <ol:isBaseLayer xmlns:ol="http://openlayers.org/context">false</ol:isBaseLayer>
        <ol:displayInLayerSwitcher xmlns:ol="http://openlayers.org/context">true</ol:displayInLayerSwitcher>
        <ol:singleTile xmlns:ol="http://openlayers.org/context">false</ol:singleTile>
      </Extension>
    </Layer>
    @context.layers.each do |layer|
      xml.Layer( :hidden => "0", :queryable => "1" ) do
        xml.Server(:service => "OGC:WMS", :version => "1.1.1") do
          xml.OnlineResource("xlink:href" => layer.data_source.wms, "xlink:type" => "simple", "xmlns:xlink" => "http://www.w3.org/1999/xlink")
        end
        xml.Name layer.name
        xml.Title layer.title
        xml.Abstract layer.description
        # Missing metadata
        xml.StyleList do
          xml.Style do
            xml.Name
            xml.Title
          end
        end
        xml.FormatList do
          xml.Format("image/png", :current => 1)
        end
        xml.Extension do
          xml.tag!("ol:maxExtent", :maxx => layer.maxx, :maxy => layer.maxy, :minx => layer.minx, :miny => layer.miny, "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:numZoomLevels", 17, "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:tileSize", :height => "256", :width => "256", "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:units", "m", "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:isBaseLayer", "false", "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:displayInLayerSwitcher", "true", "xmlns:ol" => "http://openlayers.org/context")
          xml.tag!("ol:singleTile", "true", "xmlns:ol" => "http://openlayers.org/context")
        end
      end
    end
  end
end
