package com.asia.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.TreeMap;

public class HttpMessageUtils {

    /**
     * http请求参数处理
     * 
     * @param valueVo
     * @param signType
     * @param securityKey
     * @return
     */
    public static String createReqMessage(String[] valueVo, String signType, String securityKey) {
        Map<String, String> map = new TreeMap<String, String>();
        for (int i = 0; i < HttpConf.reqVo.length; i++) {
            map.put(HttpConf.reqVo[i], valueVo[i]);
        }

        map.put("sign", signMap(map, signType, securityKey));
        map.put("signMethod", signType);

        return joinMapValue(map, '&');
    }
    /**
     * http请求参数处理 ecaop�?
     * 
     * @param valueVo
     * @param signType
     * @param securityKey
     * @return
     */
    public static String createReqMessageEcAop(String[] valueVo, String signType, String securityKey) {
        Map<String, String> map = new TreeMap<String, String>();
        for (int i = 0; i < HttpConf.reqEcAopVo.length; i++) {
            map.put(HttpConf.reqEcAopVo[i], valueVo[i]);
        }

        //map.put("sign", signMap(map, signType, securityKey));
        //map.put("signMethod", signType);

        return joinMapValue(map, '&');
    }

    /**
     * 参数签名
     * 
     * @param map
     * @param secretKey
     *            密钥
     * @return
     */
    private static String signMap(Map<String, String> map, String signMethod, String securityKey) {
        if (HttpConf.signType.equalsIgnoreCase(signMethod)) {
            String strBeforeMd5 = joinMapValue(map, '&') + md5(securityKey);
            return md5(strBeforeMd5);
        }
        return "";
    }

    private static String joinMapValue(Map<String, String> map, char connector) {
        StringBuffer b = new StringBuffer();
        Object[] keys = map.keySet().toArray();
        for (int i = 0; i < keys.length; i++) {
            String value = map.get(keys[i]);
            b.append(keys[i]);
            b.append('=');
            if (value != null) {
                b.append(value);
            }
            b.append(connector);
        }
        return b.toString();
    }

    /**
     * get the md5 hash of a string
     * 
     * @param str
     * @return
     */
    private static String md5(String str) {

        if (str == null) {
            return null;
        }

        MessageDigest messageDigest = null;

        try {
            messageDigest = MessageDigest.getInstance(HttpConf.signType);
            messageDigest.reset();
            messageDigest.update(str.getBytes(HttpConf.charset));
        } catch (NoSuchAlgorithmException e) {

            return str;
        } catch (UnsupportedEncodingException e) {
            return str;
        }

        byte[] byteArray = messageDigest.digest();

        StringBuffer md5StrBuff = new StringBuffer();

        for (int i = 0; i < byteArray.length; i++) {
            if (Integer.toHexString(0xFF & byteArray[i]).length() == 1) {
                md5StrBuff.append("0").append(Integer.toHexString(0xFF & byteArray[i]));
            } else {
                md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
            }
        }

        return md5StrBuff.toString();
    }

    /**
     * 签名验证
     * 
     * @param map
     * @param secretKey
     *            密钥
     * @return
     */
    public static boolean checkSign(String[] valueVo, String signMethod, String signature, String securityKey) {

        Map<String, String> map = new TreeMap<String, String>();
        for (int i = 0; i < HttpConf.reqVo.length; i++) {
            map.put(HttpConf.reqVo[i], valueVo[i]);
        }

        if (signature == null) {
            return false;
        }
        if (HttpConf.signType.equalsIgnoreCase(signMethod)) {
            // System.out.println(">>>" + joinMapValue(map, '&') + md5(securityKey));
            // System.out.println(">>>" + signature.equals(md5(joinMapValue(map, '&') +
            // md5(securityKey))));
            return signature.equals(md5(joinMapValue(map, '&') + md5(securityKey)));
        }
        // else {
        // return verifyWithRSA(signMethod, md5(joinMapValue(map, '&') + md5(securityKey)),
        // signature);
        // }
        return false;
    }
    
    /**
     * 给照片服务器传照�?
     * @param valueVo
     * @param signType
     * @param securityKey
     * @param photoMap
     * @return
     */
    public static String createReqMessage(String[] valueVo, String signType, String securityKey,Map photoMap) {
        Map<String, String> map = new TreeMap<String, String>();
        for (int i = 0; i < HttpConf.reqVo.length; i++) {
            map.put(HttpConf.reqVo[i], valueVo[i]);
        }

        map.put("sign", signMap(map, signType, securityKey));
        map.put("signMethod", signType);
        String pic1 = (String)photoMap.get("pic1");
        String pic2 = (String)photoMap.get("pic2");
        String pic3 = (String)photoMap.get("pic3");
        String pic4 = (String)photoMap.get("pic4");
        String pic5 = (String)photoMap.get("pic5");
        map.put("pic1", pic1);
        map.put("pic2", pic2);
        map.put("pic3", pic3);
        map.put("pic4", pic4);
        map.put("pic5", pic5);

        return joinMapValue(map, '&');
    }
    


}
