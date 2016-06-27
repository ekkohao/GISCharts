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
        DataTable dt = sql.ReturnTable("select action_time,tem,hum from ActionMsg where tem <> 0");
        string date1, date2;

        date1 = "2014-7-22";
        date2 = "2014-7-27";

        if (Session["date"] != null && Session["date1"] != null)
        {
            date1 = Session["date"].ToString();
            date2 = Session["date1"].ToString();
            //Session.Remove("date");
            //Session.Remove("date1");

        }

        string json = CreateJsonParameters(dt);
        Response.Write(json);    
        Response.Flush();
        Response.End();

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