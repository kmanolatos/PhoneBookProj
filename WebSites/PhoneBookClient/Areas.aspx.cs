using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Areas : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        SearchBy.Attributes.Add("onchange", "getList();");
        ins.Attributes.Add("onclick", "onInsert();");
        del.Attributes.Add("onclick", "onDelete();");
        upd.Attributes.Add("onclick", "onUpdate();");
    }
}