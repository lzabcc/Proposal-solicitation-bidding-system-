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
  <style type="text/css">
  	.layui-body{
  		background: #f2f2f2;
  	}
  	.clear-fix{clear: both;}
  </style>
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_header.jsp"></jsp:include>
  	<!-- 左侧菜单 -->
  	<jsp:include page="../../include/admin_menu.jsp"></jsp:include>
  
  	<div class="layui-body">
  		<div class="layui-card">
  			<div  class="layui-card-header layui-bg-green" style="font-size: 16px;">数据总览</div>
		  		<div class="layui-card-body">
		  			<div class="layui-row">
					    <div class="layui-col-xs3">
					      	<div class="icon-area layui-bg-blue">
								<div>
									<i class="layui-icon">&#xe857;</i><span class="num">${entCount }</span>
								</div>
								<p>征集方</p>
							</div>
					    </div>
					    <div class="layui-col-xs3">
					      	<div class="icon-area layui-bg-orange">
								<div>
									<i class="layui-icon">&#xe770;</i><span class="num">${supCount }</span>
								</div>
								<p>供应商</p>
							</div>
					    </div>
					    <div class="layui-col-xs3">
				      		<div class="icon-area layui-bg-green">
								<div>
									<i class="layui-icon">&#xe705;</i><span class="num">${tendersCount }</span>
								</div>
								<p>征集数量</p>
					      </div>
					    </div>
					    <div class="layui-col-xs3">
					      	<div class="icon-area layui-bg-red">
								<div>
									<i class="layui-icon">&#xe629;</i><span class="num">${faildCount }%</span>
								</div>
								<p>流标率</p>
							</div>
					    </div>
				  	</div>
			 </div>
  		</div>
	    <div class="layui-card" style="height:350px; width: 49%; float: left;">
		  <div  class="layui-card-header layui-bg-green" style="font-size: 16px;">发标量走势</div>
		  <div class="layui-card-body">
		  	<form action="/ssm/admin/home" method="post">
		  	<div>
				<div class="layui-input-inline">
					<input type="date" name="sdateStr" value='<fmt:formatDate value="${sdate }" pattern="yyyy-MM-dd"/>' class="layui-input" placeholder="开始日期" style="width: 150px;">
				</div>
				<div class="layui-input-inline">至</div>
				<div class="layui-input-inline">
					<input type="date" name="edateStr" value='<fmt:formatDate value="${edate }" pattern="yyyy-MM-dd"/>' class="layui-input" placeholder="结束日期" style="width: 150px;">
				</div>
				<div class="layui-input-inline">
					<button type="submit" class="layui-btn layui-btn-normal">
					  <i class="layui-icon">&#xe615;</i>查询
					</button>
				</div>
		  	</div>
			</form>
		     <div style="width:100%;height:280px;" id="daytender"></div>
		  </div>
		</div>
		<div class="layui-card" style="height:350px; width: 49%; float: right;">
		  <div  class="layui-card-header layui-bg-green" style="font-size: 16px;">征集状态分布</div>
		  <div class="layui-card-body">
		     <div style="width:100%;height:300px;" id="tenderResult"></div>
		  </div>
		</div>
		<div class="clear-fix"></div>
		<div class="layui-card" style="height:350px; width: 49%; float: left;">
		  <div  class="layui-card-header layui-bg-green" style="font-size: 16px;">征集类型分布</div>
		  <div class="layui-card-body">
		     <div style="width:100%;height:300px;" id="tenderType"></div>
		  </div>
		</div>
		<div class="layui-card" style="height:350px; width: 49%; float: right;">
		  <div  class="layui-card-header layui-bg-green" style="font-size: 16px;">征集书数量分布</div>
		  <div class="layui-card-body">
		     <div style="width:100%;height:300px;" id="tenderCount"></div>
		  </div>
		</div>
  	</div>
	<!-- 引入页面公共页 -->
	<jsp:include page="../../include/footer.jsp"></jsp:include>
</div>
<script>
//JavaScript代码区域
	//发标量走势
	var daytender = echarts.init(document.getElementById('daytender'));
	// 指定图表的配置项和数据
	var option = {
	    xAxis: {
	        type: 'category',
	        data: [${dayStr}]
	    },
	    yAxis: {
	        type: 'value'
	    },
	    tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'line'        // 默认为直线，可选为：'line' | 'shadow'
            },
        },
	    series: [{
	        data: [${countStr}],
	        type: 'line'
	    }]
	};
	daytender.setOption(option);

	//征集结果饼状图
var tenderResult = {
    tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    stillShowZeroSum: false,
    series: [
        {
            name: '征集状态分布',
            type: 'pie',
            data: [
                ${rtStr}
            ],
            itemStyle: {
                emphasis: {
                    shadowBlur: 10,
                    shadowOffsetX: 0,
                    shadowColor: 'rgba(128, 128, 128, 0.5)'
                }
            }
        }
    ]
};
var pieChart = echarts.init(document.getElementById('tenderResult'), 'macarons');
pieChart.setOption(tenderResult);

var tenderType = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    stillShowZeroSum: false,
	    series: [
	        {
	            name: '征集类型分布',
	            type: 'pie',
	            data: [
	                ${ptStr}
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(128, 128, 128, 0.5)'
	                }
	            }
	        }
	    ]
	};
	var pieChart2 = echarts.init(document.getElementById('tenderType'), 'macarons');
	pieChart2.setOption(tenderType);

	//征集量排名
    var rank = echarts.init(document.getElementById("tenderCount"));
    // 指定图表的配置项和数据
    var rankOption = {
        tooltip:{
            trigger:'axis'
        },
        // x轴
        xAxis: {
            data: [${sbRankStr}],
            type: 'category',
             // 书写格式
             axisLabel: {
               formatter: val => {
                 let txt = val
                 if (val.length > 3) {
                   txt = val.substr(0, 3) + '...'
                 }
                 return txt
               }
             }
        },
        yAxis: {},
        // 数据
        series: [{
            name: '收到的征集书数量',
            type: 'bar',
            data: [${sbRankValueStr}],
        }
        ]
    };
    rank.setOption(rankOption);
	
</script>
</body>
</html>