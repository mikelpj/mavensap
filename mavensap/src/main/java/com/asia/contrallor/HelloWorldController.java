package com.asia.contrallor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.asia.service.PersonService;
import com.asia.service.TradeService;
import com.asia.util.DataSourceContextHolder;
import com.asia.util.DataSourceRoute;
import com.asia.util.HttpUtils;


@Controller
public class HelloWorldController {
	
	private static final Logger logger = Logger.getLogger(HelloWorldController.class);
	@Autowired  
	private PersonService personService;
	@Autowired
	private TradeService tradeService;
	
	@RequestMapping("/hello")
	
	 public ModelAndView helloWorld() {
		  		
		  String message = "Hello World, Spring 3.0!";
		  System.out.println(message);
		  
		  List<Map<String,Object>> tradeEntityList = tradeService.getTfSapTrade("7602015530710202","7602015530710122");
		 
		  JSONObject testJson =  JSONObject.fromObject(tradeEntityList);;
		 
		 
		  int result = tradeService.insertTradeItem("123", "01", "a", "b");
		  System.out.println(result);
		  
		  String abc = personService.getPerson("18", "liping", "boy");	 
		  return new ModelAndView("hello", "message", abc);
		 }
	@RequestMapping("/findServer")
	public void getServe(HttpServletRequest request,HttpServletResponse response){
		  
		  String sapTradeId = (String)request.getParameter("sapTradeId");
		  List<Map<String,Object>> tradeEntityList = tradeService.getTfSapTrade(sapTradeId,sapTradeId);
		  JSONObject jsonObject = new JSONObject();
		  JSONObject testJson = (JSONObject) JSONObject.fromObject(tradeEntityList);
		  try{
			  jsonObject.put("success", "1");
			  jsonObject.put("testJson", testJson);
			  HttpUtils.jsonOutPrint(jsonObject, request, response);			  
		  }catch(Exception e){
			  
		  }		  
	}
	
	@RequestMapping("/mainIndex")
	public ModelAndView initIdex(HttpServletRequest request,HttpServletResponse response) throws Exception{
		System.out.println(request.getContextPath());  
		//request.getRequestDispatcher("/webapp/views/mainIndex.jsp").forward(request, response);
		 return new ModelAndView("mainIndex");
	}
	@RequestMapping("/mainIndexTo")
	public ModelAndView initIdexTo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		System.out.println(request.getContextPath());  
		//request.getRequestDispatcher("/views/jsp/index.jsp").forward(request, response);
		return new ModelAndView("/jsp/index");
	}
}	
