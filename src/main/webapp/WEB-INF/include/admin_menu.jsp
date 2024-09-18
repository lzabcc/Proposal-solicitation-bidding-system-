<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-side layui-bg-black">
  <div class="layui-side-scroll">
    <ul class="layui-nav layui-nav-tree"  lay-filter="test">
    	<li class="layui-nav-item <c:if test='${currMenu0 eq "home" }'>layui-nav-itemed</c:if>">
        <a class="" href="javascript:;"><i class="fa fa-home" aria-hidden="true"></i>&nbsp;首页</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "home" }'>class="layui-this"</c:if>><a href="/ssm/admin/home"><i class="fa fa-line-chart" aria-hidden="true"></i>&nbsp;数据统计</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "ent" }'>layui-nav-itemed</c:if>">
        <a class="" href="javascript:;"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;用户管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "entmgr" }'>class="layui-this"</c:if>><a href="/ssm/admin/entmgr"><i class="fa fa-briefcase" aria-hidden="true"></i>&nbsp;征集方</a></dd>
          <dd <c:if test='${currMenu1 eq "supmgr" }'>class="layui-this"</c:if>><a href="/ssm/admin/supmgr"><i class="fa fa-users" aria-hidden="true"></i>&nbsp;供应商</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "tender" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-cogs" aria-hidden="true"></i>&nbsp;征集管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "tendermgr" }'>class="layui-this"</c:if>><a href="/ssm/admin/tendermgr"><i class="fa fa-legal" aria-hidden="true"></i>&nbsp;征集方案审核</a></dd>
          <%-- <dd <c:if test='${currMenu1 eq "history" }'>class="layui-this"</c:if>><a href="javascript:;"><i class="fa fa-list-alt" aria-hidden="true"></i>&nbsp;征集记录</a></dd> --%>
          <%-- <dd <c:if test='${currMenu1 eq "chart" }'>class="layui-this"</c:if>><a href="/ssm/admin/chart"><i class="fa fa-line-chart" aria-hidden="true"></i>&nbsp;数据统计</a></dd> --%>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "expert" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-address-book" aria-hidden="true"></i>&nbsp;专家管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "expertmgr" }'>class="layui-this"</c:if>><a href="/ssm/admin/expertmgr"><i class="fa fa-user" aria-hidden="true"></i>&nbsp;专家列表</a></dd>
          <dd <c:if test='${currMenu1 eq "expertadd" }'>class="layui-this"</c:if>><a href="/ssm/admin/toaddexpert"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;新增专家</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "notice" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-comments" aria-hidden="true"></i>&nbsp;公告管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "noticemgr" }'>class="layui-this"</c:if>><a href="/ssm/admin/noticemgr"><i class="fa fa-commenting" aria-hidden="true"></i>&nbsp;公告列表</a></dd>
          <dd <c:if test='${currMenu1 eq "noticeadd" }'>class="layui-this"</c:if>><a href="/ssm/admin/toaddnotice"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;发布公告</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>