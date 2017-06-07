package com.asia.util;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

public class EparchyCodeLocalUtil {
	private static Map<String, String> map = null;
	private static Map<String, String> eparchyMap = null;
	private static final Logger logger = Logger.getLogger(EparchyCodeLocalUtil.class);
	static{
		if(map == null){
			map = new HashMap();
		}
		map.put("760","0371");
		map.put("761","0379");
		map.put("762","0378");
		map.put("763","0391");
		map.put("764","0373");
		map.put("765","0374");
		map.put("766","0395");
		map.put("767","0372");
		map.put("768","0370");
		map.put("769","0375");
		map.put("770","0394");
		map.put("771","0396");
		map.put("772","0398");
		map.put("773","0393");
		map.put("774","0392");
		map.put("775","0399");
		map.put("776","0376");
		map.put("777","0377");
		
		if(eparchyMap == null){
			eparchyMap = new HashMap();
		}
		eparchyMap.put("0371","760");
		eparchyMap.put("0379","761");
		eparchyMap.put("0378","762");
		eparchyMap.put("0391","763");
		eparchyMap.put("0373","764");
		eparchyMap.put("0374","765");
		eparchyMap.put("0395","766");
		eparchyMap.put("0372","767");
		eparchyMap.put("0370","768");
		eparchyMap.put("0375","769");
		eparchyMap.put("0394","770");
		eparchyMap.put("0396","771");
		eparchyMap.put("0398","772");
		eparchyMap.put("0393","773");
		eparchyMap.put("0392","774");
		eparchyMap.put("0399","775");
		eparchyMap.put("0376","776");
		eparchyMap.put("0377","777");
	}
	public static String getEparchyCodeByCityName(String cityName){
		logger.debug(cityName+"---------------------"+map.get(cityName));
		return map.get(cityName);
	}
	public static String getCityByEparchyCode(String eparchyCode){
		return eparchyMap.get(eparchyCode);
	}

}