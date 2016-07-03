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
        string devName=Request.Form["devId"];
        string strsql=null;

        convertDate(dateFrom);
        convertDate(dateTo);

        DataTable dt=null;
        DataTable dt2 = sql.ReturnTable("SELECT Dev_List.id,Dev_List.dev_name,Dev_List.dev_phase,Group_List.group_name FROM Dev_List,Group_List WHERE Dev_List.group_id=Group_List.id AND Dev_List.dev_name='" + devName + "'");
        string dev_id="";
        if (null != dt2 && 0 < dt2.Rows.Count) { 
            dev_id=dt2.Rows[0][0].ToString();
            strsql = "select action_time,action_num,i_num,tem,hum from ActionMsg where action_time between #" + dateFrom + "# AND #" + dateTo + "# AND dev_id = " + dev_id + " ORDER BY ActionMsg.action_time ASC";
            dt = sql.ReturnTable(strsql);
        }
      
        
        string json1 = CreateJsonParameters(dt);
        string json2 = CreateJsonParameters2(dt2);
        string json = "{\"data\":" + json1 + ",\"devinfo\":" + json2 + "}";
        Response.ContentType = "application/json";
        Response.Write(json);    
        Response.Flush();
        if(dt!=null)
            dt.Dispose();
        Response.End();

    }

    private void convertDate(string d) {
        if (d != null)
        {
            d.Replace('-', '/');
            if (d.Length == 15)
                d += ":00";
        }
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
            return "null";
        }
    }
    public string CreateJsonParameters2(DataTable dt)
    {
        StringBuilder JsonString = new StringBuilder();
        if (null != dt && 0 < dt.Rows.Count)
        {
            JsonString.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                string ColumnName= "\"" + dt.Columns[j].ColumnName.ToString().Replace("\"", "\\\"") + "\":\"";
                JsonString.Append(ColumnName);
                JsonString.Append(dt.Rows[0][j].ToString().Replace("\"", "\\\""));
                JsonString.Append("\",");
            }
            JsonString.Remove(JsonString.Length - 1, 1);
            JsonString.Append("}");
            return JsonString.ToString();
        }
        else
        {
            return "null";
        }
    }
}