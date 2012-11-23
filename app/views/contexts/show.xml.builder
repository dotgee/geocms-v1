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
