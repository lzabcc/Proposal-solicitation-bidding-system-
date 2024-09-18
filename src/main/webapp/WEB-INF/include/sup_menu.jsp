<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-side layui-bg-black">
  <div class="layui-side-scroll">
    <ul class="layui-nav layui-nav-tree"  lay-filter="test">
      <li class="layui-nav-item <c:if test='${currMenu0 eq "tender" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-cogs" aria-hidden="true"></i>&nbsp;招征集管理</a>
        <dl class="layui-nav-child">
        	<dd <c:if test='${currMenu1 eq "tenderlist" }'>class="layui-this"</c:if>><a href="/ssm/sup/tenderlist"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;查看征集</a></dd>
          	<dd  <c:if test='${currMenu1 eq "myapply" }'>class="layui-this"</c:if>><a href="/ssm/sup/myapply"><i class="fa fa-tag" aria-hidden="true"></i>&nbsp;我的征集</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "notice" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-comments" aria-hidden="true"></i>&nbsp;公告管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "noticemgr" }'>class="layui-this"</c:if>><a href="/ssm/sup/noticemgr"><i class="fa fa-commenting" aria-hidden="true"></i>&nbsp;公告列表</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item  <c:if test='${currMenu0 eq "profile" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="layui-icon">&#xe66f;</i>&nbsp;个人中心</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "userinfo" }'>class="layui-this"</c:if>><a href="/ssm/sup/profile"><i class="layui-icon">&#xe66f;</i>&nbsp;用户信息</a></dd>
          <dd <c:if test='${currMenu1 eq "mdfpwd" }'>class="layui-this"</c:if>><a href="/ssm/sup/tomdfpwd"><i class="layui-icon">&#xe673;</i>&nbsp;修改密码</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>