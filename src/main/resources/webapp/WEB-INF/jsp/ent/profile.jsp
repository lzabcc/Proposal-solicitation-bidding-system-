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
  <style type="text/css">
  	.layui-body{
  		background-color: #f2f2f2;
  	}
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="#">个人中心</a>
			</span>
	    </div>
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green">征集方企业信息</div>
		  <div class="layui-card-body">
		  	<form action="/ssm/ent/updateent" method="post">
		    <table class="layui-table">
			  <tbody>
			    <tr>
			      <td style="width: 150px;" class="table-meta">企业名称</td>
			      <td><input type="text"  class="layui-input" value="${ent.enterpriseName }" name="enterpriseName"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">登录账号</td>
			      <td><input type="text" class="layui-input" value="${ent.userName }" name="userName"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">电话号码</td>
			      <td><input type="text"  class="layui-input" value="${ent.tel }" name="tel"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">邮箱地址</td>
			      <td><input type="text"  class="layui-input" value="${ent.email }" name="email"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">法人代表</td>
			      <td><input type="text"  class="layui-input" value="${ent.frdb }" name="frdb"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">统一社会信用代码</td>
			      <td><input type="text"  class="layui-input" value="${ent.taxCode }" name="taxCode"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">注册资金</td>
			      <td><input type="text"  class="layui-input" value="${ent.regAmount }" name="regAmount"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">营业地址</td>
			      <td><input type="text"  class="layui-input" value="${ent.address }" name="address"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">公司简介</td>
			      <td><input type="text"  class="layui-input" value="${ent.entDesc }" name="entDesc"></td>
			    </tr>
			    <tr>
	  				<td class="table-meta">账号状态</td>
	  				<td>
	  					<c:if test="${ent.status eq -1 }"><span class="layui-badge layui-bg-cyan">停用</span></c:if>
	  					<c:if test="${ent.status eq 1 }"><span class="layui-badge layui-bg-green">激活</span></c:if>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td class="table-meta">操作</td>
	  				<td>
	  					<input type="hidden" value="${ent.entId }" name="entId">
	  					<input type="hidden" value="${ent.status }" name="status">
	  					<button class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;修改</button>
	  					<button type="reset" class="layui-btn layui-btn-warm layui-btn-sm" onclick="javascript: history.go(-1);"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;返回</button>
	  				</td>
	  			</tr>
			  </tbody>
			</table>
			</form>
		  </div>
		</div>
  	</div>
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
//JavaScript代码区域
</script>
</body>
</html>