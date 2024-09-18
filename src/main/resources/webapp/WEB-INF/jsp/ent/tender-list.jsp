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
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			</span>
	    </div>
	    <div class="search-form layui-row">
			<form action="/ssm/ent/tendermgr" method="post">
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
				<div class="layui-input-inline" style="width: 150px;">
					<select name="status" class="layui-input">
						<option value="-100" <c:if test='${status eq "-100" }'>selected="selected"</c:if>>所有状态</option>
						<option value="0" <c:if test='${status eq "0" }'>selected="selected"</c:if>>待审核</option>
						<option value="1" <c:if test='${status eq "1" }'>selected="selected"</c:if>>征集中</option>
						<option value="2" <c:if test='${status eq "2" }'>selected="selected"</c:if>>已完成</option>
						<option value="3" <c:if test='${status eq "3" }'>selected="selected"</c:if>>流标</option>
						<option value="-1" <c:if test='${status eq "-1" }'>selected="selected"</c:if>>已拒绝</option>
						<option value="99" <c:if test='${status eq "99" }'>selected="selected"</c:if>>已截止</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn">
					  <i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</form>
		</div>
		<table lay-filter="demo">
		  <thead>
		    <tr>
		    	<th lay-data="{field:'tno'}">项目编号</th>
		      <th lay-data="{field:'username', width:200}">项目名称</th>
		      <th lay-data="{field:'type'}">项目类型</th>
		      <th lay-data="{field:'budget'}">预算</th>
		      <th lay-data="{field:'apptime', width:150}">申请时间</th>
		      <th lay-data="{field:'endtime', width:150}">征集截止时间</th>
		      <!-- <th lay-data="{field:'kw'}">关键字</th> -->
		      <th lay-data="{field:'incharge'}">负责人</th>
		      <th lay-data="{field:'status'}">状态</th>
		      <th lay-data="{field:'opt'}">操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td class="text-center">${row.tenderNo }</td>
		  			<td class="text-center">${row.projectName }</td>
		  			<td class="text-center">${row.projectType }</td>
		  			<td class="text-center">${row.budget }</td>
		  			<td class="text-center"><fmt:formatDate value="${row.publishTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<td class="text-center"><fmt:formatDate value="${row.endTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<%-- <td class="text-center">${row.keyWords }</td> --%>
		  			<td class="text-center">${row.incharge }</td>
		  			<td class="text-center">
		  				<c:if test="${row.status eq -1 }"><span class="layui-badge">已拒绝</span></c:if>
		  				<c:if test="${row.status eq 0 }"><span class="layui-badge layui-bg-cyan">待审核</span></c:if>
		  				<c:if test="${row.status eq 1 }"><span class="layui-badge layui-bg-blue">征集中</span></c:if>
		  				<c:if test="${row.status eq 2 }"><span class="layui-badge layui-bg-green">已完成</span></c:if>
		  				<c:if test="${row.status eq 3 }"><span class="layui-badge layui-bg-black">流标</span></c:if>
		  				<c:if test="${row.status eq 99 }"><span class="layui-badge layui-bg-gray">已截止</span></c:if>
		  			</td>
		  			<td class="text-center">
		  				<a class="layui-btn layui-btn-xs" href="/ssm/ent/tender-detail?tid=${row.tenderId }"><i class="layui-icon">&#xe702;</i>详情</a>
		  			</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
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
			    ,limit: 20
			    ,layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip']
			    ,curr: ${page.currentpage}
			    ,pages: ${page.totalpage}
			    ,jump: function(e, first){ //触发分页后的回调  
			        if(!first){ //一定要加此判断，否则初始时会无限刷新  
			        	var pagesize = e.limit;
			            location.href = '?currentpage='+e.curr+"&maxresult="+pagesize;
			        }  
			    }
			  });
			});
	</script>
</body>
</html>