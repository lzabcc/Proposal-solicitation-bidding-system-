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
  <%-- <jsp:include page="../../../include/admin_menu.jsp"></jsp:include> --%>
  <style type="text/css">
  	.layui-form-label{width: 120px;}
	.layui-input-block{margin-left: 152px;}
	.layui-anim layui-anim-upbit{z-index:99999;}
  </style>
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
			  <a href="/ssm/admin/expertmgr">专家管理</a>
			  <a href="#">修改专家信息</a>
			</span>
	    </div>
	    <form class="layui-form" action="updateexpert" method="post" onsubmit="getEditor();">
		  <div class="layui-form-item">
		    <label class="layui-form-label">用户名</label>
		    <div class="layui-input-block">
		      <input type="text" name="userName" value="${expert.userName }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">姓名</label>
		    <div class="layui-input-block">
		      <input type="text" name="realName" value="${expert.realName }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">职称</label>
		    <div class="layui-input-block">
		      <input type="text" name="expertTitle" value="${expert.expertTitle }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">专业方向</label>
		    <div class="layui-input-block">
		      <input type="text" name="major" value="${expert.major }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">出生年月</label>
		    <div class="layui-input-block">
		      <input type="text" name="birth" value="${expert.birth }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">工作单位</label>
		    <div class="layui-input-block">
		      <input type="text" name="company" value="${expert.company }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">电话</label>
		    <div class="layui-input-block">
		      <input type="text" name="mobile" value="${expert.mobile }" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">专家类别</label>
		    <div class="layui-input-block" style="width: 350px;">
		      <select name="expertType">
		        <option value="工程类" <c:if test='${expert.expertType eq "工程类" }'>selected="selected"</c:if>>工程类</option>
		        <option value="产品类" <c:if test='${expert.expertType eq "产品类" }'>selected="selected"</c:if>>产品类</option>
		        <option value="服务类" <c:if test='${expert.expertType eq "服务类" }'>selected="selected"</c:if>>服务类</option>
		      </select>
		    </div>
		  </div>
		  <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">专家简介</label>
		    <div class="layui-input-block">
		      	<div id="editor">${expert.expertDesc }</div>
				<input type="hidden" id="content" name="expertDesc">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">登录密码</label>
		    <div class="layui-input-block">
		      <input type="password" name="pwd" value="${expert.pwd }" required  lay-verify="required" autocomplete="off" class="layui-input">
		      <input type="hidden" name="expertId" value="${expert.expertId }">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn" lay-submit lay-filter="formDemo"><i class="fa fa-check" aria-hidden="true"></i>&nbsp;提交</button>
		      <button type="reset" class="layui-btn layui-btn-primary"><i class="fa fa-undo" aria-hidden="true"></i>&nbsp;重置</button>
		    </div>
		  </div>
		</form>
  	</div>
  	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
//JavaScript代码区域
var E = window.wangEditor
var editor = new E('#editor'); // 两个参数也可以传入 elem 对象，class 选择器
//开启debug模式
editor.customConfig.debug = true;
// 关闭粘贴内容中的样式
editor.customConfig.pasteFilterStyle = false
// 忽略粘贴内容中的图片
editor.customConfig.pasteIgnoreImg = true
// 使用 base64 保存图片
//editor.customConfig.uploadImgShowBase64 = true

// 上传图片到服务器
editor.customConfig.uploadFileName = 'myFile'; //设置文件上传的参数名称
editor.customConfig.uploadImgServer = '/ssm/upload'; //设置上传文件的服务器路径
editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024; // 将图片大小限制为 3M
editor.customConfig.menus =[
    'head',  // 标题
    'bold',  // 粗体
    'fontSize',  // 字号
    'fontName',  // 字体
    'italic',  // 斜体
    'underline',  // 下划线
    'strikeThrough',  // 删除线
    'foreColor',  // 文字颜色
    'backColor',  // 背景颜色
    'link',  // 插入链接
    'image',  // 插入图片
    'list',  // 列表
    'justify',  // 对齐方式
    'table',  // 表格
    'undo',  // 撤销
    'redo'  // 重复
];
//自定义上传图片事件
editor.customConfig.uploadImgHooks = {
	before : function(xhr, editor, files) {
		
	},
	success : function(xhr, editor, result) {
		console.log("上传成功");
	},
	fail : function(xhr, editor, result) {
		console.log("上传失败,原因是"+result);
	},
	error : function(xhr, editor) {
		console.log("上传出错");
	},
	timeout : function(xhr, editor) {
		console.log("上传超时");
	}
}

editor.create()

function getEditor(){
	var content = editor.txt.html();
	$("#content").val(content);
	return true;
}

</script>
</body>
</html>