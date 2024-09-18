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
<div class="layui-layout layui-layout-admin">
  	<jsp:include page="../../include/admin_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/admin/home">首页</a>
			  <a href="/ssm/admin/entmgr">供应商管理</a>
			  <a href="#">企业详情</a>
			</span>
	    </div>
	    <div class="layui-card">
		  	<div class="layui-card-header layui-bg-green" style="font-size: 18px;">供应商档案信息：${sup.entName }</div>
		  	<div class="layui-card-body">
		  		<table class="layui-table">
			  		<tbody>
			  			<tr>
			  				<td class="table-meta" style="width: 200px;">公司名称</td>
			  				<td>${sup.entName }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">登录账号</td>
			  				<td>${sup.userName }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">电话号码</td>
			  				<td>${sup.tel }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">邮箱地址</td>
			  				<td>${sup.email }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">法人代表</td>
			  				<td>${sup.frdb }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">统一社会信用代码</td>
			  				<td>${sup.taxCode }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">注册资金</td>
			  				<td>${sup.regAmount }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">营业地址</td>
			  				<td>${sup.address }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">企业简介</td>
			  				<td>${sup.entDesc }</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">资质文件</td>
			  				<td>
			  					<a type="button" class="layui-btn layui-btn-sm" href="/ssm/upload/${sup.attachment }">
							  		<i class="layui-icon">&#xe601;</i>下载
								</a>
			  				</td>
			  			</tr>
			  			<tr>
			  				<td class="table-meta">账号状态</td>
			  				<td>
			  					<c:if test="${sup.status eq -1 }"><span class="layui-badge layui-bg-cyan">停用</span></c:if>
			  					<c:if test="${sup.status eq 1 }"><span class="layui-badge layui-bg-green">激活</span></c:if>
			  				</td>
			  			</tr>
	  					<c:if test="${sup.status eq -1 }">
				  			<tr>
				  				<td class="table-meta">操作</td>
				  				<td>
				  					<a class="layui-btn layui-btn-xs layui-btn-normal" href="javascript:void(0);" onclick="act(${sup.supplierId });"><i class="layui-icon">&#xe605;</i>激活</a>
				  				</td>
				  			</tr>
			  			</c:if>
			  			<tr>
			  				<td></td>
			  				<td><a class="layui-btn layui-btn-sm" href="javascript:history.go(-1);"><i class="layui-icon">&#xe65c;</i>返回</a></td>
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
	function act(eid){
		layer.confirm('确认激活该供应商吗？', {icon: 3, title:'提示'}, function(index){
			window.location.href="/ssm/admin/actsup?eid="+eid;
		});
	}
</script>
</body>
</html>