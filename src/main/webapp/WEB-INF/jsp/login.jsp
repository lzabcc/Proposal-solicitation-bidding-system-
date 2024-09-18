<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>方案征集管理系统</title>
  <!--_header 作为公共模版分离出去-->
  <jsp:include page="../include/_meta.jsp"></jsp:include>
  <!--/_header 作为公共模版分离出去-->
  <style type="text/css">
  		body{    background-color: #f2f2f2;
    color: #666;}
      		.container{
      			width: 420px;
      			height: 320px;
		 		 min-height: 320px;  
		 		 max-height: 320px;  
		 		 position: absolute;   
		 		 top: 0;  
		 		 left: 0;  
		 		 bottom: 0;  
		 		 right: 0;  
		 		 margin: auto;  
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
				border-radius: 5px;
        		height: 40px;
        		font-size: 15px;
        		margin: 0 auto;
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
 			}
 			.form-btns{
 				text-align: center;
 			}
 			.head1{
 				margin-top: 30px;
 				color: #fff;
 				text-align: center;
 			}
 			.abtn{
 				padding: 10px 0;
 				text-align: center;
 			}
        </style>
    </head>
    <body>
	<h1 class="head1" style="color: #666;">方案征集管理系统</h1>
	<form class="layui-form" action="/ssm/sup/loginform" method="post">
		<div class="container">
			<h3 class="ftitle">请选择用户角色</h3>
			<div class="layui-form-item" style="margin: 0; padding: 0; text-align: center;">
				<div class="abtn">
					<a class="layui-btn layui-btn-danger" href="/ssm/admin/login">
						  <i class="layui-icon">&#xe716;</i>管理员
					</a>
				</div>
				<div class="abtn">
					<a class="layui-btn layui-btn-warm" href="/ssm/ent/login">
						  <i class="layui-icon">&#xe65e;</i>征集方
					</a>
				</div>
				<div class="abtn">
					<a class="layui-btn layui-btn-normal" href="/ssm/sup/login">
						  <i class="layui-icon">&#xe770;</i>供应商
					</a>
				</div>
				<div class="abtn">
					<a class="layui-btn" href="/ssm/exp/login">
						  <i class="layui-icon">&#xe6b2;</i>专&nbsp;&nbsp;家
					</a>
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
			var reg = ${msg };
			$(function(){
				if(reg == 99){
					layui.use('layer', function(){
					  	var layer = layui.layer;
						layer.open({
						  title: '消息提示'
						  ,content: '注册申请已成功提交'
						});     
					});  
				}
			})
	</script>
    </body>
</html>