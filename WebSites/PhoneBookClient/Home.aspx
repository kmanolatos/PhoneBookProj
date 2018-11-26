<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        tr:nth-child(1) {
            background-color: burlywood;
        }

        tr:nth-child(odd):not(:first-child) {
            background-color: #D0CECE;
        }

        tr:hover:not(:first-child) {
            background-color: #A19F9F;
        }

        td {
            border: 1px solid black;
            padding: 8px;
        }

        tr:nth-child(1) td {
            font-weight: bolder;
        }

        table {
            border: 2px solid black;
            width: 100%;
        }

        input {
            position: relative;
            top: 50px;
            width: 30%;
            left: 30px;
        }

        .SearchBy {
            position: relative;
            top: 50px;
            width: 15%;
        }

        .tableStyle {
            position: relative;
            top: 70px;
            overflow: auto;
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
    <img src="images/bg.jpg" id="bg" alt="">
    <asp:DropDownList ID="SearchBy" CssClass="SearchBy" runat="server">
        <asp:ListItem Text="First Name" Value="1" />
        <asp:ListItem Text="Last Name" Value="2" />
        <asp:ListItem Text="Phone Number" Value="3" />
    </asp:DropDownList>
    <input id="search" type="text" placeholder="Search" onkeyup="getList()">
    <div class="tableStyle">
        <asp:Table ID="MyTable" runat="server"></asp:Table>
    </div>
    <%string ApiURL = System.Configuration.ConfigurationManager.AppSettings["APIURL"];%>

    <script type="text/javascript">
        document.getElementsByClassName('tableStyle')[0].style.maxHeight = screen.height * 70 / 100 + "px";
        document.getElementsByClassName('SearchBy')[0].style.height = screen.height * 3 / 100 + "px";
        document.getElementsByTagName('input')[0].style.height = screen.height * 4 / 100 + "px";
        var table = document.getElementById('<%= MyTable.ClientID %>');
        var row = table.insertRow(0);
        var cell1 = row.insertCell(0);
        var cell2 = row.insertCell(1);
        var cell3 = row.insertCell(2);
        var cell4 = row.insertCell(3);
        var cell5 = row.insertCell(4);
        var cell6 = row.insertCell(5);
        var cell7 = row.insertCell(6);
        cell1.innerHTML = "First Name";
        cell2.innerHTML = "Last Name";
        cell3.innerHTML = "Email";
        cell4.innerHTML = "Phone Number";
        cell5.innerHTML = "Telephone Kind";
        cell6.innerHTML = "City";
        cell7.innerHTML = "Area";
        var ApiURL = "<%=ApiURL%>";
        getList();
        function getList() {
            var UserId;
            var list = document.getElementById('<%= SearchBy.ClientID %>');
            var value = list.options[list.selectedIndex].value;
            var text = $('#search').val();
            if (localStorage.username == "admin")
            {
                UserId = 0;
            }
            else
            {
                UserId = localStorage.userId;
            }
            if (text.length == 0)
                text = null;
            $.ajax({
                url: ApiURL + "/api/home/getListByWhere/" + UserId + "/" + text + "/" + value,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    var rows = table.rows.length;
                    for (var i = 1; i < rows; i++) {
                        table.deleteRow(table.rows.length - 1);
                    }
                    var count = 1;
                    result.forEach(function (item) {
                        var row = table.insertRow(count);
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);
                        var cell6 = row.insertCell(5);
                        var cell7 = row.insertCell(6);
                        cell1.innerHTML = item.Firstname;
                        cell2.innerHTML = item.Lastname;
                        cell3.innerHTML = item.Mail;
                        cell4.innerHTML = item.Phone_Number;
                        cell5.innerHTML = item.Kind_Descr;
                        cell6.innerHTML = item.City_Descr;
                        cell7.innerHTML = item.Area_Descr;
                        count++;
                    });
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }
</script>
</asp:Content>
