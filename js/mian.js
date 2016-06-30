function getInfo1(datefrom,dateto,devid) {
    var arr_devid = new Array();
    var arr_actiontime = new Array();
    var arr_actionnum = new Array();
    var arr_inum = new Array();
    var arr_tem = new Array();
    var arr_hum = new Array();
    var arr_cc = ['#9ACD32', '#f7a35c', '#8085e9','#f15c80', '#e4d354'];
    $.ajax({
        type: "post",
        url: "datapost.aspx",
        dataType: "json",
        data: "dateFrom="+ datefrom+"&dateTo="+dateto+"&devId="+devid,
        beforeSend: LoadFunction, //加载执行方法    
        //error: erryFunction,  //错误执行方法    
        success: function (tt) {
            if (tt == null) {
                alert("该时段没有数据！");
                return;
            } else {
                var json = eval(tt); //数组     
                var tt = "";
                $.each(json, function (index) {
                    //循环获取数据    
                    arr_devid[index] = json[index].dev_id;
                    arr_actiontime[index] = json[index].action_time;
                    arr_actionnum[index] = json[index].action_num;
                    arr_inum[index] = json[index].i_num;
                    arr_tem[index] = json[index].tem;
                    arr_hum[index] = json[index].hum;
                    $(".ac-table tbody").append("<tr><td>" + arr_devid[index] + "</td><td>" + arr_actiontime[index] + "</td><td>" + arr_actionnum[index] + "次</td><td>" + arr_inum[index] + "uA</td><td>" + arr_tem[index] + "℃</td><td>" + arr_hum[index] + "%</td></tr>");
                });
                //转换数组类型为整形
                arr_actionnum = arr_actionnum.map(function (data) {
                    return +data;
                });
                arr_inum = arr_inum.map(function (data) {
                    return +data;
                });
                arr_tem = arr_tem.map(function (data) {
                    return +data;
                });
                arr_hum = arr_hum.map(function (data) {
                    return +data;
                });

                $(function () {
                    $('#line-chart').highcharts({                   //图表展示容器，与div的id保持一致
                        chart: {
                            type: 'spline',                       //指定图表的类型，默认是折线图（line）
                            zoomType: 'x',
                            pinchType: 'x',
                            panning: true,
                            panKey: 'shift',
                        },

                        credits: {
                            enabled: false     //去掉highcharts网站url  

                        },
                        title: {
                            text: ''      //指定图表标题
                        },
                        colors: arr_cc,
                        xAxis: {
                            title: { text: '时间' },
                            categories: arr_actiontime,
                            tickmarkPlacement: 'on'
                        //},{
                        //    title: { text: '设备编号' },
                        //    categories: arr_devid,
                        //    tickmarkPlacement: 'on',
                        //    opposite: true
                        },
                        yAxis: [{ // Primary yAxis
                            title: {
                                text: '动作次数',
                                style: { color: arr_cc[0] },
                            },
                            labels: {
                                style: { color: arr_cc[0] },
                                format: '{value}次'
                            },
                        }, { // Secondary yAxis
                            title: {
                                style: { color: arr_cc[1] },
                                text: '电流',
                            },
                            labels: {
                                style: { color: arr_cc[1] },
                                format: '{value}uA'
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
                            data: arr_actionnum                       //数据
                        }, {
                            name: '电流',
                            yAxis: 1,
                            tooltip: {
                                valueSuffix: 'uA'
                            },
                            data: arr_inum
                        }, {
                            name: '温度',
                            yAxis: 2,
                            tooltip: {
                                valueSuffix: '℃'
                            },
                            data: arr_tem
                        }, {
                            name: '湿度',
                            yAxis: 3,
                            tooltip: {
                                valueSuffix: '%'
                            },
                            data: arr_hum
                        }]
                    });
                });
                //console.log(arr_actiontime);
                //console.log(arr_tem);
                //console.log(arr_hum);
            }
        },
    })
    function LoadFunction() {
        $("#line-chart").html("&nbsp;&nbsp;&nbsp;&nbsp;加载中...");
        $(".ac-table tbody").html("");
    }
    function erryFunction() {
        alert("error");
    };
}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
var d = GetQueryString("d");
if (d != null)
    getInfo1("", "", d);
else
    getInfo1("", "", "");

$(document).ready(function(){
    $(".main-pick button").click(function () {
        var datefrom = $("#inputdatefrom").attr("value");
        console.log(datefrom);
        var dateto = $("#inputdateto").attr("value");
        if (datefrom == "" || dateto == "") {
            alert("选择时间不能为空！");
            return false;
        }
        var d1 = new Date(datefrom.replace(/\-/g, "\/"));
        var d2 = new Date(dateto.replace(/\-/g, "\/"));
        if (d1 > d2){
            alert("起始时间不能大于截止时间！");
            return false;
        }
        var devid = $(".main-pick select").val();
        if (devid=="") {
            alert("请选择设备！");
            return false;
        }
        getInfo1(datefrom, dateto, devid);
        return false;
    });
    $(".aside-fix .pick-show").click(function () {
        $(".aside-fix").toggleClass("aside-active");
        //if($(".aside-pick").hasClass("aside-active"))
        //    $(".aside-pick .main-pick").
    });
    $(".line-info").hover(function () {      
        $(".info-box").fadeIn();
    },function () {
        $(".info-box").fadeOut();
    })
})
