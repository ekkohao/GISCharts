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
        var arr_actiontime = new Array();
        var arr_tem = new Array();
        var arr_hum = new Array();
        var arr_cc = ['#9ACD32', '#f7a35c', '#8085e9',
            '#f15c80', '#e4d354'];
        function getInfo1() {
            $.ajax({
                type: "post",
                url: "datapost.aspx",
                dataType: "json",
                beforeSend: LoadFunction, //加载执行方法    
                error: erryFunction,  //错误执行方法    
                success: function (tt) {
                    if (tt == null) {
                        alert("该时段没有数据！");
                        return;
                    } else {
                        var json = eval(tt); //数组     
                        var tt = "";
                        var i = 0;
                        var j = 0;
                        $.each(json, function (index) {
                            //循环获取数据    
                            var Utime = json[index].action_time;
                            var Utem = json[index].tem;
                            var Uhum = json[index].hum;

                            i++;
                            //arr_time.push(info[i].time);

                            arr_actiontime[index] = Utime;
                            arr_tem[index] = Utem;
                            arr_hum[index] = Uhum;

                            //tt += time + "___" + Uza + "___" + Uzb + "___" + Uzc;
                            //tt += "<br/>";
                        });
                        var arr_Inttem = arr_tem.map(function (data) {
                            return +data;
                        });
                        var arr_Inthum = arr_hum.map(function (data) {
                            return +data;
                        });
                        $(function () {
                            $('#line-chart').highcharts({                   //图表展示容器，与div的id保持一致
                                chart: {
                                    type: 'spline'                         //指定图表的类型，默认是折线图（line）
                                },
                                credits: {
                                    enabled: false     //去掉highcharts网站url  

                                },
                                title: {
                                    text: ''      //指定图表标题
                                },
                                colors:arr_cc,
                                xAxis: {
                                    title: { text: '时间' },
                                    categories: arr_actiontime,
                                    tickmarkPlacement: 'on'
                                },
                                yAxis: [{ // Primary yAxis
                                    title: {
                                        text: '动作',
                                        style: { color: arr_cc[0] },
                                    },
                                    labels: {
                                        style:{color: arr_cc[0]},
                                        format: '{value}次'
                                    },
                                }, { // Secondary yAxis
                                    title: {
                                        style: { color: arr_cc[1] },
                                        text: '电流',
                                    },
                                    labels: {
                                        style: { color: arr_cc[1] },
                                        format: '{value}mA'
                                    },
                                }, { // Secondary yAxis
                                    title: {
                                        text: '温度',
                                        style: { color: arr_cc[2] },
                                    },
                                    labels: {
                                        style: { color: arr_cc[2] },
                                        format: '{value}℃'
                                    },
                                    opposite: true,
                                }, { // Secondary yAxis
                                    title: {
                                        text: '湿度',
                                        style: { color: arr_cc[3] },
                                    },
                                    labels: {
                                        style: { color: arr_cc[3] },
                                        format: '{value}%'
                                    },
                                    opposite: true,
                                }],
                                series: [{                                 //指定数据列
                                    name: '动作次数',                          //数据列名
                                    yAxis: 0,
                                    tooltip: {
                                        valueSuffix: '次'
                                    },
                                    data: [10,25,1]                       //数据
                                }, {
                                    name: '电流',
                                    yAxis: 1,
                                    tooltip: {
                                        valueSuffix: 'mA'
                                    },
                                    data: [15, 7, 3]
                                }, {
                                    name: '温度',
                                    yAxis: 2,
                                    tooltip: {
                                        valueSuffix: '℃'
                                    },
                                    data: arr_Inttem
                                }, {
                                    name: '湿度',
                                    yAxis: 3,
                                    tooltip: {
                                        valueSuffix: '%'
                                    },
                                    data: arr_Inthum
                                }]
                            });
                        });
                        console.log(arr_actiontime);
                        console.log(arr_tem);
                        console.log(arr_hum);
                     }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(errorThrown);
                }
            })
                function LoadFunction() {
                    $("#line-chart").html('加载中...');
                }
                function erryFunction() {
                    alert("error");
                };
        }
        getInfo1();
    </script>
</body>
</html>
