package com.asia.util;

public class DataSourceContextHolder {

	
	private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>();
	
	public static final String DATASOURCE_1 = "ds1";
	public static final String DATASOURCE_2 = "ds2";
	public static final String DATASOURCE_3 = "ds3";
	public static final String DATASOURCE_4 = "ds4";
	public static final String DATASOURCE_5 = "ds4g";
	public static final String DATASOURCE_CEN1 = "dsCen1";
	
		
	public static void setDbType(String dbType){
		contextHolder.set(dbType);

	}
	
	public static String getDbType() {  
        return ((String) contextHolder.get());  
    }  
  
    public static void clearDbType() {  
        contextHolder.remove();  
    }  

}
