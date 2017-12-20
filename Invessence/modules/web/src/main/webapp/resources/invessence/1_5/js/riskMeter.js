
function myGaugeChart(vMeterVal,vMin,vMax,vLableTop,vLableBottom)	{
	try{
		debugger
		vMeterVal=parseInt(vMeterVal);
		console.log('vMeterVal~~> '+vMeterVal);
		console.log('vMin '+vMin);
		console.log('vMax '+vMax);
		console.log('vLableTop '+vLableTop);
		console.log('vLableBottom '+vLableBottom);
		var gaugeOptions = {

			chart: {
				type: 'solidgauge'
			},

			title: null,

			pane: {
				center: ['50%', '85%'],
				size: '140%',
				startAngle: -90,
				endAngle: 90,
				background: {
					backgroundColor:  '#EEE',
					innerRadius: '60%',
					outerRadius: '100%',
					shape: 'arc'
				}
			},

			tooltip: {
				enabled: false
			},

			// the value axis
			yAxis: {
				stops: [
					[0.1, '#55BF3B'], // green
					[0.5, '#DDDF0D'], // yellow
					[0.9, '#DF5353'] // red
				],
				lineWidth: 0,
				minorTickInterval: null,
				tickAmount: 2,
				title: {
					y: -30
				},
				labels: {
					y: 12
				}
			},

			plotOptions: {
				solidgauge: {
					dataLabels: {
						y: 5,
						borderWidth: 0,
						useHTML: true
					}
				}
			}
		};

		// The speed gauge
		var chartSpeed = Highcharts.chart('container-speed', Highcharts.merge(gaugeOptions, {
			yAxis: {
				min: vMin,
				max: vMax,
				title: {
					text: vLableTop
				},
				labels: {
					distance: -10,
					//rotation: 'auto'
				}
			},

			credits: {
				enabled: false
			},

			series: [{
				name: vLableTop,
				data: [vMeterVal],
				dataLabels: {
					format: '<div style="text-align:center;float:bottom;margin-bottom:-100px"><span style="font-size:11px;color:black">{y}</span><br/>' +
					'<span style="font-size:10px;color:black">'+vLableBottom+'</span></div>'
				},
				tooltip: {
					valueSuffix: vLableBottom
				}
			}]

		}));


	}catch(e){
		console.error('Exception '+e);
	}
}