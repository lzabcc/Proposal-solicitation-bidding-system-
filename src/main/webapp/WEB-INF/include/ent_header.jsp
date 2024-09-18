<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-header">
  <div class="layui-logo head-logo">方案征集管理系统</div>
  <!-- <ul class="layui-nav layui-layout-left head-msg">
    <li class="layui-nav-item"><a href="">待审核征集方<span class="layui-badge">6</span></a></li>
    <li class="layui-nav-item"><a href="">待审核供应商<span class="layui-badge layui-bg-gray">0</span></a></li>
    <li class="layui-nav-item"><a href="">待审核征集方案<span class="layui-badge">1</span></a></li>
  </ul> -->
  <ul class="layui-nav layui-layout-right">
  	<li class="layui-nav-item">
    	<a href="#"><i class="layui-icon">&#xe66f;</i>征集人</a>
  	</li>
    <li class="layui-nav-item">
    	<a href="javascript:;">${sessionScope.currEnt.enterpriseName }</a>
      	<dl class="layui-nav-child">
        	<dd><a href="/ssm/ent/profile">个人中心</a></dd>
        	<dd><a href="/ssm/ent/tomdfprofile">修改个人信息</a></dd>
        	<!-- <dd><a href="/ssm/ent/tomdfpwd">修改密码</a></dd> -->
      	</dl>
    </li>
    <li class="layui-nav-item"><a href="/ssm/ent/logout">登出</a></li>
  </ul>
</div>