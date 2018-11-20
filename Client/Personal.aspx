<%@ Page Title="Personal Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="Personal"   validateRequest="false" enableEventValidation="false" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <style>
        .outer {
            width: 100%;
        }

        .inner {
            position: relative;
            width: 80%;
            top: 90px;
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
                        <button id="updbtn" onclick="OnUpdate()" class="btn btn-default btn-center" >Update</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%string hostname = System.Configuration.ConfigurationManager.AppSettings["hostName"];%>
    <script>
        document.getElementById('updbtn').style.height = screen.height * 4 / 100 + "px";
        var Area_ID;
        var hostname = "<%=hostname%>";
        var Owner_ID, Entry_ID, ID;
        getCities();
        getKinds();
        getProfileById();
        function getProfileById() {
            $.ajax({
                url: hostname + '/api/user/get/id/' + localStorage.userId,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    Owner_ID = result.Owner_ID;
                    Entry_ID = result.Entry_ID;
                    Area_ID = result.Area_ID;
                    ID = result.ID;
                    document.getElementById('<%=Password.ClientID%>').value = result.password;
                    document.getElementById('<%=ConfirmPassword.ClientID%>').value = result.password;
                    document.getElementById('<%=Firstname.ClientID%>').value = result.Firstname;
                    document.getElementById('<%=Lastname.ClientID%>').value = result.Lastname;
                    document.getElementById('<%=Email.ClientID%>').value = result.Mail;
                    document.getElementById('<%=PhoneNumber.ClientID%>').value = result.Phone_Number;
                    var list = document.getElementById('<%= kindsList.ClientID %>');
                    var options = list.options;
                    for (var i = 0; i < options.length; i++) {
                        if (options[i]) {
                            if (options[i].value == result.Kind_ID) {
                                list.options[i].selected = true;
                                break;
                            }
                        }
                    }
                    list = document.getElementById('<%= citiesList.ClientID %>');
                    options = list.options;
                    for (var i = 0; i < options.length; i++) {
                        if (options[i]) {
                            if (options[i].value == result.City_ID) {
                                list.options[i].selected = true;
                                break;
                            }
                        }
                    }
                    getAreas();
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

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
                    var list = document.getElementById('<%= areasList.ClientID %>');
                    var options = list.options;
                    for (var i = 0; i < options.length; i++) {
                        if (options[i]) {
                            if (options[i].value == Area_ID) {
                                list.options[i].selected = true;
                                break;
                            }
                        }
                    }
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function OnUpdate() {
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
            loginModel.Id = localStorage.userId;
            loginModel.username = localStorage.username;
            loginModel.password = document.getElementById('<%=Password.ClientID%>').value;
            masterModel.Firstname = document.getElementById('<%=Firstname.ClientID%>').value;
            masterModel.Lastname = document.getElementById('<%=Lastname.ClientID%>').value;
            masterModel.Mail = document.getElementById('<%=Email.ClientID%>').value;
            masterModel.UserID = localStorage.userId;
            masterModel.ID = ID;
            detailModel.Phone_Number = document.getElementById('<%=PhoneNumber.ClientID%>').value;
            detailModel.Owner_ID = Owner_ID;
            detailModel.Entry_ID = Entry_ID;
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
                url: hostname + "/api/user/update",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model,
                success: function (result) {
                    if (result == 1) {
                        alert("Email already exists!");
                        return;
                    }
                    window.location.href = 'Home.aspx';
                },
                error: function (ex) {
                    alert(ex.statusText)
                }
            });
        }
    </script>
</asp:Content>



