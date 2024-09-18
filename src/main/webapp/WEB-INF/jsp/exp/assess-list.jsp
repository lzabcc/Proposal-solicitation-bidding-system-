<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>方案征集管理系统</title>
  <!--_header 作为公共模版分离出去-->
  <jsp:include page="../../include/_meta.jsp"></jsp:include>
  <!--/_header 作为公共模版分离出去-->
  <!--_menu 作为公共模版分离出去-->
  <%-- <jsp:include page="../../include/admin_menu.jsp"></jsp:include> --%>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  	<jsp:include page="../../include/exp_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/exp_menu.jsp"></jsp:include>
  
  	<div class="layui-body ssm-table">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/exp/home">首页</a>
			  <a href="#">评标历史</a>
			</span>
	    </div>
		<table class="layui-table">
		  <thead>
		    <tr>
		    	<th>征集单位</th>
		      	<th>项目名称</th>
		      	<th>项目类型</th>
		      	<th>推荐供应商</th>
		      	<th>推荐理由</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td class="text-center">${row.ent.enterpriseName }</td>
		  			<td class="text-center">${row.ten.projectName }</td>
		  			<td class="text-center">${row.ten.projectType }</td>
		  			<td class="text-center">${row.winner.entName }</td>
		  			<td class="text-center">${row.ass.reason }</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
		<div id="pageview"></div>
	</div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		layui.use('table', function(){
			var table = layui.table;
			 console.log(table);
			//转换静态表格
			table.init('demo', {
			  //height: 315, //设置高度
			  limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
			  //支持所有基础参数
			}); 
		});

		layui.use('laypage', function(){
		  var laypage = layui.laypage;
		  
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'pageview' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: ${page.totalrecord} //数据总数，从服务端得到
		  });
		});
	</script>
</body>
</html>