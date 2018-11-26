using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Telephone_Kinds : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ins.Attributes.Add("onclick", "onInsert();");
        del.Attributes.Add("onclick", "onDelete();");
        upd.Attributes.Add("onclick", "onUpdate();");
    }
}