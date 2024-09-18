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
  <%-- <jsp:include page="../../include/sup_menu.jsp"></jsp:include> --%>
  <style type="text/css">
  	.layui-body{
  		background-color: #f2f2f2;
  	}
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-sup">
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/sup_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/sup_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/sup/home">首页</a>
			  <a href="/ssm/sup/noticemgr">公告列表</a>
			  <a href="#">公告详情</a>
			</span>
	    </div>
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green" style="font-size: 18px;">${notice.title }</div>
		  <div class="layui-card-body">
		    <table class="layui-table">
			  <tbody>
			    <tr>
			      <td style="width: 150px;" class="table-meta">公告类型</td>
			      <td>${notice.noticeType }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">发布时间</td>
			      <td><fmt:formatDate value="${notice.publishTime }" pattern="yyyy-MM-dd HH:mm"/></td>
			    </tr>
			    <tr>
			      <td class="table-meta">正文内容</td>
			      <td>${notice.content }</td>
			    </tr>
			    <tr>
			      	<td class="table-meta"></td>
			      	<td>
			      		<a class="layui-btn layui-btn-sm" href="javascript:history.go(-1);"><i class="layui-icon">&#xe65c;</i>返回</a>
					</td>
			    </tr>
			  </tbody>
			</table>
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