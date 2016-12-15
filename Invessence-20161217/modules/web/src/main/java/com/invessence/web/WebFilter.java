package com.invessence.web;
import java.io.IOException;


import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
/**
 * Created by sandeepn on 12/15/2016.
 */
@javax.servlet.annotation.WebFilter(urlPatterns ={"*.js","*.css"})
public class WebFilter implements Filter
{

   @Override
   public void init(FilterConfig filterConfig) throws ServletException
   {

   }

   @Override
   public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
      HttpServletResponse response = (HttpServletResponse) res;
      response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
      response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
      response.setDateHeader("Expires", 0); // Proxies.
      chain.doFilter(req, res);
   }

   @Override
   public void destroy()
   {

   }

   // ... (just keep init() and destroy() NO-OP)
}