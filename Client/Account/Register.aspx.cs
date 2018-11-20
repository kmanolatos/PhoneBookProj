using Microsoft.AspNet.Identity;
using System;
using System.Linq;
using System.Web.UI;
using PhoneBookClient;

public partial class Account_Register : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        citiesList.Attributes.Add("onchange", "getAreas();");
        regbtn.Attributes.Add("onclick", "Register();");
    }
}