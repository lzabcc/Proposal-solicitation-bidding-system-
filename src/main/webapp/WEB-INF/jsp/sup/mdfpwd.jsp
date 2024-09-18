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
  	<jsp:include page="../../include/sup_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/sup_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/sup/home">首页</a>
			  <a href="/ssm/sup/profile">个人中心</a>
			  <a href="#">修改密码</a>
			</span>
	    </div>
	    <form class="layui-form" action="/ssm/sup/updatepwd" method="post" onsubmit="return dbcheck();">
		  <div class="layui-form-item">
		    <label class="layui-form-label">企业名称</label>
		    <div class="layui-input-block">
		      <input type="text" disabled="disabled" class="layui-input" value="${sup.entName }">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">用户名</label>
		    <div class="layui-input-block">
		      <input type="text" disabled="disabled" class="layui-input" value="${sup.userName }">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-block">
		      <input type="password" name="pwd" id="pwd1" required  lay-verify="required" placeholder="请输入新密码" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-block">
		      <input type="password" id="pwd2" required  lay-verify="required" placeholder="请再次输入密码" autocomplete="off" class="layui-input" onblur="checkpwd();">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn" lay-submit lay-filter="formDemo"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;重置</button>
		    </div>
		  </div>
		</form>
  	</div>
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
//JavaScript代码区域
var checked = false;
function checkpwd(){
	var p1 = $("#pwd1").val();
	var p2 = $("#pwd2").val();
	if(p1 != p2){
		layer.alert('两次输入的密码不一致！', {
			icon: 5,
			title: "提示"
		});
	}else{
		checked = true;
	}
}
function dbcheck(){
	return checked;
}
</script>
</body>
</html>