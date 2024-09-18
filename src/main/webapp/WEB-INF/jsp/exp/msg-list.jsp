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
  	<jsp:include page="../../include/exp_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/exp_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/exp/home">首页</a>
			  <a href="#">系统消息</a>
			</span>
	    </div>
	    <c:if test="${fn:length(page.records) == 0 }">
	    	<div class="layui-bg-gray pd-10">查无数据</div>
	    </c:if>
	    <c:if test="${fn:length(page.records) gt 0 }">
		<table class="layui-table">
		  <thead>
		    <tr>
		      <th>序号</th>
		      <th>时间</th>
		      <th>消息类型</th>
		      <th>内容</th>
		      <th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row" varStatus="vs">
		  		<tr>
		  			<td class="text-center">${vs.count }</td>
		  			<td class="text-center"><fmt:formatDate value="${row.msgTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		  			<td class="text-center">
	  					<span class="layui-badge">
			  				<c:if test='${row.msgType == "ASSESS_INVITE" }'>评标邀请</c:if>
		  				</span>
		  			</td>
		  			<td  class="text-center">${row.content }</td>
		  			<td  class="text-center">
		  				<%-- <a class="layui-btn layui-btn-sm" href="/ssm/admin/msgdetail?mid=${row.sysMsgId }"><i class="layui-icon">&#xe702;</i>详情</a> --%>
		  				<c:if test="${row.isRead == -1 }">
		  					<a class="layui-btn layui-btn-sm" href="${row.alink }"><i class="layui-icon">&#xe702;</i>前往评估</a>
		  				</c:if>
		  				<c:if test="${row.isRead != -1 }">已处理</c:if>
		  			</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
		<div id="pageview"></div>
		</c:if>
	</div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		layui.use('laypage', function(){
		  var laypage = layui.laypage;
		  
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'pageview' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: ${page.totalrecord} //数据总数，从服务端得到
		  });
		});
	</script>
</body>
</html>