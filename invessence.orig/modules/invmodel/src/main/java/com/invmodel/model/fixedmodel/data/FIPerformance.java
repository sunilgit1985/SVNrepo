package com.invmodel.model.fixedmodel.data;

/**
 * Created with IntelliJ IDEA.
 * User: Prashant
 * Date: 7/27/15
 * Time: 12:05 PM
 * To change this template use File | Settings | File Templates.
 */
public class FIPerformance
{
   private String theme;
   private String index;
   private String indexname;
   private Integer sortorder;
   private String yearname;
   private String color;
   private Double performance;

   public FIPerformance()
   {
   }

   public FIPerformance(String theme, String index, String indexname,
                        Integer sortorder, String yearname, String color,
                        Double performance)
   {
      this.theme = theme;
      this.index = index;
      this.indexname = indexname;
      this.sortorder = sortorder;
      this.yearname = yearname;
      this.color = color;
      this.performance = performance;
   }

   public String getTheme()
   {
      return theme;
   }

   public void setTheme(String theme)
   {
      this.theme = theme;
   }

   public String getIndex()
   {
      return index;
   }

   public void setIndex(String index)
   {
      this.index = index;
   }

   public String getIndexname()
   {
      return indexname;
   }

   public void setIndexname(String indexname)
   {
      this.indexname = indexname;
   }

   public Integer getSortorder()
   {
      return sortorder;
   }

   public void setSortorder(Integer sortorder)
   {
      this.sortorder = sortorder;
   }

   public String getYearname()
   {
      return yearname;
   }

   public void setYearname(String yearname)
   {
      this.yearname = yearname;
   }

   public String getColor()
   {
      return color;
   }

   public Double getPerformance()
   {
      return performance;
   }

   public Double getPerformanceAsPercent()
   {
      return performance / 100.0;
   }

   public void setPerformance(Double performance)
   {
      this.performance = performance;
   }
}
