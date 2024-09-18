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
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/ent_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
	    <!-- 内容主体区域 -->
	    <div class="bread-nav">
	    	<span class="layui-breadcrumb">
			  <a href="/ssm/ent/home">首页</a>
			  <a href="/ssm/ent/tendermgr">征集管理</a>
			  <a href="#">发布征集项目</a>
			</span>
	    </div>
	    <form class="layui-form" action="savetender" method="post" onsubmit="return getEditor();" enctype="multipart/form-data">
		  <div class="layui-form-item">
		    <label class="layui-form-label">项目编号</label>
		    <div class="layui-input-block">
		      <input type="text" name="tenderNo" class="layui-input" disabled="disabled" placeholder="不需输入，系统自动生成">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">项目名称</label>
		    <div class="layui-input-block">
		      <input type="text" name="projectName" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">负责人姓名</label>
		    <div class="layui-input-block">
		      <input type="text" name="incharge" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">联系人手机号码</label>
		    <div class="layui-input-block">
		      <input type="number" name="mobile" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">联系人邮箱</label>
		    <div class="layui-input-block">
		      <input type="text" name="email" required  lay-verify="required" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">项目类型</label>
		    <div class="layui-input-block" style="width: 350px;">
		      <select name="projectType" lay-verify="required">
		        <option value="工程类">工程类</option>
		        <option value="产品类">产品类</option>
		        <option value="服务类">服务类</option>
		      </select>
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">预算</label>
		    <div class="layui-input-block">
		      <input type="text" name="budget" required  lay-verify="required" placeholder="请输入金额" autocomplete="off" class="layui-input">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">征集截止时间</label>
		    <div class="layui-input-block">
		    	<input type="text" name="endTime" class="layui-input" id="endtime" required  lay-verify="required">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">关键字</label>
		    <div class="layui-input-block">
		      	<input type="text" name="keyWords" autocomplete="off" class="layui-input">
			    <div class="layui-form-mid layui-word-aux">如果有多个关键字，请以空格分隔开来</div>
		    </div>
		  </div>
		  <div class="layui-form-item layui-form-text">
		    <label class="layui-form-label">项目介绍</label>
		    <div class="layui-input-block">
		      	<div id="editor"></div>
				<input type="hidden" id="content" name="projectDesc">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <label class="layui-form-label">相关文件</label>
		    <div class="layui-input-block">
		      	<input type="file" name="file" autocomplete="off" class="layui-input">
			    <div class="layui-form-mid layui-word-aux">如果有多个文件，请以压缩包的形式上传</div>
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn" lay-submit lay-filter="formDemo"><i class="fa fa-send" aria-hidden="true"></i>&nbsp;发布</button>
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

	layui.use('laydate', function(){
	  var laydate = layui.laydate;
	  //执行一个laydate实例
	  laydate.render({
	    elem: '#endtime' //指定元素
	   	,type: 'datetime'
	    ,format: 'yyyy-MM-dd HH:mm' //可任意组合
	  });
	});
</script>
</body>
</html>