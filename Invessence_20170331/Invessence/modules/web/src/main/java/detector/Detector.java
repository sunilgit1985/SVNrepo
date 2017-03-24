//package detector;
//
///**
// * Created by abhangp on 12/20/2016.
// */
//import fiftyone.mobile.detection.BaseDeviceInfo;
//import fiftyone.mobile.detection.Provider;
//import java.io.Serializable;
//import java.util.Map;
//import javax.faces.bean.ApplicationScoped;
//import javax.faces.bean.ManagedBean;
//import javax.faces.context.FacesContext;
//import javax.servlet.http.HttpServletRequest;
//
//@ManagedBean
//@ApplicationScoped
//public class Detector {
//
//   //Analyses the detection made in Detector and determines if the device is mobile.
//   public String getIsMobile() {
//      FacesContext context = FacesContext.getCurrentInstance();
//      Provider p =
//         (Provider) context.getExternalContext().getApplicationMap().get("51Degrees.mobi");
//
//      if (p != null) {
//         BaseDeviceInfo b =
//            p.getDeviceInfo(((HttpServletRequest)context.getExternalContext().getRequest()));
//         if (b != null) {
//            if (b.getFirstPropertyValue("IsMobile").equalsIgnoreCase("True")) {
//               return "Is mobile";
//            } else {
//               return "Isn't mobile";
//            }
//         }
//      }
//      return "Unknown";
//   }
//}
