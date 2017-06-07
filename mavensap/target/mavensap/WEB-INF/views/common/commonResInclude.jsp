<%@ page contentType="text/html; charset=UTF-8" %>
<%
	/*所有页面都需要引入的css,js 在此页面加入*/
%>

<%
	String path = request.getContextPath();
%>
<!-- 公用js -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/js/jquery.blockUI.js"></script>

<script type="text/javascript">

function blockUI(){

	top.jQuery.blockUI({ message: '<span style="height:49px;width:61px;"><img src="<%=request.getContextPath()%>/img/ui-anim.gif"></img> 处理中,请稍候...</span>'

		});
}

function unblockUI(){
	jQuery.unblockUI();
}
	//小写转换大写,支持到亿
    function DX(n) {
        if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
            return "数据非法";
        var unit = "千百拾亿千百拾万千百拾元角分", str = "";
            n += "00";
        var p = n.indexOf('.');
        if (p >= 0)
            n = n.substring(0, p) + n.substr(p+1, 2);
            unit = unit.substr(unit.length - n.length);
        for (var i=0; i < n.length; i++)
            str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
        return str.replace(/零(千|百|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
	}

</script>

