/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 1/19/14
 * Time: 6:18 PM
 * To change this template use File | Settings | File Templates.
 */

function ltam_pie()
{
    this.cfg.grid = {
        backgroundColor: 'transparent',
        drawBorder: false,
        shadow: false
    };

    this.cfg.legend = {
	show:true, 
	rendererOptions: {numberRows: 1}, 
	location: 's', 
	placement: 'outsideGrid'
    };

    this.cfg.highlighter = {
        show: false
    };
}

function ltam_pos_pie()
{
    this.cfg.grid = {
        backgroundColor: 'transparent',
        drawBorder: false,
        shadow: false
    };

    this.cfg.legend = {
        show:false
    };

    this.cfg.highlighter = {
        show: false
    };
}

function ltam_perf()
{
    this.cfg.grid = {
        backgroundColor: 'transparent',
        drawBorder: false,
        shadow: false
    };

    this.cfg.axesDefaults = {
        axes: {
            xaxis: {
                renderer: {
                    tickOptions: {
                        labelPosition: 'middle',
                        angle: 15
                    }
                }
            }
        }
    };
}

function ltam_riskq5()
{
    this.cfg.grid = {
        backgroundColor: 'transparent',
        drawBorder: false,
        shadow: false
    };

    this.cfg.axesDefaults = {
        axes: {
            xaxis: {
                renderer: {
                    tickOptions: {
                        labelPosition: 'middle'
                    }
                }
            }
         }
    };

    /*
     this.cfg.seriesDefaults = {
     show: true,     // whether to render the series.
     showMarker: true
     }
     */
}

