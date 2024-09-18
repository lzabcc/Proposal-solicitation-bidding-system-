<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
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
			  <a href="/ssm/ent/expertmgr">征集管理</a>
			  <a href="#">邀请评标专家</a>
			</span>
	    </div>
	    <c:if test="${aicount gt 0 and fn:length(list) == 0 }">
	    	<div class="layui-bg-gray pd-10">已邀请过评标专家</div>
	    </c:if>
	    <c:if test="${fn:length(list) gt 0 }">
	    <form class="layui-form" action="inviteform" method="post">
			<table class="layui-table" style="width: 80%; margin: 0 auto;">
			  <thead>
			    <tr>
			      <th>选择</th>
			      <th>专家姓名</th>
			      <th>职称</th>
			      <th>专家类别</th>
			      <th>专业方向</th>
			      <th>操作</th>
			    </tr> 
			  </thead>
			  <tbody>
			  	<c:forEach items="${list }" var="row">
			  		<tr>
			  			<td class="text-center">
			  				<%-- <div class="layui-input-block">
						      <input type="checkbox" name="exps" value="${row.expertId }">
						    </div> --%>
							      <input type="checkbox" name="exps" title="选择" value="${row.expertId }">
			  			</td>
			  			<td class="text-center">${row.realName }</td>
			  			<td class="text-center">${row.expertTitle }</td>
			  			<td class="text-center">${row.expertType }</td>
			  			<td class="text-center">${row.major }</td>
			  			<td class="text-center">
			  				<a class="layui-btn layui-btn-sm layui-btn-normal" href="javascript:void(0);" onclick="show(${row.expertId });"><i class="layui-icon">&#xe702;</i>专家详情</a>
			  			</td>
			  		</tr>
			  	</c:forEach>
			  </tbody>
			</table>
			<div class="text-center pd-10">
				<input type="hidden" name="tid" value="${tender.tenderId }">
				<button class="layui-btn <c:if test="${aicount gt 0 }">layui-btn-disabled</c:if>" lay-submit lay-filter="formDemo"><i class="fa fa-send" aria-hidden="true"></i>&nbsp;邀请</button>
			</div>
		</form>
		</c:if>
	</div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		  function show(tid){
				layui.use('layer', function(){
				  	var layer = layui.layer;
				  	layer.open({
				  	  type: 2, 
				  		area:["800px","520px"],
				  		scrollbar: true,
				  	  content: ['/ssm/ent/expdetail?eid='+tid, 'yes']
				  	}); 
				});
			}
	</script>
</body>
</html>