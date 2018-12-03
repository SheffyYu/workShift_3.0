package com.gzport.meeting.filter;

import org.apache.shiro.SecurityUtils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.logging.Logger;

/**
 * Created by zhangxiang on 2018/11/29.
 */
public class LoginFilter implements Filter {

    private static final boolean debug = false;

    private static final Logger LOG = Logger.getLogger(LoginFilter.class.getName());

    private FilterConfig filterConfig = null;


    public void log(String msg) {
        LOG.info(msg);
    }


    private String parsePermission(HttpServletRequest request) {
        if ("".equals(request.getContextPath())) {
            return request.getRequestURI().substring(1).replace("/", ":");
        } else {
            return request.getRequestURI().replace(request.getContextPath() + "/", "").replace("/", ":");
        }
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoginFilter:DoBeforeProcessing");
        }
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("LoginFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed.
	/*
         for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
         String name = (String)en.nextElement();
         Object value = request.getAttribute(name);
         log("attribute: " + name + "=" + value.toString());

         }
         */
        // For example, a filter might append something to the response.
	/*
         PrintWriter respOut = new PrintWriter(response.getWriter());
         respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }


    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
        if (debug) {
            log("LoginFilter:doFilter()");
        }
        doBeforeProcessing(request, response);
        HttpServletResponse hResponse = (HttpServletResponse) response;
        // 编码
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");


        if (!SecurityUtils.getSubject().isAuthenticated()) {
            HttpServletRequest hrequest=(HttpServletRequest) request;
        	String url=hrequest.getRequestURL().toString();
        	System.err.println("url========"+url);
//        	if(url.contains("/wx/")){
//        		hResponse.sendRedirect(request.getServletContext().getContextPath() + "/wx/init/login");
//        		return;
//        	}else{
//        	}
//            hResponse.sendRedirect(request.getServletContext().getContextPath() + "/index.html");
            PrintWriter out = hResponse.getWriter();
            out.println("<html>");
            out.println("<script>");
            out.println("window.open('" + request.getServletContext().getContextPath() + "/index.html','_top');");
            out.println("</script>");
            out.println("</html>");
            return;
        }
        final HttpServletRequest hRequest = (HttpServletRequest) request;
        String title = hRequest.getHeader("hdTabTitle");
        final String permission = parsePermission(hRequest);
        String isAccessed = "1";
        if (isAccessed.equals("0")) {
            return;
        }
        Throwable problem = null;
        try {
            filterChain.doFilter(request, response);
        } catch (Throwable t) {
            // If an exception is thrown somewhere down the filter chain,
            // we still want to execute our after processing, and then
            // rethrow the problem after that.
            problem = t;
            t.printStackTrace();
        }

        doAfterProcessing(request, response);

        // If there was a problem, we want to rethrow it if it is
        // a known type, otherwise log it.
        if (problem != null) {
            if (problem instanceof ServletException) {
                throw (ServletException) problem;
            }
            if (problem instanceof IOException) {
                throw (IOException) problem;
            }
            sendProcessingError(problem, response);
        }
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);
        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    @Override
    public void destroy() {

    }
}
