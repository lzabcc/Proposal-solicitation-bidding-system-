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
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			  <a href="#">定标管理</a>
			</span>
	    </div>
	    <div class="search-form layui-row">
			<form action="/ssm/ent/confirmtender" method="post">
				<div class="layui-input-inline">
					<input type="text" name="kw" value="${kw }" class="layui-input" placeholder="项目名称">
				</div>
				<div class="layui-input-inline" style="width: 150px;">
					<select name="type" class="layui-input">
						<option value="-1" <c:if test='${type eq "-1" }'>selected="selected"</c:if>>所有类型</option>
						<option value="工程类" <c:if test='${type eq "工程类" }'>selected="selected"</c:if>>工程类</option>
						<option value="产品类" <c:if test='${type eq "产品类" }'>selected="selected"</c:if>>产品类</option>
						<option value="服务类" <c:if test='${type eq "服务类" }'>selected="selected"</c:if>>服务类</option>
					</select>
				</div>
				<%-- <div class="layui-input-inline" style="width: 150px;">
					<select name="status" class="layui-input">
						<option value="-100" <c:if test='${status eq "-100" }'>selected="selected"</c:if>>所有状态</option>
						<option value="0" <c:if test='${status eq "0" }'>selected="selected"</c:if>>待审核</option>
						<option value="1" <c:if test='${status eq "1" }'>selected="selected"</c:if>>征集中</option>
						<option value="2" <c:if test='${status eq "2" }'>selected="selected"</c:if>>已完成</option>
						<option value="3" <c:if test='${status eq "3" }'>selected="selected"</c:if>>流标</option>
						<option value="-1" <c:if test='${status eq "-1" }'>selected="selected"</c:if>>已拒绝</option>
						<option value="99" <c:if test='${status eq "99" }'>selected="selected"</c:if>>已截止</option>
					</select>
				</div> --%>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn">
					  <i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</form>
		</div>
		<c:if test="${fn:length(list) == 0 }">
	    	<div class="layui-bg-gray pd-10">查无数据</div>
	    </c:if>
	    <c:if test="${fn:length(list) gt 0 }">
	    <table class="layui-table">
		  <thead>
		    <tr>
		      <th>项目名称</th>
		      <th>项目类型</th>
		      <th>预算</th>
		      <th>征集截止时间</th>
		      <th>关键字</th>
		      <th>负责人</th>
		      <th>状态</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${list }" var="row">
		  		<tr>
		  			<td class="text-center">${row.projectName }</td>
		  			<td class="text-center">${row.projectType }</td>
		  			<td class="text-center">${row.budget }</td>
		  			<td class="text-center"><fmt:formatDate value="${row.endTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<td class="text-center">${row.keyWords }</td>
		  			<td class="text-center">${row.incharge }</td>
		  			<td class="text-center">
		  				<c:if test="${row.status eq -1 }"><span class="layui-badge">已拒绝</span></c:if>
		  				<c:if test="${row.status eq 0 }"><span class="layui-badge layui-bg-cyan">待审核</span></c:if>
		  				<c:if test="${row.status eq 1 }"><span class="layui-badge layui-bg-orange">征集中</span></c:if>
		  				<c:if test="${row.status eq 2 }"><span class="layui-badge layui-bg-green">已完成</span></c:if>
		  				<c:if test="${row.status eq 3 }"><span class="layui-badge layui-bg-black">流标</span></c:if>
		  				<c:if test="${row.status eq 99 }"><span class="layui-badge layui-bg-gray">已截止</span></c:if>
		  			</td>
		  			<td class="text-center">
		  				<c:if test="${row.winner eq -99 and row.status eq 1 }">
			  				<a class="layui-btn layui-btn-sm layui-btn-normal" href="/ssm/ent/expassess?tid=${row.tenderId }"><i class="layui-icon">&#xe6b2;</i>专家意见</a>
		  				</c:if>
		  				<c:if test="${row.winner eq -100 and row.status eq 1 }">
			  				<a type="button" class="layui-btn layui-btn-sm layui-btn-normal" href="/ssm/ent/inviteexpert?tid=${row.tenderId }">
						  		<i class="layui-icon">&#xe770;</i>邀请专家
							</a>
		  				</c:if>
		  				<c:if test="${row.status eq 1 }">
		  				<a class="layui-btn layui-btn-sm" href="/ssm/ent/toconfirmpage?tid=${row.tenderId }"><i class="layui-icon">&#xe605;</i>定标</a>
		  				<a class="layui-btn layui-btn-sm layui-btn-danger" href="javascript:void(0);" onclick="act(${row.tenderId });"><i class="layui-icon">&#x1006;</i>流标</a>
		  				</c:if>
		  			</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
		</c:if>
	</div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		function act(eid){
			layer.confirm('确定该征集项目流标吗？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/ent/tenderfaild?tid="+eid;
			});
		}
		
	</script>
</body>
</html>