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
	<jsp:include page="../../include/sup_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/sup_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/sup/home">首页</a>
			  <a href="/ssm/sup/tenderlist">查看标书</a>
			  <a href="#">征集</a>
			</span>
	    </div>
	    <form class="layui-form" action="/ssm/sup/apply" method="post" enctype="multipart/form-data">
		  <div class="layui-form-item">
		    <label class="layui-form-label">征集单位</label>
		    <div class="layui-input-block">
		      <input type="text" name="projectName" value="${vo.ent.enterpriseName }" disabled="disabled" class="layui-input">
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
		      <input type="text" name="incharge" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">负责人手机号</label>
		    <div class="layui-input-block">
		      <input type="number" name="contact" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">负责人邮箱</label>
		    <div class="layui-input-block">
		      <input type="text" name="email" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">报价</label>
		    <div class="layui-input-block">
		      <input type="text" name="amount" required  lay-verify="required" placeholder="请输入金额" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">标书文件</label>
		    <div class="layui-input-block">
		      	<input type="file" name="file" autocomplete="off" class="layui-input">
			    <div class="layui-form-mid layui-word-aux">如果有多个文件，请以压缩包的形式上传</div>
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		    	<input type="hidden" value="${sup.supplierId }" name="bidder">
		    	<input type="hidden" value="${vo.ten.tenderId }" name="tendering">
		    	<input type="hidden" value="${vo.ten.tenderee }" name="tenderee">
		    	<input type="hidden" value="0" name="status">
		      	<button class="layui-btn" lay-submit lay-filter="formDemo"><i class="fa fa-send" aria-hidden="true"></i>&nbsp;提交</button>
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