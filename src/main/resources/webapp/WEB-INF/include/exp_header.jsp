<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-header">
  <div class="layui-logo head-logo">方案征集管理系统</div>
  <ul class="layui-nav layui-layout-left head-msg">
    <li class="layui-nav-item"><a href="/ssm/exp/sysmsg?msgType=ASSESS_INVITE">评标邀请<span class="layui-badge <c:if test="${sessionScope.ASSESS_INVITE eq 0 }">layui-bg-gray</c:if>">${sessionScope.ASSESS_INVITE }</span></a></li>
  </ul>
  <ul class="layui-nav layui-layout-right">
    <li class="layui-nav-item">
      <a href="javascript:;">
        <i class="layui-icon">&#xe66f;</i>&nbsp;评标专家&nbsp;${sessionScope.currExp.realName }
      </a>
      <dl class="layui-nav-child">
        <dd><a href="/ssm/exp/profile">个人中心</a></dd>
        <dd><a href="/ssm/exp/tomdfpwd">修改密码</a></dd>
      </dl>
    </li>
    <li class="layui-nav-item"><a href="/ssm/exp/logout">登出</a></li>
  </ul>
</div>