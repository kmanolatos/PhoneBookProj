<%@ Page Title="Cities" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Cities.aspx.cs" Inherits="Cities"  validateRequest="false" enableEventValidation="false" %>

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
            text-align: center;
        }

        tr:nth-child(1) td {
            font-weight: bolder;
        }

        table {
            position: relative;
            left: 35%;
            border: 2px solid black;
            width: 30%;
            top: 90px;
        }

        #search {
            position: relative;
            top: 50px;
            width: 30%;
            left: 38%;
        }

        #cityDescr {
            position: relative;
            width: 34%;
            left: 33%;
            top: 50px;
        }

        .ins{
            position: relative;
            width: 30%;
            top: 80px;
            left: 35%;
            height: 40px;
        }

        .upd {
            position: relative;
            width: 30%;
            height: 40px;
            top: 37px;
            left: 55%;
        }

        .del {
            height: 40px;
            position: relative;
            width: 30%;
            top: 77px;
            left: 19%;
        }

        #bg {
            position: fixed;
            top: 0;
            left: 0;
            /* Preserve aspet ratio */
            min-width: 100%;
            min-height: 100%;
        }

        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 30%;
            height: 30%;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

            .close:hover,
            .close:focus {
                color: #000;
                text-decoration: none;
                cursor: pointer;
            }
    </style>
    <div id="myModal" class="modal">

        <!-- Modal content -->
        <div class="modal-content">
            <span class="close">&times;</span>
            <input id="cityDescr" type="text">
            <asp:Button ID="ins" runat="server" CssClass="ins" Text="Insert" />
            <asp:Button ID="del" runat="server" CssClass="del" Text="Delete" />
            <asp:Button ID="upd" runat="server" CssClass="upd" Text="Update" />
        </div>

    </div>

    <img src="images/bg.jpg" id="bg" alt="">
    <input id="search" type="text" placeholder="Search" onkeyup="getList()">
    <div class="tableStyle">
        <asp:Table ID="MyTable" runat="server"></asp:Table>
    </div>
    <%string hostname = System.Configuration.ConfigurationManager.AppSettings["hostName"];%>

    <script type="text/javascript">
        var model;
        var modal = document.getElementById('myModal');
        var span = document.getElementsByClassName("close")[0];
        document.getElementsByClassName('tableStyle')[0].style.maxHeight = screen.height * 70 / 100 + "px";
        document.getElementsByTagName('input')[0].style.height = screen.height * 4 / 100 + "px";
        var table = document.getElementById('<%= MyTable.ClientID %>');
        var row = table.insertRow(0);
        var cell1 = row.insertCell(0);
        cell1.innerHTML = "Cities";
        var currentRow = table.rows[0];
        var createClickHandler = function (row) {
            return function () {
                document.getElementById("cityDescr").value = "";
                modal.style.display = "block";
                document.getElementById('<%= del.ClientID %>').style.display = "none";
                document.getElementById('<%= upd.ClientID %>').style.display = "none";
                document.getElementById('<%= ins.ClientID %>').style.display = "block";
            };
        };
        currentRow.onclick = createClickHandler(currentRow);
        var hostname = "<%=hostname%>";
        getList();
        function getList() {
            var text = $('#search').val();
            if (text.length == 0)
                text = null;
            $.ajax({
                url: hostname + "/api/city/getListByWhere/" + text,
                headers: {
                    'Content-Type': 'application/json',
                },
                type: 'GET',
                dataType: 'json',
                success: function (result) {
                    var data = result;
                    var rows = table.rows.length;
                    for (var i = 1; i < rows; i++) {
                        table.deleteRow(table.rows.length - 1);
                    }
                    var count = 1;
                    result.forEach(function (item) {
                        var row = table.insertRow(count);
                        row.id = item.Id;
                        var cell1 = row.insertCell(0);
                        cell1.innerHTML = item.City_Descr;
                        var currentRow = table.rows[count];
                        var createClickHandler = function (row) {
                            return function () {
                                $.ajax({
                                    url: hostname + "/api/city/get/id/" + row.id,
                                    headers: {
                                        'Content-Type': 'application/json',
                                    },
                                    type: 'GET',
                                    dataType: 'json',
                                    success: function (result) {
                                        model = result;
                                        modal.style.display = "block";
                                        document.getElementById('<%= del.ClientID %>').style.display = "block";
                                        document.getElementById('<%= upd.ClientID %>').style.display = "block";
                                        document.getElementById('<%= ins.ClientID %>').style.display = "none";
                                        document.getElementById("cityDescr").value = result.City_Descr;
                                    },
                                    error: function (ex) {
                                        alert(ex.statusText);
                                    }
                                });
                            };
                        };
                        currentRow.onclick = createClickHandler(currentRow);
                        count++;
                    });
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function onUpdate() {
            model.City_Descr = document.getElementById("cityDescr").value;
            $.ajax({
                url: hostname + "/api/city/update",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model,
                success: function (result) {
                    window.location.href = "Cities.aspx";
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function onDelete() {
            $.ajax({
                url: hostname + "/api/city/delete",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model,
                success: function (result) {
                    window.location.href = "Cities.aspx";
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        function onInsert()
        {
            var model = new Object();
            model.City_Descr = document.getElementById("cityDescr").value;
            $.ajax({
                url: hostname + "/api/city/insert",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
                type: 'POST',
                contentType: 'application/json',
                data: model,
                success: function (result) {
                    window.location.href = "Cities.aspx";
                },
                error: function (ex) {
                    alert(ex.statusText);
                }
            });
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        span.onclick = function () {
            modal.style.display = "none";
        }
    </script>
</asp:Content>
