<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="layui-side layui-bg-black">
  <div class="layui-side-scroll">
    <ul class="layui-nav layui-nav-tree"  lay-filter="test">
      <li class="layui-nav-item <c:if test='${currMenu0 eq "tender" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-cogs" aria-hidden="true"></i>&nbsp;征集管理</a>
        <dl class="layui-nav-child">
        	<dd <c:if test='${currMenu1 eq "tendermgr" }'>class="layui-this"</c:if>><a href="/ssm/ent/tendermgr"><i class="fa fa-book" aria-hidden="true"></i>&nbsp;征集管理</a></dd>
          	<dd <c:if test='${currMenu1 eq "tenderadd" }'>class="layui-this"</c:if>><a href="/ssm/ent/toaddtender"><i class="fa fa-send" aria-hidden="true"></i>&nbsp;征集申请</a></dd>
          	<%-- <dd <c:if test='${currMenu1 eq "receivedapp" }'>class="layui-this"</c:if>><a href="/ssm/ent/receivedapp"><i class="fa fa-folder-open" aria-hidden="true"></i>&nbsp;已收到的征集书</a></dd> --%>
          	<dd <c:if test='${currMenu1 eq "confirmtender" }'>class="layui-this"</c:if>><a href="/ssm/ent/confirmtender"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;定标管理</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item <c:if test='${currMenu0 eq "notice" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="fa fa-comments" aria-hidden="true"></i>&nbsp;公告管理</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "noticemgr" }'>class="layui-this"</c:if>><a href="/ssm/ent/noticemgr"><i class="fa fa-commenting" aria-hidden="true"></i>&nbsp;公告列表</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item  <c:if test='${currMenu0 eq "profile" }'>layui-nav-itemed</c:if>">
        <a href="javascript:;"><i class="layui-icon">&#xe66f;</i>&nbsp;个人中心</a>
        <dl class="layui-nav-child">
          <dd <c:if test='${currMenu1 eq "userinfo" }'>class="layui-this"</c:if>><a href="/ssm/ent/profile"><i class="layui-icon">&#xe66f;</i>&nbsp;用户信息</a></dd>
          <dd <c:if test='${currMenu1 eq "mdfpwd" }'>class="layui-this"</c:if>><a href="/ssm/ent/tomdfpwd"><i class="layui-icon">&#xe673;</i>&nbsp;修改密码</a></dd>
        </dl>
      </li>
    </ul>
  </div>
</div>