package com.asia.dao;

import java.util.Map;

import javax.sql.DataSource;

public class ProxyDataSource {
	
	private Map<String, DataSource> dataSourceMap;

	public Map<String, DataSource> getDataSourceMap() {
		return dataSourceMap;
	}

	public void setDataSourceMap(Map<String, DataSource> dataSourceMap) {
		this.dataSourceMap = dataSourceMap;
	}
	
	public DataSource getDataSource(String dataSourceName){
		return this.dataSourceMap.get(dataSourceName);
	}

}
