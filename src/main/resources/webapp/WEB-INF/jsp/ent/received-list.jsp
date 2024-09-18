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
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  	<jsp:include page="../../include/ent_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_menu.jsp"></jsp:include>
  
  	<div class="layui-body ssm-table">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			  <a href="#">已收到的标书</a>
			</span>
	    </div>
		<table class="layui-table">
		  <thead>
		    <tr>
		      	<th>项目类型</th>
		      	<th>项目名称</th>
		    	<th>征集单位</th>
		      	<th>预算</th>
		      	<th>征集时间</th>
		      	<th>征集报价</th>
		      	<th>状态</th>
		      	<th >操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${list }" var="row">
		  		<tr>
		  			<td class="text-center">${row.ten.projectType }</td>
		  			<td class="text-center">${row.ten.projectName }</td>
		  			<td class="text-center">${row.sup.entName }</td>
		  			<td class="text-center">${row.ten.budget }</td>
		  			<td class="text-center"><fmt:formatDate value="${row.th.tenderTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<td class="text-center">${row.th.amount }</td>
		  			<td class="text-center">
		  				<c:if test="${row.th.status eq 0 }"><span class="layui-badge layui-bg-blue">评标中</span></c:if>
		  				<c:if test="${row.th.status eq 2 }"><span class="layui-badge layui-bg-orange">已中标</span></c:if>
		  				<c:if test="${row.th.status eq 3 }"><span class="layui-badge layui-bg-gray">未中标</span></c:if>
		  			</td>
		  			<td class="text-center">
		  				<a class="layui-btn layui-btn-xs" href="/ssm/ent/receivedetail?thid=${row.th.tenderHistoryId }"><i class="layui-icon">&#xe702;</i>详情</a>
		  				<c:if test="${row.th.status eq 1 }">
		  				<a class="layui-btn layui-btn-xs layui-btn-normal" href="/ssm/sup/toupdateapp?thid=${row.th.tenderHistoryId }"><i class="layui-icon">&#xe642;</i>修改</a>
		  				</c:if>
		  			</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
	</div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		layui.use('table', function(){
			var table = layui.table;
			 console.log(table);
			//转换静态表格
			table.init('demo', {
			  //height: 315, //设置高度
			  limit: 10 //注意：请务必确保 limit 参数（默认：10）是与你服务端限定的数据条数一致
			  //支持所有基础参数
			}); 
		});

	</script>
</body>
</html>