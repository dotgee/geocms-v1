L.Polygon.Draw = L.Polyline.Draw.extend({
	Poly: L.Polygon,
	
	type: 'polygon',

	options: {
		shapeOptions: {
			stroke: true,
			color: '#f06eaa',
			weight: 4,
			opacity: 0.5,
			fill: true,
			fillColor: null, //same as color by default
			fillOpacity: 0.2,
			clickable: false
		}
	},

	_updateMarkerHandler: function () {
		// The first marker shold have a click handler to close the polygon
		if (this._markers.length === 1) {
			this._markers[0].on('click', this._finishShape, this);
		}
	},

	_getLabelText: function () {
		var text;
		if (this._markers.length === 0) {
			text = 'Cliquer pour commencer le trac\351.';
		} else if (this._markers.length < 3) {
			text = 'Cliquer pour rajouter un point au trac\351.';
		} else {
			text = 'Cliquer sur le premier point pour finir le trac\351.';
		}
		return {
			text: text
		};
	},

	_shapeIsValid: function () {
		return this._markers.length >= 3;
	},

	_vertexAdded: function (latlng) {
		//calc area here
	},

	_cleanUpShape: function () {
		if (this._markers.length > 0) {
			this._markers[0].off('click', this._finishShape);
		}
	}
});

L.Polygon.prototype.areaInMeters = function () {
  var area = 0;

  if(!this._latlngs.length >= 3){
    return 0;
  }

  var x1 = this._latlngs[0],
      x2 = this._latlngs[1];
  var scale = Math.sqrt(Math.pow(x2.lng - x1.lat, 2) + Math.pow(x1.lat - x2.lng, 2));  
  var dist = x1.distanceTo(x2).toFixed(); 
  
  for(var i = 0, length = this._latlngs.length; i < length; i++){
    var m1 = this._latlngs[i];
    var m2 = (i == length -1) ?  this._latlngs[0] : this._latlngs[i];
    area += ((m1.lng * m2.lat) - (m1.lat * m2.lng));  
  }
  var realArea = Math.pow((dist*area/scale),2);
  console.log(realArea);
  return realArea / 2.0;
}
