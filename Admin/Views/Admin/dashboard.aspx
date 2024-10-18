<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Admin/AdminMaster.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Admin.Views.Admin.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet"/>
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet" />
    <!-- Tailwind CSS -->
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        /* Additional custom styles can be added here */
        .heading {
            font-weight: bold;
            font-size: 3rem; /* 30px */
        }
        .grid-view {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto">
        <div class="row">
            <div class="col">
                <h3 class="heading">Hello <%= Session["full_name"] %></h3>
            </div>
        </div>
    <h2 style="font-weight: bold; font-size: 30px;">Total Admins</h2>

        <div class="row">
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:con %>" SelectCommand="SELECT * FROM [Admin]"></asp:SqlDataSource>
            <div class="col">
                <asp:GridView CssClass="grid-view table table-striped table-bordered" ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNamesmo="" DataSourceID="SqlDataSource1">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID" HeaderStyle-CssClass="nosort">
                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="full_name" HeaderText="Name" SortExpression="full_name" HeaderStyle-CssClass="nosort">
                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" HeaderStyle-CssClass="nosort">
                            <HeaderStyle CssClass="nosort"></HeaderStyle>
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
