<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
  <head>
    <jsp:include page="./common/commonResInclude.jsp"></jsp:include>
    <script src="http://www.hubwiz.com/scripts/angular.min.js"></script>
    
    <title>mainIndex</title>
	
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta name="content-type" content="text/html; charset=UTF-8">
    
    <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
  </head>
  <script type="text/javascript">
  
  function doLoad(){
  		
  		var url="findServer.do";
  		var data = {sapTradeId:"7579151117143559"}; 		
  		var callback = function (result){
  			//alert(result);
  		};
  		
  		ajaxQuery(url,'post','json',data,callback);
		};
  	
  	function ajaxQuery(url, type, dataType, data, callback) {
				$.ajax({
					url : url,
					type : type,
					dataType : dataType,
					data : data,
					success : callback,
					failure : function(error) {
						showmsg(error);
					}
				});
			}
			function showmsg(s) {
				$("#show_error").show();
				$("#show_error_text").html(s);
			}
  
  </script>
  
  <body>
  <div ng-controller="BoxCtrl">
    <div style="width: 100px; height: 100px; background-color: red;"
         ng-click="click()"></div>
    <p>{{ w }} x {{ h }}</p>
    <p>W: <input type="text" ng-model="w" /></p>
    <p>H: <input type="text" ng-model="h" /></p>
  </div>
  <form name="test_form" ng-controller="TestCtrl" ng-init="o=[0,1,2,3]; a=o[1];">
  <select ng-model="a" ng-options="x for x in o" ng-change="show()">
    <option value="">可以加这个空值</option>
  </select>
	</form>


<script type="text/javascript" charset="utf-8">

  angular.module('app', [], angular.noop)
  .controller('BoxCtrl', function($scope, $element){
      //$element 就是一个 jQuery 对象
      var e = $element.children().eq(0);
      $scope.w = e.width();
      $scope.h = e.height();

      $scope.click = function(){
        $scope.w = parseInt($scope.w) + 10;
        $scope.h = parseInt($scope.h) + 10;
      }

      $scope.$watch('w',
        function(to, from){
          e.width(to);
        }
      );

      $scope.$watch('h',
        function(to, from){
          e.height(to);
        }
      );
  });


  angular.bootstrap(document.documentElement, ['app']);
  
  
  angular.module('app1', [], angular.noop)
	.controller('TestCtrl', function($scope){
 	 $scope.show = function(){
    console.log($scope.a);
  	}
	});
	angular.bootstrap(document.documentElement, ['app1']);

</script>
</body>
</html>
