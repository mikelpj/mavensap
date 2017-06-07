package com.asia.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;



/**
 * 
 *
 */
public class DataSourceRoute {
	private static final Logger logger = Logger.getLogger(DataSourceRoute.class);
	private static Map<String, String> map = null;
	
	static{
		map = new HashMap<String, String>();

		/*map.put("0391", DataSourceContextHolder.DATASOURCE_1);
		map.put("0377", DataSourceContextHolder.DATASOURCE_1);
		map.put("0376", DataSourceContextHolder.DATASOURCE_1);
		map.put("0370", DataSourceContextHolder.DATASOURCE_1);
		map.put("0399", DataSourceContextHolder.DATASOURCE_1);
		
		map.put("0379", DataSourceContextHolder.DATASOURCE_2);
		map.put("0373", DataSourceContextHolder.DATASOURCE_2);
		map.put("0374", DataSourceContextHolder.DATASOURCE_2);
		map.put("0392", DataSourceContextHolder.DATASOURCE_2);

		map.put("0393", DataSourceContextHolder.DATASOURCE_3);
		map.put("0371", DataSourceContextHolder.DATASOURCE_3);
		map.put("0378", DataSourceContextHolder.DATASOURCE_3);
		
		map.put("0396", DataSourceContextHolder.DATASOURCE_4);
		map.put("0398", DataSourceContextHolder.DATASOURCE_4);
		map.put("0395", DataSourceContextHolder.DATASOURCE_4);
		map.put("0375", DataSourceContextHolder.DATASOURCE_4);
		map.put("0372", DataSourceContextHolder.DATASOURCE_4);
		map.put("0394", DataSourceContextHolder.DATASOURCE_4);*/
		
		map.put("763", DataSourceContextHolder.DATASOURCE_1);
		map.put("777", DataSourceContextHolder.DATASOURCE_1);
		map.put("776", DataSourceContextHolder.DATASOURCE_1);
		map.put("768", DataSourceContextHolder.DATASOURCE_1);
		map.put("775", DataSourceContextHolder.DATASOURCE_1);
		
		map.put("761", DataSourceContextHolder.DATASOURCE_2);
		map.put("764", DataSourceContextHolder.DATASOURCE_2);
		map.put("765", DataSourceContextHolder.DATASOURCE_2);
		map.put("774", DataSourceContextHolder.DATASOURCE_2);

		map.put("773", DataSourceContextHolder.DATASOURCE_3);
		map.put("760", DataSourceContextHolder.DATASOURCE_3);
		map.put("762", DataSourceContextHolder.DATASOURCE_3);
		
		map.put("771", DataSourceContextHolder.DATASOURCE_4);
		map.put("772", DataSourceContextHolder.DATASOURCE_4);
		map.put("766", DataSourceContextHolder.DATASOURCE_4);
		map.put("769", DataSourceContextHolder.DATASOURCE_4);
		map.put("767", DataSourceContextHolder.DATASOURCE_4);
		map.put("770", DataSourceContextHolder.DATASOURCE_4);
	}
	
	/**
	 * 
	 * @param custEparchyCode 
	 * @return
	 */
	public static String dbType(String custEparchyCode){
		if(custEparchyCode == null || "".equals(custEparchyCode))
			return DataSourceContextHolder.DATASOURCE_3;
		logger.debug("---------------------"+map.get(custEparchyCode));
		return map.get(custEparchyCode);
	}
	
	public static void main(String[] args) {
		System.out.println(map);
	}
}
