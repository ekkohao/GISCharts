using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Data;
using System.Data.Common;
/// <summary>
/// SQLCon 的摘要说明
/// </summary>
public class SQLCon
{
    public string DbConnectionString = System.Web.Configuration.WebConfigurationManager.AppSettings["DbConnectionString"];
	public SQLCon()
	{
		//
		// TODO: 在此处添加构造函数逻辑
		//
	}
    public DataTable ReturnTable(string sql)
    {

        DBInit db = new DBInit(DbConnectionString);
        DbCommand cmd = db.GetSqlStringCommand(sql);
        DataTable dt = db.ExecuteDataTable(cmd);
        return dt;
    }
}