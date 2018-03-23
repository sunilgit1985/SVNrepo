package com.invessence.web.util;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 12/13/17
 * Time: 10:31 AM
 * To change this template use File | Settings | File Templates.
 */
public interface ProgressBar
{
   //Any number of final, static fields
   //Any number of abstract method declarations

   public void initProgressBar();

   public Double getProgressBar();

   public void setProgressBar(Double pageno);

   public Boolean isActive();
   public Boolean isDisabled();

   public void setActive(Boolean status);
   public void setDisabled(Boolean status);
   public Boolean getActive();
   public Boolean getDisabled();

   public Double getIncrement();
   public void setIncrement(Double increment);
   public Double nextProgress();
   public Double previousProgress();
   public Double markCompleted();



   }
