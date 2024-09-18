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
  	.layui-body .table-meta{
  		width: 150px;
  	}
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/exp_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/exp_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="layui-card">
		  <div class="layui-card-header layui-bg-green">专家信息</div>
		  <div class="layui-card-body">
		    <form action="/ssm/expert/updatexp" method="post">
		    <table class="layui-table">
			  <tbody>
			    <tr>
			      <td class="table-meta">姓名</td>
			      <td><input type="text"  class="layui-input" value="${exp.realName }" name="realName"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">登录账号</td>
			      <td><input type="text" class="layui-input" value="${exp.userName }" name="userName"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">职称</td>
			      <td><input type="text"  class="layui-input" value="${exp.expertTitle }" name="expertTitle"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">专业方向</td>
			      <td><input type="text"  class="layui-input" value="${exp.major }" name="major"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">专家类别</td>
			      <td>${exp.expertType}</td>
			    </tr>
			    <tr>
			      <td class="table-meta">工作单位</td>
			      <td><input type="text"  class="layui-input" value="${exp.company }" name="company"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">出生年月</td>
			      <td><input type="text"  class="layui-input" value="${exp.birth }" name="birth"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">电话</td>
			      <td><input type="text"  class="layui-input" value="${exp.mobile }" name="mobile"></td>
			    </tr>
			    <tr>
			      <td class="table-meta">简介</td>
			      <td><div>${exp.expertDesc }</div></td>
			    </tr>
	  			<tr>
	  				<td class="table-meta">操作</td>
	  				<td>
	  					<input type="hidden" value="${exp.expertId }" name="entId">
	  					<!-- <button class="layui-btn layui-btn-sm" lay-submit lay-filter="formDemo"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;修改</button> -->
	  					<button type="reset" class="layui-btn layui-btn-warm layui-btn-sm" onclick="javascript: history.go(-1);"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;返回</button>
	  				</td>
	  			</tr>
			  </tbody>
			</table>
			</form>
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