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
  	<jsp:include page="../../include/admin_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/admin/home">首页</a>
			  <a href="/ssm/admin/noticemgr">公告管理</a>
			</span>
	    </div>
	    <div class="search-form layui-row">
			<form action="/ssm/admin/noticemgr" method="post">
				<div class="layui-input-inline">
					<input type="text" name="kw" value="${kw }" class="layui-input" placeholder="关键字">
				</div>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn">
					  <i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</form>
		</div>
	    <form class="layui-form" action="inviteform" method="post">
			<table lay-filter="demo">
			  <thead>
			    <tr>
			      <th lay-data="{field:'type', width:150}">发布时间</th>
			      <th lay-data="{field:'type2', width:100}">公告类型</th>
			      <th lay-data="{field:'type3'}">标题</th>
			      <th lay-data="{field:'type4'}">内容</th>
			      <th lay-data="{field:'type5', width:160}">操作</th>
			    </tr> 
			  </thead>
			  <tbody>
			  	<c:forEach items="${page.records }" var="row">
			  		<tr>
			  			<td class="text-center"><fmt:formatDate value="${row.publishTime }" pattern="yyyy-MM-dd HH:mm"/></td>
			  			<td class="text-center">${row.noticeType }</td>
			  			<td class="text-center">${row.title }</td>
			  			<td class="text-center">${row.content }</td>
			  			<td class="text-center">
			  				<a class="layui-btn layui-btn-sm" href="/ssm/admin/notice-detail?tid=${row.noticeId }"><i class="layui-icon">&#xe702;</i>详情</a>
			  				<a class="layui-btn layui-btn-sm layui-btn-danger" href="javascript:void(0);" onclick="cfm(${row.noticeId });"><i class="layui-icon">&#xe640;</i>删除</a>
			  			</td>
			  		</tr>
			  	</c:forEach>
			  </tbody>
			</table>
		</form>
		<div id="pageview"></div>
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
	
		  layui.use('laypage', function(){
			  var laypage = layui.laypage;
			  
			  //执行一个laypage实例
			  laypage.render({
			    elem: 'pageview' //注意，这里的 test1 是 ID，不用加 # 号
			    ,count: ${page.totalrecord} //数据总数，从服务端得到
			  });
			});

		  function cfm(eid){
			layer.confirm('确认删除该公告吗？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/deletenotice?eid="+eid;
			});
		}
	</script>
</body>
</html>