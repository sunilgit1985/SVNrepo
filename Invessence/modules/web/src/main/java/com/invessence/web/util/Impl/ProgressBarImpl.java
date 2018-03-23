package com.invessence.web.util.Impl;

import java.io.Serializable;
import java.util.*;

import com.invessence.web.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 7/14/15
 * Time: 10:42 AM
 * To change this template use File | Settings | File Templates.
 */
public class ProgressBarImpl implements Serializable, ProgressBar
{
   final static Double maxProgress = 100.0;
   private Double progressBar;
   private Double increment;
   private Boolean active;
   private Boolean disabled;

   public ProgressBarImpl()
   {
      progressBar = null;
      increment = 0.0;
      active = true;
      disabled = true;
   }

   public ProgressBarImpl(Double start)
   {
      progressBar = start;
      increment = 1.0;
      active = false;
      disabled = false;
   }

   public ProgressBarImpl(Double start, Double increment)
   {
      progressBar = start;
      this.increment = increment;
      active = false;
      disabled = false;
   }

   @Override
   public void initProgressBar(){
      // This is to reset to start.  Leave increment to default.
      progressBar = 0.0;
      active = false;
      disabled = false;
   }

   @Override
   public Double getProgressBar() {
      return ((progressBar == null) ? 0.0 : progressBar);
   }

   @Override
   public void setProgressBar(Double progress) {
      progressBar = progress;
   }


   @Override
   public Boolean isActive() {
      return active;
   }

   @Override
   public Boolean isDisabled() {
      return disabled;
   }

   @Override
   public void setActive(Boolean status) {
      active = status;
   }

   @Override
   public void setDisabled(Boolean status) {
      disabled = status;
   }

   // This is done for Primefaces components
   @Override
   public Boolean getActive() {
      return isActive();
   }

   // This is done for Primefaces components
   @Override
   public Boolean getDisabled() {
      return isDisabled();
   }

   @Override
   public Double getIncrement()
   {
      return increment;
   }

   @Override
   public void setIncrement(Double increment)
   {
      this.increment = increment;
   }

   @Override
   public Double nextProgress(){
      progressBar = ((progressBar + increment) > maxProgress) ? maxProgress : progressBar + increment;
      return progressBar;
   }

   @Override
   public Double previousProgress(){
      progressBar = ((progressBar - increment) < 0.0) ? 0.0 : progressBar - increment;
      return progressBar;
   }

   @Override
   public Double markCompleted(){
      progressBar = maxProgress;
      return progressBar;
   }


}
