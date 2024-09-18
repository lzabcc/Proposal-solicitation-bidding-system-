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
  	<jsp:include page="../../include/ent_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			  <a href="#">专家邀请</a>
			</span>
	    </div>
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green" style="font-size: 18px;">已邀请评标专家列表</div>
		  <div class="layui-card-body">
			<table class="layui-table" style="width: 70%; margin: 0 auto;">
			  <thead>
			    <tr>
			      <th>专家姓名</th>
			      <th>职称</th>
			      <th>专业方向</th>
			      <th>专家类别</th>
			    </tr> 
			  </thead>
			  <tbody>
			  	<c:forEach items="${list }" var="row">
			  		<tr>
			  			<td class="text-center">${row.realName }</td>
			  			<td class="text-center">${row.expertTitle }</td>
			  			<td class="text-center">${row.major }</td>
			  			<td class="text-center">${row.expertType }</td>
			  		</tr>
			  	</c:forEach>
			  </tbody>
			</table>
		    <div class="pd-10 text-center"">
		      	<button type="reset" class="layui-btn" onclick="javascript: history.go(-1);"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;返回</button>
		    </div>
		  </div>
	  </div>
	</div>
</div>
	
<!-- 引入页面公共页 -->
<jsp:include page="../../include/footer.jsp"></jsp:include>
<script type="text/javascript">
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