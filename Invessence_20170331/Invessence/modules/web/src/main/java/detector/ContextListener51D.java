//package detector;
//
///**
// * Created by abhangp on 12/20/2016.
// */
//   import fiftyone.mobile.detection.Provider;
//   import fiftyone.mobile.detection.binary.BinaryException;
//   import fiftyone.mobile.detection.binary.Reader;
//   import javax.servlet.ServletContextEvent;
//   import javax.servlet.ServletContextListener;
//
//public class ContextListener51D implements ServletContextListener{
//
//   @Override
//   public void contextInitialized(ServletContextEvent sce) {
//      try{
//         sce.getServletContext().setAttribute("51Degrees.mobi",Reader.create());
//      } catch (BinaryException ex){
//         sce.getServletContext().setAttribute("51Degrees.mobi",null);
//      }
//   }
//
//   @Override
//   public void contextDestroyed(ServletContextEvent sce) {
//      Provider p = (Provider) sce.getServletContext().getAttribute("51Degrees.mobi");
//      try{
//         sce.getServletContext().removeAttribute("51Degrees.mobi");
//      } finally {
//         p.destroy();
//      }
//
//   }
//}
