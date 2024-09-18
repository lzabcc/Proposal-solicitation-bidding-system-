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
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/admin/home">首页</a>
			  <a href="/ssm/admin/entmgr">征集企业管理</a>
			  <a href="#">账号激活</a>
			</span>
	    </div>
	    <div class="layui-bg-green pd-10"><h3>待激活征集人账号</h3></div>
	    <div class="search-form layui-row">
			<form action="/ssm/admin/entactive" method="post">
				<div class="layui-input-inline">
					<input type="text" name="kw" value="${kw }" class="layui-input" placeholder="企业名称">
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
		      <th>企业名称</th>
		      <!-- <th>电话号码</th>
		      <th>邮箱地址</th> -->
		      <th>法人代表</th>
		      <th>统一社会信用代码</th>
		      <th>注册资金</th>
		      <th>账号状态</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td>${row.enterpriseName }</td>
		  			<%-- <td>${row.tel }</td>
		  			<td>${row.email }</td> --%>
		  			<td>${row.frdb }</td>
		  			<td>${row.taxCode }</td>
		  			<td>${row.regAmount }</td>
		  			<td class="text-center">
		  				<c:if test="${row.status eq -1 }"><span class="layui-badge layui-bg-cyan">停用</span></c:if>
	  					<c:if test="${row.status eq 1 }"><span class="layui-badge layui-bg-green">激活</span></c:if>
		  			</td>
		  			<td>
		  				<a class="layui-btn layui-btn-xs" href="/ssm/admin/ent-detail?tid=${row.entId }"><i class="layui-icon">&#xe702;</i>查看</a>
		  				<c:if test="${row.status eq -1 }">
		  				<a class="layui-btn layui-btn-xs layui-btn-normal" href="javascript:void(0);" onclick="act(${row.entId });"><i class="layui-icon">&#xe605;</i>激活</a>
		  				</c:if>
		  				<c:if test="${row.status eq 1 }">
		  				<a class="layui-btn layui-btn-xs layui-btn-warm" href="javascript:void(0);" onclick="dis(${row.entId });"><i class="layui-icon">&#x1006;</i>停用</a>
		  				</c:if>
		  				<a class="layui-btn layui-btn-xs layui-btn-danger" href="javascript:void(0);" onclick="cfm(${row.entId });"><i class="layui-icon">&#xe640;</i>删除</a>
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
			layer.confirm('确认删除征集单位号？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/deleteent?eid="+eid;
			});
		}
		function act(eid){
			layer.confirm('确认激活该征集单位号？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/actent?eid="+eid;
			});
		}
		function dis(eid){
			layer.confirm('确认停用该征集单位号？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/disent?eid="+eid;
			});
		}
	</script>
</body>
</html>