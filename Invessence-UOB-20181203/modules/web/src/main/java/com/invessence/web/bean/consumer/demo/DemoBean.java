package com.invessence.web.bean.consumer.demo;

import java.util.*;
import javax.annotation.PostConstruct;
import javax.faces.bean.*;

import com.invessence.web.bean.consumer.PortfolioCreationUI;
import org.primefaces.model.chart.MeterGaugeChartModel;

/**
 * Created by prashant on 12/14/2017.
 */
@ManagedBean(name="demoBean")
@SessionScoped
public class DemoBean extends PortfolioCreationUI
{
   private MeterGaugeChartModel meterGauge;

   @PostConstruct
   public void init() {
      createMeterGaugeModels();
   }

   public MeterGaugeChartModel getMeterGauge() {
      return meterGauge;
   }

   private MeterGaugeChartModel initMeterGaugeModel() {
      List<Number> intervals = new ArrayList<Number>(){{
         add(20);
         add(50);
         add(120);
         add(220);
      }};

      return new MeterGaugeChartModel(140, intervals);
   }

   private void createMeterGaugeModels() {
      meterGauge = initMeterGaugeModel();
      // meterGauge.setTitle("Risk");
      meterGauge.setSeriesColors("66cc66,93b75f,E7E658,cc6666");
      meterGauge.setGaugeLabel("Risk");
      meterGauge.setGaugeLabelPosition("bottom");
      meterGauge.setShowTickLabels(false);
      // meterGauge.setLabelHeightAdjust(110);
      meterGauge.setIntervalOuterRadius(20);
   }

}
