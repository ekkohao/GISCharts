using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class index : System.Web.UI.Page
{
    protected static SQLCon sql = new SQLCon();
    protected DataTable dt = sql.ReturnTable("SELECT DISTINCT dev_id from ActionMsg");
    protected void Page_Load(object sender, EventArgs e)
    {
        dt.Dispose();
    }

}