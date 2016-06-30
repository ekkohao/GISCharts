<%@ Page Language="C#" AutoEventWireup="true" CodeFile="default.aspx.cs" Inherits="index" %>

<!DOCTYPE html>

<html lang="zh-CN">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/bootstrap.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link href="css/datetimepick.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery.js"></script>   
    <script type="text/javascript" src="js/highcharts.js" ></script>
    <script type="text/javascript" src="js/mian.js"></script>
    <script type="text/javascript" src="js/datetimepick.js"></script>
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
                <h3><i class="icon-signer"></i>
                    曲线分析
                    <span class="pull-right line-info"><i class="icon-info-sign"></i></span>
                    <span class="info-box">
                        提示：<br />
                        1.按住&lt;shift&gt;点击可以平移<br />
                        2.单击下方的图例可以显示或取消相应曲线<br />
                    </span>
                </h3>
                <div id="line-chart" class="chart"></div>
            </div>  
            <div class="widget">
                <h3><i class="icon-list-of"></i>数据表格</h3>
                <table class="table table-striped table-hover ac-table">
                    <thead>
                        <tr>
                          <th>设备编号</th>
                          <th>动作时间</th>
                          <th>动作次数</th>
                          <th>电流（uA）</th>
                          <th>温度（℃）</th>
                          <th>湿度（%）</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <%-- 页尾 --%>
    <footer id="footer">
        <div class="container">
            <div class="row footer-bottom">
                <div class="text-center" style="margin-bottom:10px">&copy; 2016 合肥科鼎电气有限公司</div>
                <ul class="list-inline text-center">
                    <li>官网：<a href="http://www.hfkeding.cn/" target="_blank">http://www.hfkeding.cn/</a></li>
                    <li>电话：0551-65336059</li>
                    <li>邮箱：<a href="mailto:hfkeding@sina.com">hfkeding@sina.com</a></li>
                </ul>
          
            </div>
        </div>
    </footer>
    <aside class="aside-fix">
        <div class="pick-show"><i class="icon-play"></i></div>
        <form class="f-main-pick">
            <div class="main-pick">
            <div class="form-group">
                <label>起始日期：</label>
                <input id='inputdatefrom' class='input form-control' readOnly="true"  />
            </div>
            <div class="form-group">
                <label>截至日期：</label>
                <input id='inputdateto' class='input form-control' readOnly="true"  />
            </div>
            <div class="form-group">
                <label>设备选择：</label>
                <select class="form-control">
                    <% for (int i = 0; i < dt.Rows.Count; i++)
                       {
                           string s=dt.Rows[i]["dev_id"].ToString();
                           Response.Write("<option value='"+s+"'>"+s+"</option>");
                       }    
                     %>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">查询</button>
            </div>
        </form>
    </aside>
    <script type="text/javascript">
        rome(inputdatefrom);
        rome(inputdateto);
    </script>
</body>
</html>
