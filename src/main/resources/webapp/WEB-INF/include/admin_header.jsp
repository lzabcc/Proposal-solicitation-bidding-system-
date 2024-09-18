<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-header">
  <div class="layui-logo head-logo">方案征集管理系统</div>
  <ul class="layui-nav layui-layout-left head-msg">
    <li class="layui-nav-item"><a href="/ssm/admin/sysmsg?msgType=NEW_REGIST_ENT">待审核征集方<span class="layui-badge <c:if test="${sessionScope.NEW_REGIST_ENT eq 0 }">layui-bg-gray</c:if>">${sessionScope.NEW_REGIST_ENT }</span></a></li>
    <li class="layui-nav-item"><a href="/ssm/admin/sysmsg?msgType=NEW_REGIST_SUP">待审核供应商<span class="layui-badge <c:if test="${sessionScope.NEW_REGIST_SUP eq 0 }">layui-bg-gray</c:if>">${sessionScope.NEW_REGIST_SUP }</span></a></li>
    <li class="layui-nav-item"><a href="/ssm/admin/sysmsg?msgType=NEW_TENDER">待审核征集方案<span class="layui-badge <c:if test="${sessionScope.NEW_TENDER eq 0 }">layui-bg-gray</c:if>">${sessionScope.NEW_TENDER }</span></a></li>
     <li class="layui-nav-item"><a href="/ssm/admin/sysmsg">所有系统消息</a></li>
    <!-- <li class="layui-nav-item">
      <a href="javascript:;">其它系统</a>
      <dl class="layui-nav-child">
        <dd><a href="">邮件管理</a></dd>
        <dd><a href="">消息管理</a></dd>
        <dd><a href="">授权管理</a></dd>
      </dl>
    </li> -->
  </ul>
  <ul class="layui-nav layui-layout-right">
    <li class="layui-nav-item">
      <a href="javascript:;">
        系统管理员
      </a>
      <dl class="layui-nav-child">
        <!-- <dd><a href="/ssm/admin/profile">个人中心</a></dd> -->
        <dd><a href="/ssm/admin/tomdfpwd">修改密码</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a href="/ssm/admin/logout">登出</a></li>
  </ul>
</div>