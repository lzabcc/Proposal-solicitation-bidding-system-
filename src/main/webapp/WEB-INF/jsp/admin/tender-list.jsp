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
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_menu.jsp"></jsp:include>
  
  	<div class="layui-body ssm-table">
	    <!-- 内容主体区域 -->
	    <div class="search-form layui-row">
			<form action="/ssm/admin/tendermgr" method="post">
				<div class="layui-input-inline">
					<input type="text" name="kw" value="${kw }" class="layui-input" placeholder="项目名称">
				</div>
				<div class="layui-input-inline" style="width: 350px;">
					<select name="type" class="layui-input">
						<option value="-1" <c:if test='${type eq "-1" }'>selected="selected"</c:if>>所有类型</option>
						<option value="工程类" <c:if test='${type eq "工程类" }'>selected="selected"</c:if>>工程类</option>
						<option value="产品类" <c:if test='${type eq "产品类" }'>selected="selected"</c:if>>产品类</option>
						<option value="服务类" <c:if test='${type eq "服务类" }'>selected="selected"</c:if>>服务类</option>
					</select>
				</div>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn">
					  <i class="layui-icon">&#xe615;</i>搜索
					</button>
				</div>
			</form>
		</div>
		<table class="layui-table">
		  <thead>
		    <tr>
		    	<th>征集单位</th>
		    	<th>项目编号</th>
		      	<th>项目名称</th>
		      	<th>项目类型</th>
		      	<th>预算</th>
		      	<th>申请时间</th>
		      	<th>征集截止时间</th>
		      	<th>状态</th>
		      	<th>操作</th>
		    </tr> 
		  </thead>
		  <tbody>
		  	<c:forEach items="${page.records }" var="row">
		  		<tr>
		  			<td class="text-center longtxt">${row.ent.enterpriseName }</td>
		  			<td class="text-center">${row.ten.tenderNo }</td>
		  			<td class="text-center longtxt">${row.ten.projectName }</td>
		  			<td class="text-center">${row.ten.projectType }</td>
		  			<td class="text-center">${row.ten.budget }</td>
		  			<td class="text-center"><fmt:formatDate value="${row.ten.publishTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<td class="text-center"><fmt:formatDate value="${row.ten.endTime }" pattern="yyyy-MM-dd HH:mm"/></td>
		  			<td class="text-center">
		  				<c:if test="${row.ten.status eq -1 }"><span class="layui-badge">已拒绝</span></c:if>
		  				<c:if test="${row.ten.status eq 0 }"><span class="layui-badge layui-bg-cyan">待审核</span></c:if>
		  				<c:if test="${row.ten.status eq 1 }"><span class="layui-badge layui-bg-blue">征集中</span></c:if>
		  				<c:if test="${row.ten.status eq 2 }"><span class="layui-badge layui-bg-green">已完成</span></c:if>
		  				<c:if test="${row.ten.status eq 3 }"><span class="layui-badge layui-bg-black">流标</span></c:if>
		  				<c:if test="${row.ten.status eq 99 }"><span class="layui-badge layui-bg-gray">已截止</span></c:if>
		  			</td>
		  			<td class="text-center">
		  				<a class="layui-btn layui-btn-xs" href="/ssm/admin/tender-detail?tid=${row.ten.tenderId }"><i class="layui-icon">&#xe702;</i>详情</a>
		  				<c:if test="${row.ten.status eq 0 }">
		  				<a class="layui-btn layui-btn-xs layui-btn-normal" href="javascript:void(0);" onclick="act(${row.ten.tenderId });"><i class="layui-icon">&#xe605;</i>通过</a>
		  				<a class="layui-btn layui-btn-xs layui-btn-warm" href="javascript:void(0);" onclick="dis(${row.ten.tenderId });"><i class="layui-icon">&#x1006;</i>拒绝</a>
		  				</c:if>
		  			</td>
		  		</tr>
		  	</c:forEach>
		  </tbody>
		</table>
		<div id="pageview"></div>
	</div>
	
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
	<script type="text/javascript">
		/* layui.use('laypage', function(){
		  var laypage = layui.laypage;
		  
		  //执行一个laypage实例
		  laypage.render({
		    elem: 'pageview' //注意，这里的 test1 是 ID，不用加 # 号
		    ,count: ${page.totalrecord} //数据总数，从服务端得到
		  });
		}); */
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

		function act(eid){
			layer.confirm('确认通过该征集申请？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/checktender?status=1&tid="+eid;
			});
		}
		function dis(eid){
			layer.confirm('确认拒绝该征集申请？', {icon: 3, title:'提示'}, function(index){
				window.location.href="/ssm/admin/checktender?status=-1&tid="+eid;
			});
		}
	</script>
</body>
</html>