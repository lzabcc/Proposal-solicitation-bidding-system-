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
  	<jsp:include page="../../include/admin_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
		<table class="layui-table" style="width: 70%; margin: 0 auto;">
		  <thead>
		    <tr>
		      <th>序号</th>
		      <th>时间</th>
		      <th>消息类型</th>
		      <th>内容</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td>${row.userName }</td>
		  			<td>${row.realName }</td>
		  			<td>${row.expertTitle }</td>
		  			<td>${row.major }</td>
		  			<td>${row.expertType }</td>
		  			<td>
		  				<a class="layui-btn layui-btn-sm" href="/ssm/admin/expert-detail?tid=${row.expertId }"><i class="layui-icon">&#xe702;</i>详情</a>
		  				<a class="layui-btn layui-btn-sm layui-btn-normal" href="/ssm/admin/tomdfexpert?eid=${row.expertId }"><i class="layui-icon">&#xe642;</i>修改</a>
		  				<a class="layui-btn layui-btn-sm layui-btn-danger" href="javascript:void(0);" onclick="cfm(${row.expertId });"><i class="layui-icon">&#xe640;</i>删除</a>
		  			</td>
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
		layui.use('laypage', function(){
		  var laypage = layui.laypage;
		  
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'pageview' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: ${page.totalrecord} //数据总数，从服务端得到
		  });
		});

		function cfm(eid){
			layer.confirm('确认删除该专家吗？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/deleteexpert?eid="+eid;
			});
		}
	</script>
</body>
</html>