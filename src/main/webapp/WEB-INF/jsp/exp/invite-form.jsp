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
	<jsp:include page="../../include/exp_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/exp_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/exp/home">首页</a>
			  <a href="/ssm/exp/ivitedlist">评标邀请</a>
			  <a href="#">评估</a>
			</span>
	    </div>
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green" style="font-size: 18px;">《${ten.projectName }》-专家评估</div>
		  <div class="layui-card-body">
		    <form class="layui-form" action="/ssm/exp/submitass" method="post">
			  <div class="layui-form-item">
			    <label class="layui-form-label">征集单位</label>
			    <div class="layui-input-block">
			      <input type="text" name="projectName" value="${ent.enterpriseName }" disabled="disabled" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">项目名称</label>
			    <div class="layui-input-block">
			      <input type="text" name="projectName" value="${ten.projectName }" disabled="disabled" class="layui-input">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">推荐供应商</label>
			    <div class="layui-input-block" style="width: 400px;">
			      	<select name="winner">
			        	<c:forEach items="${suplist}" var="sup">
				        	<option value="${sup.supplierId }">${sup.entName }</option>
			        	</c:forEach>
			      	</select>
			    </div>
			  </div>
				<div class="layui-form-item">
					<label class="layui-form-label">前瞻性得分</label>
					<div class="layui-input-block">
						<input class="layui-input" cols=""  name="score1"></input>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">可行性得分</label>
					<div class="layui-input-block">
						<input class="layui-input" cols=""  name="score2"></input>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">研究基础得分</label>
					<div class="layui-input-block">
						<input class="layui-input" cols=""  name="score3"></input>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">经济效益得分</label>
					<div class="layui-input-block">
						<input class="layui-input" cols=""  name="score4"></input>
					</div>
				</div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">推荐理由</label>
			    <div class="layui-input-block">
			    	<textarea rows="4" cols="" style="width: 100%;" name="reason"></textarea>
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <div class="layui-input-block">
			    	<input type="hidden" value="${tid }" name="tender">
			    	<input type="hidden" value="${iid }" name="iid">
			      	<button class="layui-btn" lay-submit lay-filter="formDemo"><i class="fa fa-send" aria-hidden="true"></i>&nbsp;提交</button>
			      	<button type="reset" class="layui-btn layui-btn-primary"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;重置</button>
			    </div>
			  </div>
			</form>
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