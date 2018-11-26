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
                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" Display="Dynamic" ControlToValidate="Firstname"  ErrorMessage="Please enter First Name">   
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" ControlToValidate="Firstname" ValidationExpression="^[\s\S]{3,70}$" runat="server"
                            ErrorMessage="First Name must be between 3 and 70 characters long."></asp:RegularExpressionValidator>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Lastname" CssClass="col-md-2 control-label">Last Name</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Lastname" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" Display="Dynamic" ControlToValidate="Lastname" 
                            ErrorMessage="Please enter Last Name">   
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" ControlToValidate="Lastname" ValidationExpression="^[\s\S]{3,70}$" runat="server"
                            ErrorMessage="Last Name must be between 3 and 70 characters long."></asp:RegularExpressionValidator>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" Display="Dynamic" ControlToValidate="Password"
                            ErrorMessage="Please enter Password">   
                        </asp:RequiredFieldValidator>
                                                                                                    <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" ControlToValidate="Password" ValidationExpression="^[\s\S]{5,70}$" runat="server" 
                            ErrorMessage="Password must be between 5 and 70 characters long."></asp:RegularExpressionValidator>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control"/>
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
                        <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ControlToValidate="Email" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="PhoneNumber" CssClass="col-md-2 control-label">Phone Number</asp:Label>
                    <div class="col-md-10">
                        <asp:TextBox runat="server" ID="PhoneNumber" CssClass="form-control"/>
                        <asp:RequiredFieldValidator runat="server" CssClass="text-danger" Display="Dynamic" ControlToValidate="PhoneNumber"
                            ErrorMessage="Please enter Phone Number">   
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" ControlToValidate="PhoneNumber" ValidationExpression="^[\s\S]{10,15}$" runat="server"
                            ErrorMessage="Phone Number must be between 10 and 15 characters long."></asp:RegularExpressionValidator>
                        <asp:RegularExpressionValidator Display="Dynamic" CssClass="text-danger" runat="server" ErrorMessage="Enter valid Phone number" ControlToValidate="PhoneNumber" ValidationExpression="^[01]?[- .]?(\([2-9]\d{2}\)|[2-9]\d{2})[- .]?\d{3}[- .]?\d{4}$" ></asp:RegularExpressionValidator> 

                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="kindsList" CssClass="col-md-2 control-label">Telephone Kind</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="kindsList" runat="server">
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator
                            Display="Dynamic" CssClass="text-danger"
                            runat="server" ControlToValidate="kindsList"
                            ErrorMessage="Please select a Telephone Kind"
                            InitialValue="-1" />
                    </div>
                </div>
                <br />
                <div class="form-group">
                    <asp:Label runat="server" AssociatedControlID="citiesList" CssClass="col-md-2 control-label">City</asp:Label>
                    <div class="col-md-10">
                        <asp:DropDownList ID="citiesList" runat="server">
                        </asp:DropDownList>
                        <br />
                        <asp:RequiredFieldValidator
                            Display="Dynamic" CssClass="text-danger"
               runat="server" ControlToValidate ="citiesList"
               ErrorMessage="Please choose a City" 
               InitialValue="-1">
            </asp:RequiredFieldValidator>
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
                        <asp:Button runat="server" Text="Update" CssClass="btn btn-default btn-center" OnClientClick="OnUpdate()" ID="updbtn"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%string ApiURL = System.Configuration.ConfigurationManager.AppSettings["APIURL"];%>
    <script>
        document.getElementById('<%=updbtn.ClientID%>').style.height = screen.height * 4 / 100 + "px";
        var Area_ID;
        var ApiURL = "<%=ApiURL%>";
        var Owner_ID, Entry_ID, ID;
        getCities();
        getKinds();
        getProfileById();
        function getProfileById() {
            $.ajax({
                url: ApiURL + '/api/user/get/id/' + localStorage.userId,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    var list, options;
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
                    if (result.Kind_ID != null){
                        list = document.getElementById('<%= kindsList.ClientID %>');
                        list.removeChild(list.childNodes[1]);
                        options = list.options;
                        for (var i = 0; i < options.length; i++) {
                            if (options[i]) {
                                if (options[i].value == result.Kind_ID) {
                                    list.options[i].selected = true;
                                    break;
                                }
                            }
                        }
                    }
                    if (result.City_ID != null) {
                        list = document.getElementById('<%= citiesList.ClientID %>');
                        list.removeChild(list.childNodes[1]);
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
                    }
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function getCities() {
            $.ajax({
                url: ApiURL + '/api/city/getList',
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    var option = document.createElement("option");
                    option.text = "Select";
                    option.value = "-1";
                    var ddl = document.getElementById('<%= citiesList.ClientID %>');
                    ddl.appendChild(option);
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
                url: ApiURL + '/api/telephoneKind/getList',
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    var option = document.createElement("option");
                    option.text = "Select";
                    option.value = "-1";
                    var ddl = document.getElementById('<%= kindsList.ClientID %>');
                    ddl.appendChild(option);
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
                url: ApiURL + '/api/area/getAreasByCity/id/' + cityId,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    setAreaComboOptions(result);
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

        function getAreasOnCityChange() {
            var list = document.getElementById('<%= citiesList.ClientID %>');
            var value = list.options[list.selectedIndex].value;
            var cityId = value;
            if (cityId == -1) {
                document.getElementById('<%= areasList.ClientID %>').innerHTML = "";
                return;
            }
            $.ajax({
                url: ApiURL + '/api/area/getAreasByCity/id/' + cityId,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    setAreaComboOptions(result)
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function setAreaComboOptions(result) {
            document.getElementById('<%= areasList.ClientID %>').innerHTML = "";
            result.forEach(function (item) {
                var option = document.createElement("option");
                option.text = item.Area_Descr;
                option.value = item.Id;
                var ddl = document.getElementById('<%= areasList.ClientID %>');
                ddl.appendChild(option);
            });
        }

        function OnUpdate() {
            var isValid = Page_ClientValidate();
            if (!isValid)
                return;
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
                url: ApiURL + "/api/user/update",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model
            }).done(function (result) {
                    alert("Updated Successfully!");
                    window.location.href = 'Home.aspx';
                }).fail(function (xhr, textStatus, errorThrown) {
                    var jsonValue = jQuery.parseJSON(xhr.responseText);
                    alert(jsonValue.Message);
                });         
        }
    </script>
</asp:Content>



