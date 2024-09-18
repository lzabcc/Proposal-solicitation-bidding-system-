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
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			  <a href="#">项目详情</a>
			</span>
	    </div>
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green" style="font-size: 18px;">${tender.projectName }</div>
		  <div class="layui-card-body">
		    <table class="layui-table">
			  <tbody>
			    <tr>
			      <td style="width: 150px;" class="table-meta">项目类型</td>
			      <td>${tender.projectType }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">项目负责人</td>
			      <td>${tender.incharge }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">电话号码</td>
			      <td>${tender.mobile }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">邮箱地址</td>
			      <td>${tender.email }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">项目预算</td>
			      <td>${tender.budget }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">征集截止时间</td>
			      <td><fmt:formatDate value="${tender.endTime }" pattern="yyyy-MM-dd HH:mm"/></td>
			    </tr>
			    <tr>
			      <td class="table-meta">征集状态</td>
			      <td>
			      	<c:if test="${tender.status eq -1 }"><span class="layui-badge">已拒绝</span></c:if>
	  				<c:if test="${tender.status eq 0 }"><span class="layui-badge layui-bg-cyan">待审核</span></c:if>
	  				<c:if test="${tender.status eq 1 }"><span class="layui-badge layui-bg-blue">征集中</span></c:if>
	  				<c:if test="${tender.status eq 2 }"><span class="layui-badge layui-bg-green">已完成</span></c:if>
	  				<c:if test="${tender.status eq 3 }"><span class="layui-badge layui-bg-black">流标</span></c:if>
	  				<c:if test="${tender.status eq 99 }"><span class="layui-badge layui-bg-gray">已截止</span></c:if>
			      </td>
			    </tr>
			    <tr>
			      <td class="table-meta">项目简介</td>
			      <td>${tender.projectDesc }</td>
			    </tr>
			    <tr>
			      <td class="table-meta">关键词</td>
			      <td>${tender.keyWords }</td>
			    </tr>
			    <tr>
			      	<td class="table-meta">征集书</td>
			      	<td>
			      		<a type="button" class="layui-btn layui-btn-sm" href="/ssm/upload/${tender.attachement }">
					  		<i class="layui-icon">&#xe601;</i>下载
						</a>
					</td>
			    </tr>
			    <c:if test="${tender.status eq -1 }">
			    <tr>
			      <td class="table-meta">中标方</td>
			      <td>${winner } </td>
			    </tr>
			    </c:if>
			    <c:if test="${tender.status eq 1 }">
			    <tr>
			      	<td class="table-meta">操作</td>
			      	<td>
			      		<a type="button" class="layui-btn layui-btn-sm" href="/ssm/ent/invitesup?tid=${tender.tenderId }">
					  		<i class="layui-icon">&#xe770;</i>邀请供应商征集
						</a>
						<!-- <a type="button" class="layui-btn layui-btn-sm layui-btn-normal" href="#">
					  		<i class="layui-icon">&#xe705;</i>查看已收到的标书
						</a> -->
					</td>
			    </tr>
			    </c:if>
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