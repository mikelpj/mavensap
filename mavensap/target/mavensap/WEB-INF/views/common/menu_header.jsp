<%@ page contentType="text/html; charset=UTF-8"%><div id="shortcut-2013">
			<div class="w">
        		<ul class="fl lh">
        		<!-- 
            		<li class="fore1 ld"><b></b><a rel="nofollow" href="javascript:AddFavorite('河南联通后向流量销售系统');">收藏本站</a></li>
            		<input type="hidden" id="context_path" value="${pageContext.request.contextPath}"/>
            	 -->
        		</ul>
        		<ul class="fr lh" id="menus">
        		
            	<li id="loginbar" class="fore1">您好！欢迎来到本站！</li>
            	<!--
				<li data-widget="dropdown" id="biz-service" class="fore4 ld menu"><s></s><span class="outline"></span><span class="blank"></span>
                	客户服务
                	<b></b>
                	<div class="dd">
                    	<div><a target="_blank" href="${pageContext.request.contextPath}/faq.do">常见问题</a></div>
                    	<div><a rel="nofollow" target="_blank" href="${pageContext.request.contextPath}/msg.do">建议留言</a></div>
                    	<div><a rel="nofollow" target="_blank" href="${pageContext.request.contextPath}/tousu.do">投诉中心</a></div>
                	</div>
            	</li>
            	-->

           		
        	</ul>
        	<span class="clr"></span>
    		</div>
		</div>
		<div class="hd">
			<div class="logo">
				<img src="${pageContext.request.contextPath}/img/logo.gif" height="83" class="logo-img"/>
				<div style="width:800px;float:right"><img src="${pageContext.request.contextPath}/img/baner2.jpg" height="63"  style="margin-top:14px"></div>
				<!-- 
				<div id="greeting">
				<c:if test="${not empty login_staff_id}">您好, <b>${login_staff_id} ！ </b>欢迎您登录河南联通预约平台</c:if>
				</div>
				<div id="addfav">
				<span class="glyphicon glyphicon-heart"></span>			
				<a href="javascript:void(0);" onclick="AddFavorite('河南联通预约平台');">收藏本站</a>
				
				</div>
				 -->
			</div>
		</div>
		
		<div class="headnav" style="width:1024px;margin:0 auto">
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