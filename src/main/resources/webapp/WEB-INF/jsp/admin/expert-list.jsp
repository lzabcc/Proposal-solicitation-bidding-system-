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
	    <div class="search-form layui-row">
			<form action="/ssm/admin/expertmgr" method="post">
				<div class="layui-input-inline">
					<input type="text" name="kw" value="${kw }" class="layui-input" placeholder="姓名">
				</div>
				<div class="layui-input-inline" style="width: 150px;">
					<select name="type" class="layui-input">
						<option value="-1" <c:if test='${type eq "-1" }'>selected="selected"</c:if>>所有类型</option>
						<option value="工程类" <c:if test='${type eq "工程类" }'>selected="selected"</c:if>>工程类</option>
						<option value="产品类" <c:if test='${type eq "产品类" }'>selected="selected"</c:if>>产品类</option>
						<option value="服务类" <c:if test='${type eq "服务类" }'>selected="selected"</c:if>>服务类</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn">
					  <i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</form>
		</div>
		<table class="layui-table">
		  <thead>
		    <tr>
		      <th>登录账号</th>
		      <th>姓名</th>
		      <th>职称</th>
		      <th>专业方向</th>
		      <th>专家类别</th>
		      <th>出生年月</th>
		      <th>工作单位</th>
		      <th>电话</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td class="text-center">${row.userName }</td>
		  			<td class="text-center">${row.realName }</td>
		  			<td class="text-center">${row.expertTitle }</td>
		  			<td class="text-center">${row.major }</td>
		  			<td class="text-center">${row.expertType }</td>
		  			<td class="text-center">${row.birth }</td>
		  			<td class="text-center">${row.company }</td>
		  			<td class="text-center">${row.mobile }</td>
		  			<td class="text-center">
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