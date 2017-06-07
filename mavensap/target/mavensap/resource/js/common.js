function strTrim(s){
 return s.replace(/(^\s*)|(\s*$)/g, "");
}
String.prototype.replaceAll = function(s1,s2){ return this.replace(new RegExp(s1,"gm"),s2); }
function isTel(s){
	var i,j,strTemp;
	strTemp="0123456789-()# ";
	for (i=0;i<s.length;i++)
	{
		j=strTemp.indexOf(s.charAt(i)); 
		if (j==-1)  return false;
	}
	return true;
}
function isEmail(s){
	var reg = /^(?:[a-zA-Z0-9]+[_\-\+\.]?)*[a-zA-Z0-9]+@(?:([a-zA-Z0-9]+[_\-]?)*[a-zA-Z0-9]+\.)+([a-zA-Z]{2,})+$/;
	return reg.test(s);
}
function isChinese(s){
	var re = /^([\u4E00-\u9FA5]|[\uFE30-\uFFA0])*$/;
	re.lastIndex=0;//
	return re.test(s);
} 
function isMobile(s){
	//var re = /^(130|131|132|155|156|185|186)\d{8}$/;
	//return re.test(s);
	//是否是联通手机号
	var re = /^(130)|^(131)|^(132)|^(145)|^(155)|^(156)|^(185)|^(186)|^(176)|^(170[0-8])/;
	var re2 = /^\d{11}$/;
	return re.test(s)&&re2.test(s);
}
function isMobiPhone(s){
	//是否是手机号
	var re = /^(13|14|15|17|18|19)\d{9}$/;
	return re.test(s);
}
function isEnglish(s){
	var re = /^[A-Za-z|//|\s]+$/g;
	re.lastIndex=0;
	return re.test(s);
}
function isNum(s){
	var re=/^(0|([1-9]\d*))$/;
	if (!re.test(s)){
		return false;
	}
	return true;
}
function isDate(s){
	var re=/^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$/;
	return re.test(s);
}
function checkUserName(s){
	var re=/^[a-zA-Z0-9_@.]+$/;
	return re.test(s);
}

/* 
*比较对象是否相同 
*/ 
function o2o2(s){
	var numbers=s.split(",");
	var arr1=numbers;
	var num=arr1.length;
	if(num<2){
		return true;
	}

	var nary=numbers.sort();
	 for(var i=0;i<nary.length-1;i++){
		 for(var k=i+1;k<nary.length;k++)
		{
		   if (nary[i]==nary[k]){  return false;}
		}
	}
	 return true;
}


