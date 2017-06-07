package com.asia.util;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class HttpUtils {
	
	public static boolean isIE(HttpServletRequest request){ 
		return request.getHeader("USER-AGENT").toLowerCase().contains("msie") ? true : false; 
	}

    public static void jsonOutPrint(JSONObject jsonObject, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String jsonp = request.getParameter("jsonpcallback");
        // response.setContentType("text/html;charset=UTF-8");
        if (HttpUtils.isIE (request)) {
        	response.setContentType("text/html;charset=UTF-8");
        } else {
        	response.setContentType("application/json;charset=UTF-8");
        }
        PrintWriter out = response.getWriter();
        if (jsonp == null || jsonp.equals("")) {
            out.print(jsonObject.toString());
        } else {
            out.print(jsonp + "(" + jsonObject.toString() + ")");
        }
        out.flush();
    }

    public static void jsonOutPrint(JSONArray jsonArray, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String jsonp = request.getParameter("jsonpcallback");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (jsonp == null || jsonp.equals("")) {
            out.print(jsonArray.toString());
        } else {
            out.print(jsonp + "(" + jsonArray.toString() + ")");
        }
        out.flush();
    }

    public static void jsonTreeOutPrint(JSONArray jsonArray, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String jsonp = request.getParameter("jsonpcallback");
        // response.setContentType("text/html;charset=UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
        if (jsonp == null || jsonp.equals("")) {
            out.print(jsonArray.toString());
        } else {
            out.print(jsonArray);
        }
        out.flush();
    }
}
