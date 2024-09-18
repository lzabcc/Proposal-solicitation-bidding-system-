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
  <style type="text/css">
  		body{    background-color: #f2f2f2;
    color: #666;}
      		.container{
      			width: 420px;
      			height: 800px;
		 		 position: absolute;   
		 		 top: 0;  
		 		 left: 0;  
		 		 bottom: 0;  
		 		 right: 0;  
		 		 margin: 50px auto;  
		 		 padding: 20px;  
		 		 z-index: 130;  
		 		 border-radius: 8px;  
		 		 background-color: #fff;  
		 		 box-shadow: 0 3px 18px rgba(50, 50, 50, .5); 
		 		 font-size: 16px;
      		}
      		.close{
      			background-color: white;
      			border: none;
      			font-size: 18px;
      			margin-left: 410px;
      			margin-top: -10px;
      		}
 
        	.layui-input{
        		border-radius: 5px;
        		width: 300px;
        		height: 40px;
        		font-size: 15px;
        	}
        	.layui-form-item{
        		margin-left: -20px;
        	}
			#logoid{ 
				margin-top: -16px;
		 		 padding-left:150px; 
		 		 padding-bottom: 15px;
			}
			.layui-btn{
				margin-left: -50px;
				border-radius: 5px;
        		height: 40px;
        		font-size: 15px;
			}
			.verity{
				width: 120px;
			}
			.font-set{
				font-size: 13px;
				text-decoration: none; 
				margin-left: 120px;
			}
			a:hover{
			 text-decoration: underline; 
			}
 			.ftitle{
 				text-align: center;
 				padding: 20px 0;
 				font-size: 26px;
 			}
 			.form-btns{
 				text-align: center;
 			}
 			textarea {width: 300px;}
 			.filetip{
 				float: right;
    			padding-right: 100px;
    			color: #999;
    			font-size: 12px;
    			font-weight: normal;
 			}
 			.layui-input-block .layui-input{width: 300px;}
        </style>
    </head>
    <body>
	<form class="layui-form" action="/ssm/ent/regform" method="post" onsubmit="return dbcheck();" enctype="multipart/form-data">
		<div class="container">
			<h3 class="ftitle">招方注册</h3>
			<div class="layui-form-item">
				<label class="layui-form-label">用户名</label>
				<div class="layui-input-block">
					<input type="text" name="userName" id="username" onblur="checkName();" required lay-verify="required" placeholder="请输入用户名" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">登录密码</label>
				<div class="layui-input-inline">
					<input type="password" name="pwd" required lay-verify="required" placeholder="登录密码" autocomplete="off" class="layui-input">
				</div>
				<!-- <div class="layui-form-mid layui-word-aux">辅助文字</div> -->
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">企业名称</label>
				<div class="layui-input-block">
					<input type="text" name="enterpriseName" required lay-verify="required" placeholder="企业名称" autocomplete="off" class="layui-input">
				</div>
			</div>
			<!-- 用户名、公司名称、电话号码、邮箱地址、法人代表、统一社会信用代码、注册资金、营业地址、密码、公司简介 -->
			<div class="layui-form-item">
				<label class="layui-form-label">电话号码</label>
				<div class="layui-input-block">
					<input type="text" name="tel" required lay-verify="required" placeholder="电话号码" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">邮箱地址</label>
				<div class="layui-input-block">
					<input type="email" name="email" required lay-verify="required" placeholder="邮箱地址" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">法人代表</label>
				<div class="layui-input-block">
					<input type="text" name="frdb" required lay-verify="required" placeholder="法人代表" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">统一社会信用代码</label>
				<div class="layui-input-inline">
					<input type="text" name="taxCode" required lay-verify="required" placeholder="统一社会信用代码" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">注册资金</label>
				<div class="layui-input-inline">
					<input type="text" name="regAmount" required lay-verify="required" placeholder="注册资金" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">营业地址</label>
				<div class="layui-input-inline">
					<input type="text" name="address" required lay-verify="required" placeholder="营业地址" autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">公司简介</label>
				<div class="layui-input-inline">
					<textarea rows="4" name="entDesc"></textarea>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">资质文件</label>
				<div class="layui-input-inline">
					<input type="file" name="file" required lay-verify="required"  autocomplete="off" class="layui-input">
				</div>
				<div class="filetip">如果有多个文件可以压缩后上传</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">&nbsp;</label>
				<div class="form-btns">
					<input type="submit" class="layui-btn layui-btn-normal" value="注册">
					<!-- <button class="layui-btn" lay-submit lay-filter="formDemo">登陆</button> -->
					<input type="reset" class="layui-btn layui-btn-warm">
				</div>
			</div>
		</div>
	</form>
	<script>
		layui.use(['form', 'layedit', 'laydate'], function(){
		  var form = layui.form
		  ,layer = layui.layer
		  ,layedit = layui.layedit
		  ,laydate = layui.laydate;
		});
		var check = false;
		function checkName(){
			var username=$("#username").val();
			$.post(
				'/ssm/ent/checkuser',
				{"username": username},
				function (data){
					if(data == 0){
						check = true;
					}else{
						layer.alert('该用户名已被使用，请登录或使用其它用户名！', {
							icon: 5,
							title: "提示"
							});
					}
				}
			);
		}
		function dbcheck(){
			return check;
		}
	</script>
    </body>
</html>