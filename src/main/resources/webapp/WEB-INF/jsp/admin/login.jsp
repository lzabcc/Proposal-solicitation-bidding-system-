<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>登录</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<link rel="stylesheet" href="/ssm/login/layui.css" media="all">
<link rel="stylesheet" href="/ssm/login/admin.css" media="all">
<link rel="stylesheet" href="/ssm/login/login.css" media="all">
<link id="layuicss-layer" rel="stylesheet" href="/ssm/login/layer.css" media="all">
</head>
<body layadmin-themealias="default">

	<div class="layadmin-user-login layadmin-user-display-show" id="LAY-user-login" style="display: none; margin-top: -90px;">

		<div class="layadmin-user-login-main">
			<div class="layadmin-user-login-box layadmin-user-login-header">
				<h2>管理员登录</h2>
				<p>方案征集管理系统</p>
			</div>
			<form action="/ssm/admin/loginform" method="post">
			<div class="layadmin-user-login-box layadmin-user-login-body layui-form">
				<div class="layui-form-item">
					<label
						class="layadmin-user-login-icon layui-icon layui-icon-username"
						for="LAY-user-login-username"></label> <input type="text"
						name="username" id="LAY-user-login-username" lay-verify="required"
						placeholder="用户名" class="layui-input">
				</div>
				<div class="layui-form-item">
					<label
						class="layadmin-user-login-icon layui-icon layui-icon-password"
						for="LAY-user-login-password"></label> <input type="password"
						name="pwd" id="LAY-user-login-password" lay-verify="required"
						placeholder="密码" class="layui-input">
				</div>
				<div class="layui-form-item">
					<div class="layui-row">
						<div class="layui-col-xs7">
							<label class="layadmin-user-login-icon layui-icon layui-icon-vercode"for="LAY-user-login-vercode"></label> 
							<input type="text" name="vercode" id="LAY-user-login-vercode" lay-verify="required" placeholder="图形验证码" class="layui-input" onblur="verify();">
						</div>
						<div class="layui-col-xs5">
							<div style="margin-left: 10px;">
								<a href="javascript:void(0);" onclick="changeImg()"><img src="/ssm/val/code.do" class="layadmin-user-login-codeimg" id="LAY-user-get-vercode"/></a>
							</div>
						</div>
					</div>
				</div>
				<div class="layui-form-item" style="margin-bottom: 20px;">
					<span style="color: red;" id="msg">${msg }</span>
				</div>
				<!-- <div class="layui-form-item" style="margin-bottom: 20px;">
					<input type="checkbox" name="remember" lay-skin="primary"
						title="记住密码">
					<div class="layui-unselect layui-form-checkbox" lay-skin="primary">
						<span>记住密码</span><i class="layui-icon layui-icon-ok"></i>
					</div>
					<a
						href="https://www.layui.com/admin/std/dist/views/user/forget.html"
						class="layadmin-user-jump-change layadmin-link"
						style="margin-top: 7px;">忘记密码？</a>
				</div> -->
				<div class="layui-form-item">
					<button class="layui-btn layui-btn-fluid" type="submit" lay-submit="" lay-filter="LAY-user-login-submit">登 入</button>
				</div>
			</div>
			</form>
		</div>

		<div class="layui-trans layadmin-user-login-footer">

			<p>
				© 2022 <a href="http://www.layui.com/" target="_blank">方案征集管理系统</a>
			</p>
			<p>
			</p>
		</div>
	</div>

	<script src="/ssm/login/layui.js"></script>
	<script>
		function verify(){
			$("#msg").text(" ");
			var code = $("#LAY-user-login-vercode").val();
			$.get(
				"/ssm/verify",
				{"vercode":code},
				function(data){
					if(data == -1){
						$("#msg").text("验证码错误");
					}
				}
			);
		}
		function changeImg() {
	        var timestamp = (new Date()).valueOf();
	        console.log(timestamp);
	        $("#LAY-user-get-vercode").attr("src", "/ssm/val/code.do?tm="+timestamp);
	    }
		layui
				.config({
					base : '../../layuiadmin/' //静态资源所在路径
				})
				.extend({
					index : 'lib/index' //主入口模块
				})
				.use(
						[ 'index', 'user' ],
						function() {
							var $ = layui.$, setter = layui.setter, admin = layui.admin, form = layui.form, router = layui
									.router(), search = router.search;

							form.render();

							//提交
							form.on('submit(LAY-user-login-submit)', function(obj) {

								//请求登入接口
								admin.req({
									url : layui.setter.base
											+ 'json/user/login.js' //实际使用请改成服务端真实接口
									,
									data : obj.field,
									done : function(res) {

										//请求成功后，写入 access_token
										layui.data(setter.tableName, {
											key : setter.request.tokenName,
											value : res.data.access_token
										});

										//登入成功的提示与跳转
										layer.msg('登入成功', {
											offset : '15px',
											icon : 1,
											time : 1000
										}, function() {
											location.href = '../'; //后台主页
										});
									}
								});

							});

							//实际使用时记得删除该代码
							layer.msg('为了方便演示，用户名密码可随意输入', {
								offset : '15px',
								icon : 1
							});

						});
	</script>

	<style id="LAY_layadmin_theme">
.layui-side-menu, .layadmin-pagetabs .layui-tab-title li:after,
	.layadmin-pagetabs .layui-tab-title li.layui-this:after,
	.layui-layer-admin .layui-layer-title, .layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child
	{
	background-color: #20222A !important;
}

.layui-nav-tree .layui-this, .layui-nav-tree .layui-this>a,
	.layui-nav-tree .layui-nav-child dd.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a
	{
	background-color: #009688 !important;
}

.layui-layout-admin .layui-logo {
	background-color: #20222A !important;
}
</style>
	<div class="layui-layer-move"></div>
</body>
</html>