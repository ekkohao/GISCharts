<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html lang="zh-CN">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.js"></script>   
    <script type="text/javascript" src="js/highcharts.js"></script>
    <title>图表数据分析</title>
</head>
<body>
    <%-- 页头 --%>
    <header id="header">
        <div class="container">
            <h1 class="center-block">GIS监测数据分析</h1>
        </div>
    </header>
    <%-- 正文 --%>
    <div id="bodier" class="">
        <div class="container ">
            <div class="widget">
                <h3>曲线分析</h3>
                <div id="line-chart" class="chart"></div>
            </div>  
        </div>
    </div>
    <%-- 页尾 --%>
    <footer id="footer">
        <div class="container">

        </div>
    </footer>
    <script>
        $(function () {
            $('#line-chart').highcharts({                   //图表展示容器，与div的id保持一致
                chart: {
                    //type: 'line'                         //指定图表的类型，默认是折线图（line）
                },
                title: {
                    text: ''      //指定图表标题
                },
                xAxis: {
                    title: { text: '时间' },
                    categories: ['20160102', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    tickmarkPlacement:'on'
                },
                yAxis: [{ // Primary yAxis
                    title: {
                        text: '电压（KV）',
                    },         

                }, { // Secondary yAxis
                    title: {
                        text: '温度（℃）',
                    },
                    opposite: true,
                }, { // Secondary yAxis
                    title: {
                        text: '湿度（%）',
                    },
                    opposite: true,
                }],
                series: [{                                 //指定数据列
                    name: 'A相',                          //数据列名
                    yAxis:0,
                    data: [1, 20, 4]                        //数据
                }, {
                    name: 'B相',
                    yAxis: 0,
                    data: [15, 7, 3]
                },{
                    name: 'C相',
                    yAxis: 0,
                    data: [5, 7, 13]
                },{
                    name: '温度',
                    yAxis: 1,
                    data: [24, 28, 200]
                },{
                    name: '湿度',
                    yAxis: 2,
                    data: [5, 17, 3]
                }]
            });
        });
    </script>
</body>
</html>
