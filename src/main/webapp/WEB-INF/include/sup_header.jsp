<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-header">
  <div class="layui-logo head-logo">方案征集管理系统</div>
  <ul class="layui-nav layui-layout-left head-msg">
    <li class="layui-nav-item"><a href="/ssm/sup/sysmsg?msgType=TENDER_INVITE">征集邀请<span class="layui-badge <c:if test="${sessionScope.TENDER_INVITE eq 0 }">layui-bg-gray</c:if>">${sessionScope.TENDER_INVITE }</span></a></li>
    <li class="layui-nav-item"><a href="/ssm/sup/sysmsg?msgType=TENDER_RESULT">征集结果<span class="layui-badge <c:if test="${sessionScope.TENDER_RESULT eq 0 }">layui-bg-gray</c:if>">${sessionScope.TENDER_RESULT }</span></a></li>
  </ul>
  <ul class="layui-nav layui-layout-right">
  	<li class="layui-nav-item">
    	<a href="#"><i class="layui-icon">&#xe66f;</i>供应商</a>
  	</li>
    <li class="layui-nav-item">
      	<a href="javascript:;">${sessionScope.currSup.entName }</a>
      	<dl class="layui-nav-child">
        	<dd><a href="/ssm/sup/profile">个人中心</a></dd>
        	<dd><a href="/ssm/sup/tomdfpwd">修改密码</a></dd>
      	</dl>
    </li>
    <li class="layui-nav-item"><a href="/ssm/sup/logout">登出</a></li>
  </ul>
</div>