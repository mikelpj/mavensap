package com.asia.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.cookie.CookiePolicy;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpClientParams;
import org.apache.commons.httpclient.params.HttpConnectionManagerParams;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


public class HttpCall {

    private static Logger                      logger                   = LoggerFactory.getLogger(HttpCall.class);
    // 多线程HTTP连接管理�?
    private HttpClient                         httpClient;

    // 多线程HTTP连接管理�?
    private MultiThreadedHttpConnectionManager connectionManager;
    private int                                httpSocketTimeoutSeconds = 30;
    
    

    // 本方法是多线程调用，�?��要注意线程安全�?�?
    public Map execute(String url, String[] param, String secret) {
//        // 先将参数放入List
    	PostMethod method = null;

        try {          
            String reqmsgstr = HttpMessageUtils.createReqMessage(param, "MD5", secret);    
            

            //System.out.println("requestparam =" + reqmsgstr);
            method = new PostMethod(url);
            method.getParams().setContentCharset("UTF-8");
            String[] paramstemp = reqmsgstr.split("&");
            for (int i = 0; i < paramstemp.length; i++) {
                String[] temp = paramstemp[i].split("=");

                method.addParameter(temp[0], temp[1] == null ? "" : "" + temp[1]);           
            }
          
            //fulfillParamsters(method, paramvalues);

            HttpClientParams params = new HttpClientParams();
            params.setParameter(HttpMethodParams.SO_TIMEOUT, httpSocketTimeoutSeconds * 100000);
            params.setParameter(HttpMethodParams.COOKIE_POLICY, CookiePolicy.IGNORE_COOKIES);
            HttpConnectionManagerParams httpConnectionManagerParams = new HttpConnectionManagerParams();

            connectionManager = new MultiThreadedHttpConnectionManager();
            connectionManager.setParams(httpConnectionManagerParams);
            httpClient = new HttpClient(params, connectionManager);

            int statusCode = httpClient.executeMethod(method); // 执行POST方法
            String resultinfo = method.getResponseBodyAsString();
            logger.debug("resCode = " + statusCode); // 获取响应�?
            logger.debug("result = " + resultinfo); // 获取响应内容
            if (statusCode == HttpStatus.SC_OK) {
                Map result = new HashMap();
                result.put("state", "0");
                result.put("httpcode", "200");
                JSONObject json = JSONObject.fromObject(resultinfo);
                Iterator iter = json.keys();
                while (iter.hasNext()) {
                    String key = (String)iter.next();
                    result.put(key, json.get(key));
                }
                return result;
            } else {
                Map errresult = new HashMap();
                errresult.put("state", "1");
                JSONObject json = JSONObject.fromObject(resultinfo);
                String message = (String)json.get("detail");
                errresult.put("message", "请求错误:" + message);
                return errresult;
            }
        } catch (Exception e) {
            e.printStackTrace();
            Map errresult = new HashMap();
            errresult.put("state", "1");
            errresult.put("message", "请求错误:" + e.getMessage());
            return errresult;
        }
    }
    
    public Map executeEcAop(String url, String[] param, String secret) {
//      // 先将参数放入List
  	PostMethod method = null;

      try {          
          String reqmsgstr = HttpMessageUtils.createReqMessageEcAop(param, "MD5", secret);    
          
          logger.debug("reqmsgstr = "+reqmsgstr);;
          //System.out.println("requestparam =" + reqmsgstr);
          method = new PostMethod(url);
          method.getParams().setContentCharset("UTF-8");
          String[] paramstemp = reqmsgstr.split("&");
          for (int i = 0; i < paramstemp.length; i++) {
              String[] temp = paramstemp[i].split("=");

              method.addParameter(temp[0], temp[1] == null ? "" : "" + temp[1]);           
          }
        
          //fulfillParamsters(method, paramvalues);

          HttpClientParams params = new HttpClientParams();
          params.setParameter(HttpMethodParams.SO_TIMEOUT, httpSocketTimeoutSeconds * 100000);
          params.setParameter(HttpMethodParams.COOKIE_POLICY, CookiePolicy.IGNORE_COOKIES);
          HttpConnectionManagerParams httpConnectionManagerParams = new HttpConnectionManagerParams();

          connectionManager = new MultiThreadedHttpConnectionManager();
          connectionManager.setParams(httpConnectionManagerParams);
          httpClient = new HttpClient(params, connectionManager);

          int statusCode = httpClient.executeMethod(method); // 执行POST方法
          String resultinfo = method.getResponseBodyAsString();
          logger.debug("resCode = " + statusCode); // 获取响应�?
          logger.debug("result = " + resultinfo); // 获取响应内容
          if (statusCode == HttpStatus.SC_OK) {
              Map result = new HashMap();
              result.put("state", "0");
              result.put("httpcode", "200");
              JSONObject json = JSONObject.fromObject(resultinfo);
              Iterator iter = json.keys();
              while (iter.hasNext()) {
                  String key = (String)iter.next();
                  result.put(key, json.get(key));
              }
              return result;
          }
          else if(statusCode == 560){
        	  Map errresult = new HashMap();
              errresult.put("state", "1");
              JSONObject json = JSONObject.fromObject(resultinfo);
              String detail = (String)json.get("detail");
              String code = (String)json.get("code");
              errresult.put("detail",detail);
              errresult.put("code", code);
              errresult.put("httpcode", "500");
              logger.debug("errresult:"+errresult.toString());
              return errresult;
          }
          else if(statusCode == 600){
        	  Map errresult = new HashMap();
              errresult.put("state", "1");
              JSONObject json = JSONObject.fromObject(resultinfo);
              String detail = (String)json.get("detail");
              String code = (String)json.get("code");
              errresult.put("detail",detail);
              errresult.put("code", code);
              errresult.put("httpcode", "600");
              logger.debug("errresult:"+errresult.toString());
              logger.debug("code:"+code);
              return errresult;
        	  
          }else {
              Map errresult = new HashMap();
              errresult.put("state", "1");
              JSONObject json = JSONObject.fromObject(resultinfo);
              String detail = (String)json.get("detail");
              String code = (String)json.get("code");
              errresult.put("detail",detail);
              errresult.put("code",code);
              errresult.put("httpcode", statusCode+"");
              logger.debug("errresult:"+errresult.toString());
              return errresult;
          }
      } catch (Exception e) {
          e.printStackTrace();
          Map errresult = new HashMap();
          errresult.put("state", "1");
          errresult.put("detail", "请求错误:" + e.getMessage());
          errresult.put("code", "");
          errresult.put("httpcode", "999");
          return errresult;
      }
  }

    private void fulfillParamsters(PostMethod method, Map<String, Object> map) {

        logger.info("Request body is: " + map);
        for (Map.Entry<String, Object> entry : map.entrySet()) {
            method.addParameter(entry.getKey(),
                ((String[])entry.getValue())[0] == null ? "" : "" + ((String[])entry.getValue())[0]);
        }
    }
    
    /**
     * 照片服务�?
     * @param url
     * @param param
     * @param secret
     * @param photoMap
     * @return
     */
    public Map execute(String url, String[] param, String secret,Map photoMap) {
//      // 先将参数放入List
    	PostMethod method = null;

      try {          
          String reqmsgstr = HttpMessageUtils.createReqMessage(param, "MD5", secret,photoMap);    
     
          method = new PostMethod(url);
          method.getParams().setContentCharset("UTF-8");
          String[] paramstemp = reqmsgstr.split("&");
          for (int i = 0; i < paramstemp.length; i++) {
              String[] temp = paramstemp[i].split("=");

              method.addParameter(temp[0], temp[1] == null ? "" : "" + temp[1]);           
          }
        
          HttpClientParams params = new HttpClientParams();
          params.setParameter(HttpMethodParams.SO_TIMEOUT, httpSocketTimeoutSeconds * 100000);
          params.setParameter(HttpMethodParams.COOKIE_POLICY, CookiePolicy.IGNORE_COOKIES);
          HttpConnectionManagerParams httpConnectionManagerParams = new HttpConnectionManagerParams();

          connectionManager = new MultiThreadedHttpConnectionManager();
          connectionManager.setParams(httpConnectionManagerParams);
          httpClient = new HttpClient(params, connectionManager);

          int statusCode = httpClient.executeMethod(method); // 执行POST方法
          String resultinfo = method.getResponseBodyAsString();
          logger.debug("resCode = " + statusCode); // 获取响应�?
          logger.debug("result = " + resultinfo); // 获取响应内容
          if (statusCode == HttpStatus.SC_OK) {
              Map result = new HashMap();
              result.put("state", "0");
              result.put("httpcode", "200");
              JSONObject json = JSONObject.fromObject(resultinfo);
              Iterator iter = json.keys();
              while (iter.hasNext()) {
                  String key = (String)iter.next();
                  result.put(key, json.get(key));
              }
              return result;
          } else {
              Map errresult = new HashMap();
              errresult.put("state", "1");
              JSONObject json = JSONObject.fromObject(resultinfo);
              String message = (String)json.get("detail");
              errresult.put("message", "请求错误:" + message);
              return errresult;
          }
      } catch (Exception e) {
          e.printStackTrace();
          Map errresult = new HashMap();
          errresult.put("state", "1");
          errresult.put("message", "请求错误:" + e.getMessage());
          return errresult;
      }
  }
    
    
    public Map executeSimple(String url, String[] param, String secret) {
//      // 先将参数放入List
  	PostMethod method = null;

      try {          
          String reqmsgstr = HttpMessageUtils.createReqMessage(param, "MD5", secret);    
          

          //System.out.println("requestparam =" + reqmsgstr);
          method = new PostMethod(url);
          method.getParams().setContentCharset("UTF-8");
          String[] paramstemp = reqmsgstr.split("&");
          for (int i = 0; i < paramstemp.length; i++) {
              String[] temp = paramstemp[i].split("=");

              method.addParameter(temp[0], temp[1] == null ? "" : "" + temp[1]);           
          }
        
          //fulfillParamsters(method, paramvalues);

          HttpClientParams params = new HttpClientParams();
          params.setParameter(HttpMethodParams.SO_TIMEOUT, httpSocketTimeoutSeconds * 100000);
          params.setParameter(HttpMethodParams.COOKIE_POLICY, CookiePolicy.IGNORE_COOKIES);
          HttpConnectionManagerParams httpConnectionManagerParams = new HttpConnectionManagerParams();

          connectionManager = new MultiThreadedHttpConnectionManager();
          connectionManager.setParams(httpConnectionManagerParams);
          httpClient = new HttpClient(params, connectionManager);

          int statusCode = httpClient.executeMethod(method); // 执行POST方法
          String resultinfo = method.getResponseBodyAsString();
          logger.debug("resCode = " + statusCode); // 获取响应�?
          logger.debug("result = " + resultinfo); // 获取响应内容
          if (statusCode == HttpStatus.SC_OK) {
              Map result = new HashMap();
              result.put("state", "0");
              result.put("httpcode", "200");
              JSONObject json = JSONObject.fromObject(resultinfo);
              Iterator iter = json.keys();
              while (iter.hasNext()) {
                  String key = (String)iter.next();
                  result.put(key, json.get(key));
              }
              return result;
          } else {
              Map errresult = new HashMap();
              errresult.put("state", "1");
              JSONObject json = JSONObject.fromObject(resultinfo);
              String message = (String)json.get("detail");
              errresult.put("message", "请求错误:" + message);
              return errresult;
          }
      } catch (Exception e) {
          e.printStackTrace();
          Map errresult = new HashMap();
          errresult.put("state", "1");
          errresult.put("message", "请求错误:" + e.getMessage());
          return errresult;
      }
  }

}
