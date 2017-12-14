package invtest;

import com.invmodel.asset.data.AssetClass;
import com.invmodel.inputData.ProfileData;
import com.invmodel.model.ModelUtil;
import com.invmodel.portfolio.data.Portfolio;
import com.invmodel.risk.dao.RiskFetchDAO;
import com.invmodel.risk.data.*;

/**
 * Created by prashant on 11/13/2017.
 */
public class EnumTest
{

   public enum GOALS {
      Retirement ("RETIREMENT"),
      Retired ("RETIRED"),
      Education ("Education");

      private final String goalname;

      private GOALS(String s) {goalname = s;}

      public boolean equalsName(String name) {
         // (otherName == null) check is not needed because name.equals(null) returns false
         return goalname.equalsIgnoreCase(name);
      }

      public String toString() {
         return this.goalname;
      }
   }

   public static void main(String[] args) throws Exception
   {
      GOALS objective = GOALS.Retired;
      System.out.print("Yes, I am planning for " + objective.equalsName("RETIREMENT"));

      objective = GOALS.Education;
      if (objective == GOALS.Retirement)
      {
         System.out.print("No, I am NOT planning for retirement");
      }
      else {
         System.out.print("Instead, I am planning for " + objective.toString());
      }

   }

}
