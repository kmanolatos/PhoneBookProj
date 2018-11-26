<%@ Page Title="Log In" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" validateRequest="false" enableEventValidation="false"%>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <style>
        .outer {
            width: 100%;
        }

        .inner {
            position: relative;
            width: 80%;
            top: 30%;
            left: 24%;
        }

        #bg {
            position: fixed;
            top: 0;
            left: 0;
            /* Preserve aspet ratio */
            min-width: 100%;
            min-height: 100%;
        }
    </style>
    <img src="../images/bg.jpg" id="bg" alt="">
    <div class="outer">
        <div class="inner">
            <h2>Log In</h2>
            <h4>Use an account to log in.</h4>
            <br />
            <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                <p class="text-danger">
                    <asp:Literal runat="server" ID="FailureText" />
                </p>
            </asp:PlaceHolder>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">User name</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="UserName"
                        CssClass="text-danger" ErrorMessage="The user name field is required." />
                </div>
            </div>
            <div class="form-group">
                <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                <div class="col-md-10">
                    <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                </div>
            </div>

            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button runat="server" Text="Log In" ID="loginbtn" CssClass="btn btn-default" />
                </div>
            </div>

            <p>
                <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register</asp:HyperLink>
                if you don't have an account.
            </p>
        </div>
    </div>
    <%string ApiURL = System.Configuration.ConfigurationManager.AppSettings["APIURL"];%>
    <script>
        var ApiURL = "<%=ApiURL%>";
        document.getElementsByClassName("outer")[0].style.height = screen.height * 80 / 100 + "px";
        document.getElementsByClassName("inner")[0].style.height = screen.height * 25 / 100 + "px";
        function LoginUser() {
            var user = document.getElementById('<%= UserName.ClientID %>').value.trim();
            var pass = document.getElementById('<%= Password.ClientID %>').value.trim();
            var model = new Object();
            if (user.length == 0 || pass.length == 0)
                return;
            model.username = user;
            model.password = pass;
            $.ajax({
                url: ApiURL + '/api/user/login',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model
            }).done(function (result) {
                    result = result.split(",");
                    localStorage.setItem('username', result[0]);
                    localStorage.setItem('userId', result[1]);
                    window.location.href = '../Home.aspx';
                }).fail(function (xhr, textStatus, errorThrown) {
                    var jsonValue = jQuery.parseJSON(xhr.responseText);
                    alert(jsonValue.Message);
            });
        }
    </script>
</asp:Content>

