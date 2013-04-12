var  system = require('system'),
    webpage = require('webpage')
    page = webpage.create();

var url = system.args[1],
    file_name = system.args[2],
    time_name = "ContexteGeneration"
    time = new Date();

function getMapPic(url){
  page.onResourceReceived = function(response){
    console.log(response.contentType)
  }
  page.onError = function(msg, trace){

  }
  page.viewportSize = { width: 1000, height: 630 };
  page.open(url, generatePic)

}

function generatePic(status){
  page.evaluate(function(){
    $('.navbar, .leaflet-control').hide();

  });
  console.log(new Date() - time / 1000)
  window.setTimeout(function(){
    console.log('render to '+ file_name);
    page.render(file_name);
    phantom.exit();
  }, 1000);
}
getMapPic(url);
