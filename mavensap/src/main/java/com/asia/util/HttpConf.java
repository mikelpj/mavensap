package com.asia.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 名称：接口配置类
 * 功能：配置类
 * 类属性：公共类
 * 版本：1.0
 */

public class HttpConf {

	 // 版本号
    public final static String  version     = "1.0.0";

    // 编码方式
    public final static String  charset     = "UTF-8";

    private static Properties   config;

    static {
        config = new Properties();
        InputStream in = HttpConf.class.getResourceAsStream("/interfaceurl.properties");       
        try {
            config.load(in);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /* 接口BASEURL */
    private final static String BASE_URL    = config.getProperty("baseurl");

    // 加密方式
    public final static String  signType    = "MD5";

    // 密钥和接口服务器配置一样
    public final static String  securityKey = config.getProperty("securityKey");

    // 签名
    public final static String  sign        = "sign";
    
    public final static String appkey    = config.getProperty("appkey");

    // public final static String encryptype = "encryptype";

    // 获取方法名
    public static String getMethod(String methodkey) {
        return config.getProperty(methodkey);
    }
    //获取接口地址
    public static String getInterfaceUrl(String urlKey) {
        return config.getProperty(urlKey);
    }


    // 组装请求报文
    public final static String[] reqVo = new String[]{"apptx", "timestamp", "method", "appkey", "msg"};
    // 组装返回报文
    public final static String[] rspVo = new String[]{"apptx", "timestamp", "method", "appkey", "returninfo"};
    
    public final static String[] reqEcAopVo = new String[]{"method", "appkey", "apptx", "timestamp", "bizkey","msg"};
}
