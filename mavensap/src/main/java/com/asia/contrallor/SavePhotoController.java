package com.asia.contrallor;

import java.io.File;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import sun.misc.BASE64Decoder;

import com.asia.util.HttpConf;
import com.asia.util.HttpUtils;


@Controller
public class SavePhotoController {
	
	private static final Logger logger = Logger.getLogger(SavePhotoController.class);
	@RequestMapping("/saveTradePic")
	public void saveTradePic(HttpServletRequest request,HttpServletResponse response){
		String pic1 = (String)request.getParameter("pic1");
		String pic2 = (String)request.getParameter("pic2");
		String pic3 = (String)request.getParameter("pic3");
		String pic4 = (String)request.getParameter("pic4");
		String pic5 = (String)request.getParameter("pic5");
		String photo = (String)request.getParameter("photo");
			
		String dateFilePath = (String)request.getParameter("dateFilePath");
		String photoPath = (String)request.getParameter("photoPath");
		String picName1 = (String)request.getParameter("picName1");
		String picName2 = (String)request.getParameter("picName2");
		String picName3 = (String)request.getParameter("picName3");
		String picName4 = (String)request.getParameter("picName4");
		String picName5 = (String)request.getParameter("picName5");
		String flag = (String)request.getParameter("flag");
		
		JSONObject newjsonObject = new JSONObject();
		try{
			if("1".equals(flag)){
				this.savePhotos(pic1, pic2, pic3, pic4, pic5,dateFilePath,photoPath,
						picName1,picName2,picName3,picName4,picName5
						);
				this.savePhotos2(pic1, pic2, pic3, pic4, pic5, dateFilePath, photoPath, picName1, picName2, picName3, picName4, picName5);
				
			}else{
				this.savePhotos(pic1, pic2, pic3, pic4, pic5,dateFilePath,photoPath,
						picName1,picName2,picName3,picName4,picName5
						);
			}
			
			newjsonObject.put("result", "OK");			
		}catch(Exception e){
			newjsonObject.put("result", "error");	
			logger.debug("savephoto faild,reason:"+e.getMessage());
			e.printStackTrace();
		}
		try{
			HttpUtils.jsonOutPrint(newjsonObject, request, response);
		}catch(Exception e){}
	
	}
	
	public void savePhotos(String pic1,String pic2,String pic3,String pic4,String pic5,
			String dateFilePath,String photoPath,
			String picName1,String picName2,String picName3,String picName4,String picName5)throws Exception{	
		BASE64Decoder decoder = new BASE64Decoder();
		
		/**按日期新建文件夹*/
		SimpleDateFormat sdff = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String path = HttpConf.getInterfaceUrl("serverpicpath");
		
		String filePath = path+photoPath+"/"+dateFilePath+"/";	
		logger.debug("filePath:"+filePath);
		File fileDir = new File(path+photoPath+"/"+dateFilePath);
		logger.debug("fileDir:"+fileDir);
		if(!fileDir.exists()){
			fileDir.mkdir();
		}
		if(pic1 != null && !"".equals(pic1) &&!"0000".equals(pic1)){
			
			String filename = filePath+picName1 ;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}else{
				file.delete();
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic1), file);
		}
		if(pic2 != null && !"".equals(pic2)&&!"0000".equals(pic2)){
			String filename = filePath+picName2;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic2), file);
		}
		if(pic3 != null && !"".equals(pic3)&&!"0000".equals(pic3)){
			String filename = filePath+picName3;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic3), file);
		}
		if(pic4 != null && !"".equals(pic4)&&!"0000".equals(pic4)){
			String filename = filePath+picName4;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic4), file);			
		}
		if(pic5 != null && !"".equals(pic5)&&!"0000".equals(pic5)){
			String filename = filePath+picName5;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic5), file);			
		}
	}
	
	public void savePhotos2(String pic1,String pic2,String pic3,String pic4,String pic5,
			String dateFilePath,String photoPath,
			String picName1,String picName2,String picName3,String picName4,String picName5)throws Exception{	
		BASE64Decoder decoder = new BASE64Decoder();
		
		/**按日期新建文件夹*/
		SimpleDateFormat sdff = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		String path = HttpConf.getInterfaceUrl("serverpicpath");
		/**
		logger.debug("filePath:"+path);
		File fileDir = new File(path);
		logger.debug("fileDir:"+fileDir);
		if(!fileDir.exists()){
			fileDir.mkdir();
		}
		*/
		if(pic1 != null && !"".equals(pic1) &&!"0000".equals(pic1)){
			
			String filename = path+picName1 ;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}else{
				file.delete();
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic1), file);
		}
		if(pic2 != null && !"".equals(pic2)&&!"0000".equals(pic2)){
			String filename = path+picName2;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic2), file);
		}
		if(pic3 != null && !"".equals(pic3)&&!"0000".equals(pic3)){
			String filename = path+picName3;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic3), file);
		}
		if(pic4 != null && !"".equals(pic4)&&!"0000".equals(pic4)){
			String filename = path+picName4;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic4), file);			
		}
		if(pic5 != null && !"".equals(pic5)&&!"0000".equals(pic5)){
			String filename = path+picName5;
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer(pic5), file);			
		}
	}

	public static void main(String args[]){
		
		/**按日期新建文件夹*/
		SimpleDateFormat sdff = new SimpleDateFormat("yyyyMMdd");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dateFilePath ="20170328";
		String filePath = "D:/"+dateFilePath+"/";	
		File fileDir = new File("D:/"+dateFilePath);
		if(!fileDir.exists()){
			fileDir.mkdir();
		}
		try{
			String filename = filePath+"76WO"+ "1.jpg";
			File file = new File(filename);
			if (!file.exists()) {
				file.createNewFile();
			}
			BASE64Decoder decoder = new BASE64Decoder();
			logger.debug(file.getAbsolutePath());
			FileCopyUtils.copy(decoder.decodeBuffer("111"), file);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
	}
}
