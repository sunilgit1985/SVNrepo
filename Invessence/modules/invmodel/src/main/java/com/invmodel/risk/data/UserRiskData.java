package com.invmodel.risk.data;

import com.invessence.converter.SQLData;

/**
 * Created by prashant on 11/9/2017.
 */
public class UserRiskData implements Comparable
{
   private Integer sortorder;
   private String key;
   private String answerStr;
   private Integer answerInt;
   private Double answerDouble;
   private Boolean answerBoolean;
   private String answerType;
   private Double riskScore;

   public UserRiskData()
   {
   }

   public UserRiskData(Integer sortorder, String key, String answer, String answerType, Double riskScore)
   {
      this.sortorder = sortorder;
      this.key = key;
      this.riskScore = riskScore;
      setAnswer(answer, answerType);
   }

   public UserRiskData(UserRiskData origData)
   {
      this.sortorder = origData.getSortorder();
      this.key = origData.getKey();
      this.riskScore = origData.getRiskScore();
      setAnswer(origData.getAnswerStr(), origData.getAnswerType());
   }

   public Integer getSortorder()
   {
      return sortorder;
   }

   public void setSortorder(Integer sortorder)
   {
      this.sortorder = sortorder;
   }

   public String getKey()
   {
      return key;
   }

   public void setKey(String key)
   {
      this.key = key;
   }

   public String getAnswer()
   {
      return answerStr;
   }

   public void setAnswer(String answer, String answerType)
   {
      SQLData converter = new SQLData();
      if (answerType != null) {
         if (answerType.equalsIgnoreCase("D"))
         {
            answerDouble = converter.getDoubleData(answer);
            answerInt = null;
            answerBoolean = null;
         }
         else if (answerType.equalsIgnoreCase("I")) {
            answerDouble = null;
            answerInt = converter.getIntData(answer);
            answerBoolean = null;
         }
         else if (answerType.equalsIgnoreCase("B")) {
            answerDouble = null;
            answerInt = null;
            answerBoolean = converter.getBooleanData(answer);
         }
         else {
            answerDouble = null;
            answerInt = null;
            answerBoolean = null;
         }
      }
      this.answerStr = answer;
      this.answerType = answerType;
   }

   public String getAnswerStr()
   {
      return answerStr;
   }

   public void setAnswerStr(String answerStr)
   {
      setAnswer(answerStr, "T");
   }

   public Integer getAnswerInt()
   {
      if (answerInt == null && answerDouble != null) {
         return answerDouble.intValue();
      }
      return answerInt;
   }

   public void setAnswerInt(Integer answerInt)
   {
      setAnswer(answerInt.toString(), "I");
   }

   public Double getAnswerDouble()
   {
      if (answerDouble == null && answerInt != null) {
         return answerInt.doubleValue();
      }
      return answerDouble;
   }

   public void setAnswerDouble(Double answerDouble)
   {
      setAnswer(answerDouble.toString(), "D");

   }

   public Boolean getAnswerBoolean()
   {
      return answerBoolean;
   }

   public void setAnswerBoolean(Boolean answerBoolean)
   {
      setAnswer(answerBoolean.toString(), "B");

   }

   public String getAnswerType()
   {
      return answerType;
   }

   public void setAnswerType(String answerType)
   {
      this.answerType = answerType;
   }

   public Double getRiskScore()
   {
      return riskScore;
   }

   public void setRiskScore(Double riskScore)
   {
      this.riskScore = riskScore;
   }

   @Override
   public int compareTo(Object compareData)
   {
      Integer compareSortNum = ((UserRiskData)compareData).getSortorder();
      /* For Ascending order*/
      return this.sortorder-compareSortNum;
   }
}
