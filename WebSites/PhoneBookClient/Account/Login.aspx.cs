using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using PhoneBookClient;

public partial class Account_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loginbtn.Attributes.Add("onclick", "LoginUser();");
        RegisterHyperLink.NavigateUrl = "Register";
    }
}