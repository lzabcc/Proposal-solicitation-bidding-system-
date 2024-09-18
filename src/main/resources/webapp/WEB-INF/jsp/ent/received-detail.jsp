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
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<jsp:include page="../../include/ent_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="/ssm/ent/receivedapp">已收到标书</a>
			  <a href="#">标书详情</a>
			</span>
	    </div>
	    <div class="layui-card">
		  	<div class="layui-card-header layui-bg-green" style="font-size: 18px;">征集书详情信息</div>
		  	<div class="layui-card-body">
			  <div class="layui-form-item">
			    <label class="layui-form-label">征集人</label>
			    <div class="layui-input-block">
			      <input type="text" name="projectName" value="${vo.sup.entName }" disabled="disabled" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">项目名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="projectName" value="${vo.ten.projectName }" disabled="disabled" class="layui-input">
			    </div>
			  </div>
			  <!-- 征集信息填写内容包括负责人、手机号码、邮箱、报价、上传征集相关文件 -->
			  <div class="layui-form-item">
			    <label class="layui-form-label">征集方负责人</label>
			    <div class="layui-input-block">
			      <input type="text" name="incharge" value="${vo.ten.incharge }" class="layui-input" disabled="disabled">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">负责人手机号</label>
			    <div class="layui-input-block">
			      <input type="number" name="contact" value="${vo.th.contact }" class="layui-input" disabled="disabled">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">负责人邮箱</label>
			    <div class="layui-input-block">
			      <input type="text" name="email" value="${vo.th.email }" class="layui-input" disabled="disabled">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">报价</label>
			    <div class="layui-input-block">
			      <input type="text" name="amount" value="${vo.th.amount }" required  placeholder="请输入金额" autocomplete="off" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">标书文件</label>
			    <div class="layui-input-block">
			      	<a href="/ssm/upload/${vo.th.attachment }"><i class="fa fa-file-archive-o" aria-hidden="true" style="font-size: 22px; padding-top: 6px; color: #009688;"></i></a>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">状态</label>
			    <div class="layui-input-block">
			    	<c:if test="${vo.th.status eq 0 }"><span class="layui-badge layui-bg-blue">待评标</span></c:if>
	  				<c:if test="${vo.th.status eq 2 }"><span class="layui-badge layui-bg-orange">已中标</span></c:if>
	  				<c:if test="${vo.th.status eq 3 }"><span class="layui-badge layui-bg-gray">未中标</span></c:if>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			      	<button type="reset" class="layui-btn" onclick="javascript: history.go(-1);"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;返回</button>
			    </div>
			  </div>
		  </div>
	  </div>
  	</div>
  	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
//JavaScript代码区域
	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#endtime' //指定元素
	   	,type: 'datetime'
	    ,format: 'yyyy-MM-dd HH:mm' //可任意组合
	  });
	});
</script>
</body>
</html>