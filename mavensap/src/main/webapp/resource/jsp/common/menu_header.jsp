<%@ page contentType="text/html; charset=UTF-8"%><div id="shortcut-2013">
			<div class="w">
        		<ul class="fl lh">
            		<li class="fore1 ld"><b></b><a rel="nofollow" href="javascript:AddFavorite('河南联通流量批发平台');">收藏本站</a></li>
            		<input type="hidden" id="context_path" value="${pageContext.request.contextPath}"/>
        		</ul>
        		<ul class="fr lh" id="menus">
            	<li id="loginbar" class="fore1">您好！欢迎来到本站！<a href="${pageContext.request.contextPath}/index.jsp">[登录]</a>&nbsp;<a href="${pageContext.request.contextPath}/register.jsp">[免费注册]</a></li>          	
            	<li data-widget="dropdown" id="site-nav" class="fore5 ld menu"><s></s><span class="outline"></span><span class="blank"></span>
					网站导航
                	<b></b>
                	<div class="dd lh">
                		<!-- -->
                    	<dl class="item fore3">
                        	<dt>网站导航</dt>
                        	<dd>
                            	<div><a href="http://www.10010.com/" target="_blank">网上营业厅</a></div>
                            	<div><a href="http://iservice.10010.com/elecService/wap.html" target="_blank">手机营业厅</a></div>
                            	<div><a href="http://iservice.10010.com/elecService/weixin.html" target="_blank">微信营业厅</a></div>
                        	</dd>
                    	</dl>
                	</div>
           		</li>
        	</ul>
        	<span class="clr"></span>
    		</div>
		</div>
		<div class="hd">
			<div class="logo">
				<img src="${pageContext.request.contextPath}/resource/img/logo.gif" height="83"/><div id="greeting"><c:if test="${not empty login_staff_id}">您好,<b>${login_staff_id}!</b>欢迎您登录联通流量后向计费平台</c:if></div><div id="addfav"><span class="glyphicon glyphicon-heart"></span><a href="javascript:void(0);" onclick="AddFavorite('河南联通流量批发平台');">收藏本站</a></div>
			</div>
		</div>
		<div class="headnav" style="margin-top:0px;margin-bottom:0px;">
			<div style="width:1024px;margin:auto;padding:0px;margin-top:0px;margin-bottom:0px;">
				<div class="navctrl" style="margin-top:0px;margin-bottom:0px;padding:0px;">
          			<ul class="nav navbar-nav navbar-right" style="margin:0px;">
            			<li><a href="${pageContext.request.contextPath}/logout.do">退出系统</a></li>
          			</ul>
          			<ul class="nav navbar-nav" style="margin:0px;">
            			<li class="first"><a href="${pageContext.request.contextPath}/welcome.do">首页</a></li>
            			${headermenu}
          			</ul>
        		</div>
			</div>
		</div>