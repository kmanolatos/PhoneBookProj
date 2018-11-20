<%@ Page Title="Register" Language="C#" MasterPageFile="~/Empty.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register"  validateRequest="false" enableEventValidation="false"%>

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

        .btn-center {
            width: 20%;
            position: relative;
            left: 8%;
        }
    </style>
    <img src="../images/bg.jpg" id="bg" alt="">
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <div class="outer">
            <div class="inner">
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="UserName" CssClass="col-md-2 control-label">User Name</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="UserName" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                        <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                            CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Firstname" CssClass="col-md-2 control-label">First Name</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Firstname" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Lastname" CssClass="col-md-2 control-label">Last Name</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Lastname" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Email" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="PhoneNumber" CssClass="col-md-2 control-label">Phone Number</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="PhoneNumber" CssClass="form-control" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="kindsList" CssClass="col-md-2 control-label">Telephone Kind</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="kindsList" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="citiesList" CssClass="col-md-2 control-label">City</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="citiesList" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="areasList" CssClass="col-md-2 control-label">Area</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="areasList" runat="server">
                        </asp:DropDownList>
                    </div>
                </div>
                <br />
                <br />
                <div class="form-group">
                    <div class="col-md-offset-2 col-md-10">
                        <asp:Button runat="server" Text="Register" CssClass="btn btn-default btn-center" ID="regbtn" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%string hostname = System.Configuration.ConfigurationManager.AppSettings["hostName"];%>
    <script>
        document.getElementById('<%=regbtn.ClientID%>').style.height = screen.height * 4 / 100 + "px";
        var hostname = "<%=hostname%>";
        getCities();
        getKinds();
        function getCities() {
            $.ajax({
                url: hostname + '/api/city/getList',
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    result.forEach(function (item) {
                        var option = document.createElement("option");
                        option.text = item.City_Descr;
                        option.value = item.City_ID;
                        var ddl = document.getElementById('<%= citiesList.ClientID %>');
                        ddl.appendChild(option);
                    });
                    var list = document.getElementById('<%= citiesList.ClientID %>');
                    list.options[0].selected = true;
                    getAreas();
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function getKinds() {
            $.ajax({
                url: hostname + '/api/telephoneKind/getList',
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    result.forEach(function (item) {
                        var option = document.createElement("option");
                        option.text = item.Kind_Descr;
                        option.value = item.Kind_ID;
                        var ddl = document.getElementById('<%= kindsList.ClientID %>');
                        ddl.appendChild(option);
                    });
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function getAreas() {
            var list = document.getElementById('<%= citiesList.ClientID %>');
            var value = list.options[list.selectedIndex].value;
            var cityId = value;
            $.ajax({
                url: hostname + '/api/area/getAreasByCity/id/' + cityId,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    document.getElementById('<%= areasList.ClientID %>').innerHTML = "";
                    result.forEach(function (item) {
                        var option = document.createElement("option");
                        option.text = item.Area_Descr;
                        option.value = item.Id;
                        var ddl = document.getElementById('<%= areasList.ClientID %>');
                        ddl.appendChild(option);
                    });
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function Register() {
            if (document.getElementById('<%=Password.ClientID%>').value.trim().length == 0 || document.getElementById('<%=ConfirmPassword.ClientID%>').value.trim().length == 0)
                return;
            if (document.getElementById('<%=Password.ClientID%>').value.trim() != document.getElementById('<%=ConfirmPassword.ClientID%>').value.trim()) {
                alert("Password and Confirm Password must be same");
                return;
            }
            var model = new Object();
            var masterModel = new Object();
            var detailModel = new Object();
            var loginModel = new Object();
            loginModel.username = document.getElementById('<%=UserName.ClientID%>').value.trim();
            loginModel.password = document.getElementById('<%=Password.ClientID%>').value;
            masterModel.Firstname = document.getElementById('<%=Firstname.ClientID%>').value;
            masterModel.Lastname = document.getElementById('<%=Lastname.ClientID%>').value;
            masterModel.Mail = document.getElementById('<%=Email.ClientID%>').value;
            detailModel.Phone_Number = document.getElementById('<%=PhoneNumber.ClientID%>').value;
            var list = document.getElementById('<%= kindsList.ClientID %>');
            var value = list.options[list.selectedIndex].value;
            detailModel.Kind_ID = value;
            list = document.getElementById('<%= areasList.ClientID %>');
            value = list.options[list.selectedIndex].value;
            masterModel.Area_ID = value;
            model.loginModel = loginModel;
            model.telephoneDetailModel = detailModel;
            model.telephoneMasterModel = masterModel;
            $.ajax({
                url: hostname + "/api/user/register",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                    type: 'POST',
                    contentType: 'application/json',
                    data: model,
                    success: function (result) {
                        if (result == 1) {
                            alert("Username already exists!");
                            return;
                        }
                        else if (result == 2) {
                            alert("Email already exists!");
                            return;
                        }
                        window.location.href = 'Login.aspx';
                    },
                    error: function (ex) {
                        alert(ex.statusText)
                    }
                });
        }
    </script>
</asp:Content>

