/**
 * Created by Akhilesh on 2/24/2017.
 */

/* <![CDATA[ */
var weight_value = '';
var color_value = "";
var amount_value = "";
var name_value = "";

function draw2dDonut1lyrChart()
{

    $(function ()
      {
          // Create the chart
          var chartValue = document.getElementById('ceForm:twodDonutValueChart').value;
          var assetJSON = $.parseJSON(chartValue)
          var iterator = 0;
          console.log(chartValue);
          var chart = Highcharts.chart('2dDonutChart', {
                                           chart: {
                                               type: 'pie',
                                               options3d: {
                                                   enabled: true,
                                                   alpha: 0
                                               }
                                           },
                                           title: {
                                               text: ''
                                           },
                                           subtitle: {},
                                           exporting: {
                                               enabled: false
                                           }, // remove menu righ top corner
                                           credits: { // remove highchart.com righbottom corner
                                               enabled: false
                                           },
                                           legend: {
                                               layout: 'vertical',
                                               align: 'right',
                                               verticalAlign: 'top',
                                               y: 60,
                                               useHTML: true,
                                               itemMarginBottom: 10,
                                               labelFormatter: function ()
                                               {
                                                   ++iterator;
                                                   return '<div><span>' + this.name + '</span></div>';

                                               }
                                           },
                                           plotOptions: {
                                               pie: {
                                                   center: ['50%', '40%'],
                                                   size:'80%',
                                                   allowPointSelect: false,
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false
                                                   },
                                                   animation: false,
                                                   showInLegend: false,
                                                   innerSize: 200,
                                                   depth: 0
                                               },
                                               showInLegend: true,
                                               series: {
                                                   allowPointSelect: false, // remove if using details level details part
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false,
                                                       format: '{point.name}'
                                                   },
                                                   point: {
                                                       events: {
                                                           mouseOver: function (event)
                                                           {

                                                               weight_value = this.y.toFixed(0) + "%";
                                                               name_value = this.name;
                                                               amount_value = '$' +
                                                                       Highcharts.numberFormat(this.amount,
                                                                                               0, ',', ',');
                                                               color_value = this.color;

                                                               draw2dDonut1lyrChart();
                                                           },
                                                           legendItemClick: function ()
                                                           {
                                                               weight_value = this.y.toFixed(0) + "%";
                                                               name_value = this.name;
                                                               amount_value = '$' +
                                                                       Highcharts.numberFormat(this.amount,
                                                                                               0, ',', ',');
                                                               color_value = this.color;

                                                               draw2dDonut1lyrChart();
                                                               return false;
                                                           }
                                                       }
                                                   }
                                               }
                                           },

                                           tooltip: {
                                               headerFormat: '{point.name}',
                                               pointFormat: '<span style="color:{point.color}"></span><b>{point.name} - </b> <b>{point.y:.2f}%</b><br/>'
                                           },
                                           series: [{
                                               name: '',
                                               colorByPoint: true,
                                               data: assetJSON
                                           }]
                                           //	,drilldown: { // remove if display details level details only
                                           //	series: subAssetListJSON }

                                       }

                  ,
                                       function (chart)
                                       { // on complete

                                           var xpos = '50%';
                                           var ypos = '50%';
                                           var circleradius = 400;

                                           // Render the circle

                                           /*chart.renderer.circle(xpos, ypos, circleradius).attr({
                                            fill: '#000',
                                            innerSize: '80%'
                                            }).add();*/

                                           // Render the text
                                           var r = this.renderer,
                                                   x = this.series[0].center[0] + this.plotLeft,
                                                   y = this.series[0].center[1] + this.plotTop;

                                           chart.renderer.text('<span text-anchor="middle" style="text-anchor:middle; font-size: 14px;">' + name_value + '</span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 20px;font-weight: bold;"> </span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 14px;">' + weight_value + '</span>', x, y - 20).css({
                                                                                                                                                                                                                                                                                                                                                                                                                     width: circleradius * 2,
                                                                                                                                                                                                                                                                                                                                                                                                                     color: color_value,
                                                                                                                                                                                                                                                                                                                                                                                                                     textAlign: 'center'
                                                                                                                                                                                                                                                                                                                                                                                                                 }).attr({
                                                                                                                                                                                                                                                                                                                                                                                                                             zIndex: 999
                                                                                                                                                                                                                                                                                                                                                                                                                         }).add();
                                       }
          );
          weight_value = "";name_value="";amount_value="";
      });
}
function draw2dDonut1lyrChartDyna(vForm)
{

    $(function ()
      {
          // Create the chart
          var chartValue = '';
          var vChrtId='2dDonutChart';
          if(vForm=='ceForm'){
              chartValue==document.getElementById('ceForm:twodDonutValueChart').value;
          }else if(vForm=='uobIndxform'){
              chartValue=document.getElementById('uobIndxform:twodDonutValueChart').value;
          }else if(vForm=='idOverviewFrm'){
              chartValue=document.getElementById('idOverviewFrm:idAccrdPnl:twodDonutValueChart').value;
          }else if(vForm=='CNFPrflo')
          {
              chartValue = document.getElementById('ceForm:twodDonutValueChartCnf').value;
              vChrtId='2dDonutChartCnf';
          }
          console.log("Hellloo1 "+vForm);
          console.log("vChrtId "+vChrtId);


          var assetJSON = $.parseJSON(chartValue)
          var iterator = 0;
          console.log(chartValue);
          var chart = Highcharts.chart(vChrtId, {
                                           chart: {
                                               type: 'pie',
                                               options3d: {
                                                   enabled: true,
                                                   alpha: 0
                                               }
                                           },
                                           title: {
                                               text: ''
                                           },
                                           subtitle: {},
                                           exporting: {
                                               enabled: false
                                           }, // remove menu righ top corner
                                           credits: { // remove highchart.com righbottom corner
                                               enabled: false
                                           },
                                           legend: {
                                               layout: 'vertical',
                                               align: 'right',
                                               verticalAlign: 'top',
                                               y: 60,
                                               useHTML: true,
                                               itemMarginBottom: 10,
                                               labelFormatter: function ()
                                               {
                                                   ++iterator;
                                                   return '<div><span>' + this.name + '</span></div>';

                                               }
                                           },
                                           plotOptions: {
                                               pie: {
                                                   center: ['50%', '40%'],
                                                   size:'80%',
                                                   allowPointSelect: false,
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false
                                                   },
                                                   animation: false,
                                                   showInLegend: false,
                                                   innerSize: 200,
                                                   depth: 0
                                               },
                                               showInLegend: true,
                                               series: {
                                                   allowPointSelect: false, // remove if using details level details part
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false,
                                                       format: '{point.name}'
                                                   },
                                                   point: {
                                                       events: {
                                                           mouseOver: function (event)
                                                           {

                                                               weight_value = this.y.toFixed(0) + "%";
                                                               name_value = this.name;
                                                               amount_value ='';
                                                                       //Highcharts.numberFormat(this.amount,
                                                                       //                        0, ',', ',') ;

                                                               //amount_value =
                                                               //        Highcharts.numberFormat(this.amount,
                                                               //                                0, ',', ',')+' '+currSymbol ;
                                                               color_value = this.color;

                                                               //draw2dDonut1lyrChart();
                                                               draw2dDonut1lyrChartDyna(vForm);
                                                           },
                                                           legendItemClick: function ()
                                                           {
                                                               weight_value = this.y.toFixed(0) + "%";
                                                               name_value = this.name;
                                                               amount_value ='';
                                                                       //Highcharts.numberFormat(this.amount,
                                                                       //                        0, ',', ',');
                                                               //amount_value = '$' +
                                                               //        Highcharts.numberFormat(this.amount,
                                                               //                                0, ',', ',');
                                                               color_value = this.color;

                                                               //draw2dDonut1lyrChart();
                                                               draw2dDonut1lyrChartDyna(vForm);
                                                               return false;
                                                           }
                                                       }
                                                   }
                                               }
                                           },

                                           tooltip: {
                                               headerFormat: '{point.name}',
                                               pointFormat: '<span style="color:{point.color}"></span><b>{point.name} - </b> <b>{point.y:.2f}%</b><br/>'
                                           },
                                           series: [{
                                               name: '',
                                               colorByPoint: true,
                                               data: assetJSON
                                           }]
                                           //	,drilldown: { // remove if display details level details only
                                           //	series: subAssetListJSON }

                                       }

                  ,
                                       function (chart)
                                       { // on complete

                                           var xpos = '50%';
                                           var ypos = '50%';
                                           var circleradius = 400;

                                           // Render the circle

                                           /*chart.renderer.circle(xpos, ypos, circleradius).attr({
                                            fill: '#000',
                                            innerSize: '80%'
                                            }).add();*/

                                           // Render the text
                                           var r = this.renderer,
                                                   x = this.series[0].center[0] + this.plotLeft,
                                                   y = this.series[0].center[1] + this.plotTop;

                                           chart.renderer.text('<span text-anchor="middle" style="text-anchor:middle; font-size: 14px;">' + name_value + '</span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 20px;font-weight: bold;"> </span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 14px;">' + weight_value + '</span>', x, y - 20).css({
                                                                                                                                                                                                                                                                                                                                                                                                                     width: circleradius * 2,
                                                                                                                                                                                                                                                                                                                                                                                                                     color: color_value,
                                                                                                                                                                                                                                                                                                                                                                                                                     textAlign: 'center'
                                                                                                                                                                                                                                                                                                                                                                                                                 }).attr({
                                                                                                                                                                                                                                                                                                                                                                                                                             zIndex: 999
                                                                                                                                                                                                                                                                                                                                                                                                                         }).add();
                                       }
          );
          weight_value = "";name_value="";amount_value="";
      });
}
/* ]]> */




function draw2dDonut1lyrChartClassBase(vDivClass,vValClass)
{
try{
    $(function ()
      {
          // Create the chart
    	debugger;
          var chartValue = $('.'+vValClass).val();
          var vChrtId=$('.'+vDivClass).attr('id');
          
          
//          if(vForm=='ceForm'){
//              chartValue==document.getElementById('ceForm:twodDonutValueChart').value;
//          }else if(vForm=='uobIndxform'){
//              chartValue=document.getElementById('uobIndxform:twodDonutValueChart').value;
//          }else if(vForm=='idOverviewFrm'){
//              chartValue=document.getElementById('idOverviewFrm:idAccrdPnl:twodDonutValueChart').value;
//          }else if(vForm=='CNFPrflo')
//          {
//              chartValue = document.getElementById('ceForm:twodDonutValueChartCnf').value;
//              vChrtId='2dDonutChartCnf';
//          }
          console.log("draw2dDonut1lyrChartDyna Chart Div "+ vChrtId);
          console.log("draw2dDonut1lyrChartDyna Chart Value "+ chartValue);


          var assetJSON = $.parseJSON(chartValue)
          var iterator = 0;
          console.log(chartValue);
          var chart = Highcharts.chart(vChrtId, {
                                           chart: {
                                               type: 'pie',
                                               options3d: {
                                                   enabled: true,
                                                   alpha: 0
                                               }
                                           },
                                           title: {
                                               text: ''
                                           },
                                           subtitle: {},
                                           exporting: {
                                               enabled: false
                                           }, // remove menu righ top corner
                                           credits: { // remove highchart.com righbottom corner
                                               enabled: false
                                           },
                                           legend: {
                                               layout: 'vertical',
                                               align: 'right',
                                               verticalAlign: 'top',
                                               y: 60,
                                               useHTML: true,
                                               itemMarginBottom: 10,
                                               labelFormatter: function ()
                                               {
                                                   ++iterator;
                                                   return '<div><span>' + this.name + '</span></div>';

                                               }
                                           },
                                           plotOptions: {
                                               pie: {
                                                   center: ['50%', '40%'],
                                                   size:'80%',
                                                   allowPointSelect: false,
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false
                                                   },
                                                   animation: false,
                                                   showInLegend: false,
                                                   innerSize: 200,
                                                   depth: 0
                                               },
                                               showInLegend: true,
                                               series: {
                                                   allowPointSelect: false, // remove if using details level details part
                                                   cursor: 'pointer',
                                                   dataLabels: {
                                                       enabled: false,
                                                       format: '{point.name}'
                                                   }
                                               }
                                           },

                                           tooltip: {
                                               headerFormat: '{point.name}',
                                               pointFormat: '<span style="color:{point.color}"></span><b>{point.name} - </b> <b>{point.y:.2f}%</b><br/>'
                                           },
                                           series: [{
                                               name: '',
                                               colorByPoint: true,
                                               data: assetJSON
                                           }]
                                           //	,drilldown: { // remove if display details level details only
                                           //	series: subAssetListJSON }

                                       }

                  ,
                                       function (chart)
                                       { // on complete

                                           var xpos = '50%';
                                           var ypos = '50%';
                                           var circleradius = 400;

                                           // Render the circle

                                           /*chart.renderer.circle(xpos, ypos, circleradius).attr({
                                            fill: '#000',
                                            innerSize: '80%'
                                            }).add();*/

                                           // Render the text
                                           var r = this.renderer,
                                                   x = this.series[0].center[0] + this.plotLeft,
                                                   y = this.series[0].center[1] + this.plotTop;

                                           chart.renderer.text('<span text-anchor="middle" style="text-anchor:middle; font-size: 14px;">' + name_value + '</span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 20px;font-weight: bold;"> </span><br><span text-anchor="middle" style="text-anchor:middle;font-size: 14px;">' + weight_value + '</span>', x, y - 20).css({
                                                                                                                                                                                                                                                                                                                                                                                                                     width: circleradius * 2,
                                                                                                                                                                                                                                                                                                                                                                                                                     color: color_value,
                                                                                                                                                                                                                                                                                                                                                                                                                     textAlign: 'center'
                                                                                                                                                                                                                                                                                                                                                                                                                 }).attr({
                                                                                                                                                                                                                                                                                                                                                                                                                             zIndex: 999
                                                                                                                                                                                                                                                                                                                                                                                                                         }).add();
                                       }
          );
          weight_value = "";name_value="";amount_value="";
      });
}catch(e){
	console.log("draw2dDonut1lyrChartClassBase Exception "+e);
}
}