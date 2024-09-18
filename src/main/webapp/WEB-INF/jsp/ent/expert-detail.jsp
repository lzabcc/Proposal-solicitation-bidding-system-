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
  <%-- <jsp:include page="../../../include/admin_menu.jsp"></jsp:include> --%>
  <style type="text/css">
  	.layui-form-label{width: 120px;}
	.layui-input-block{margin-left: 152px;}
	.layui-anim layui-anim-upbit{z-index:99999;}
  </style>
</head>
<body class="layui-layout-body">
	    <!-- 内容主体区域 -->
	    <div class="layui-card">
		  	<div class="layui-card-header layui-bg-green" style="font-size: 18px;">专家档案：${expert.realName }</div>
		  	<div class="layui-card-body">
		  		<table class="layui-table">
			  		<tbody>
			  			<tr>
			  				<td class="table-meta">姓名</td>
			  				<td>${expert.realName }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">职称</td>
			  				<td>${expert.expertTitle }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">专业方向</td>
			  				<td>${expert.major }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">专家类别</td>
			  				<td>${expert.expertType }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">工作单位</td>
			  				<td>${expert.company }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">出生年月</td>
			  				<td>${expert.birth }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">电话</td>
			  				<td>${expert.mobile }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">专家简介</td>
			  				<td>${expert.expertDesc }</td>
			  			</tr>
			  		</tbody>
		  		</table>
		  	</div>
	  	</div>
<script>
//JavaScript代码区域

</script>
</body>
</html>