using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class datapost : System.Web.UI.Page
{
    private static SQLCon sql = new SQLCon();
    protected void Page_Load(object sender, EventArgs e)
    {
        string dateFrom = Request.Form["dateFrom"];
        string dateTo = Request.Form["dateTo"];
        string devId=Request.Form["devId"];
        string strsql=null;
        if (dateFrom == null||dateFrom=="")
        {
            dateFrom = DateTime.Now.AddMonths(-1).ToString();
            dateTo = DateTime.Now.ToString();
        }
        else {
            convertDate(dateFrom);
            convertDate(dateTo);
        }
        if (devId == null||devId=="")
            strsql = "select dev_id,action_time,action_num,i_num,tem,hum from ActionMsg where action_time between #" + dateFrom + "# AND #" + dateTo + "# ORDER BY action_time ASC";
        else
            strsql = "select dev_id,action_time,action_num,i_num,tem,hum from ActionMsg where action_time between #" + dateFrom + "# AND #" + dateTo + "# AND dev_id = '"+devId+"' ORDER BY action_time ASC";
        DataTable dt = sql.ReturnTable(strsql);

        string json = CreateJsonParameters(dt);
        Response.ContentType = "application/json";
        Response.Write(json);    
        Response.Flush();
        dt.Dispose();
        Response.End();

    }

    private void convertDate(string d) {
        d.Replace('-','/');
        if (d.Length >= "0000/00/00 00:00:00".Length)
            return;
        d = d.Substring(0,"0000/00/00".Length);
        d += "00:00:00";
    }

    public string CreateJsonParameters(DataTable dt)
    {
        StringBuilder JsonString = new StringBuilder();
        if (null != dt && 0 < dt.Rows.Count)
        {
            string[] ColumnName = new String[dt.Columns.Count];
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                ColumnName[j] = "\"" + dt.Columns[j].ColumnName.ToString().Replace("\"", "\\\"") + "\":\"";
            }
            JsonString.Append("[");
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                JsonString.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    JsonString.Append(ColumnName[j]);
                    JsonString.Append(dt.Rows[i][j].ToString().Replace("\"", "\\\""));
                    JsonString.Append("\",");
                }
                JsonString.Remove(JsonString.Length - 1, 1);
                JsonString.Append("},");
            }
            JsonString.Remove(JsonString.Length - 1, 1);
            JsonString.Append("]");
            return JsonString.ToString();
        }
        else
        {
            return null;
        }
    }
}